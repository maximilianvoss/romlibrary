/*
 * Copyright 2020 - 2021 Maximilian Voss (maximilian@voss.rocks)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <csafestring.h>
#include "../../helper/domparsing.h"
#include "romsemulator.h"
#include "mapping.h"
#include "icon.h"
#include "../urlhandling.h"
#include "src/helper/utils.h"
#include "../../helper/regex.h"

#define SHORTNAME "REN"
#define FULLNAME "https://www.romsemulator.net"
#define URL_TEMPLATE "https://romsemulator.net/roms/%system%/page/%page%/?s=%query%"

static acll_t *search(rl_system *system, char *searchString);

static void download(rl_result *item, rl_download_callback_function downloadCallbackFunction, void *appData);

static acll_t *fetchingResultItems(rl_system *system, acll_t *resultList, char *response);

static char *fetchDownloadPageLink(char *response);

static char *fetchHiddenField(char *response, char *fieldname, int variant);

static uint32_t recalcPageCount(char *response);

static rl_hoster *hoster = NULL;

rl_hoster *romsemulator_getHoster(rl_cache *cacheHandler) {
    if (hoster == NULL) {
        hoster = calloc(1, sizeof(rl_hoster));
        hoster->search = search;
        hoster->download = download;
        hoster->name = SHORTNAME;
        hoster->active = 1;
        hoster->fullname = FULLNAME;
        hoster->favicon = calloc(1, sizeof(rl_image));
        hoster->favicon->binary = romemulator_icon_data;
        hoster->favicon->size = romemulator_icon_size;
    }
    return hoster;
}

static acll_t *search(rl_system *system, char *searchString) {
    uint32_t pageCount = 1;
    uint32_t page = 1;
    char *urlTemplate = URL_TEMPLATE;

    acll_t *resultList = NULL;
    while (page <= pageCount) {
        char *url = urlhandling_substitudeVariables(urlTemplate, system, &romsemulator_deviceMapping, searchString,
                                                    page);
        if (url == NULL) {
            break;
        }

        chttp_response *response = chttp_fetch(url, NULL, GET, 1L);
        resultList = fetchingResultItems(system, resultList, response->data);

        if (pageCount == 1) {
            pageCount = recalcPageCount(response->data);
        }

        chttp_free(response);
        free(url);

        page++;
    }
    return resultList;
}

static void download(rl_result *item, rl_download_callback_function downloadCallbackFunction, void *appData) {
    if (item == NULL) {
        return;
    }
    chttp_response *detailPageResponse = chttp_fetch(item->url, NULL, GET, 1L);
    char *linkDownloadPage = fetchDownloadPageLink(detailPageResponse->data);

    chttp_response *downloadPageResponse = chttp_fetch(linkDownloadPage, NULL, GET, 1L);

    char *pid = fetchHiddenField(downloadPageResponse->data, "pid", 0);
    char *roms = fetchHiddenField(downloadPageResponse->data, "roms_download_file_nonce_field", 1);
    char *referer = fetchHiddenField(downloadPageResponse->data, "_wp_http_referer", 0);

    csafestring_t *payload = safe_create("action=roms_download_file&pid=");
    safe_strcat(payload, pid);
    safe_strcat(payload, "&roms_download_file_nonce_field=");
    safe_strcat(payload, roms);
    safe_strcat(payload, "&_wp_http_referer=");
    safe_strcat(payload, referer);

    char *filename = str_concat(item->title, ".zip");
    downloadCallbackFunction(appData, item->system, item->title, linkDownloadPage, payload->data, filename, POST);
    free(filename);

    free(pid);
    free(roms);
    free(referer);
    chttp_free(downloadPageResponse);
    free(linkDownloadPage);
    chttp_free(detailPageResponse);
    safe_destroy(payload);
}

static char *fetchHiddenField(char *response, char *fieldname, int variant) {
    char *regexStringTmpl;
    if (variant == 0) {
        regexStringTmpl = "<input type=\"[^\"]+\" name=\"%fieldname%\" value=\"([^\"]+)\"";
    } else {
        regexStringTmpl = "<input type=\"[^\"]+\" id=\"[^\"]+\" name=\"%fieldname%\" value=\"([^\"]+)\"";
    }
    char *regexString = str_replace(regexStringTmpl, "%fieldname%", fieldname);

    regexMatches_t *matches = regex_getMatches(response, regexString, 1);
    if (matches == NULL) {
        return NULL;
    }
    char *link = regex_cpyGroupText(matches, 0);
    regex_destroyMatches(matches);
    free(regexString);
    return link;
}

static char *fetchDownloadPageLink(char *response) {
    char *regexString = "<a class=\"download\" href=\"([^\"]+)\" rel=\"nofollow\" id=\"download_link\">";

    regexMatches_t *matches = regex_getMatches(response, regexString, 1);
    if (matches == NULL) {
        return NULL;
    }
    char *link = regex_cpyGroupText(matches, 0);
    regex_destroyMatches(matches);
    return link;
}

static acll_t *fetchingResultItems(rl_system *system, acll_t *resultList, char *response) {
    lxb_html_document_t *document;
    lxb_dom_collection_t *wrapperCollection = domparsing_getElementsCollectionByTagName(response, &document, "TBODY");
    lxb_dom_collection_t *gamesCollection = domparsing_createCollection(document);
    lxb_dom_collection_t *gameElementCollection = domparsing_createCollection(document);

    domparsing_findChildElementsByTagName(gamesCollection, lxb_dom_collection_element(wrapperCollection, 0), "TR", 1);

    for (size_t i = 0; i < lxb_dom_collection_length(gamesCollection); i++) {
        lxb_dom_element_t *gameParent = lxb_dom_collection_element(gamesCollection, i);
        rl_result *item = rl_result_create(system, hoster, NULL, NULL);

        domparsing_findChildElementsByTagName(gameElementCollection, gameParent, "TD", 1);

        lxb_dom_element_t *element;
        element = lxb_dom_collection_element(gameElementCollection, 0);
        rl_result_setTitle(item, domparsing_getText(element));

        element = domparser_findFirstChildElementByTagName(element, "A", 1);
        rl_result_setUrl(item, domparsing_getAttributeValue(element, "href"));

        char *text;
        element = lxb_dom_collection_element(gameElementCollection, 1);
        text = domparsing_getText(element);
        char *rating = str_replace(text, "/5", "");
        rl_result_setRating(item, rating, 5);
        free(rating);

        element = lxb_dom_collection_element(gameElementCollection, 2);
        text = domparsing_getText(element);
        rl_result_setDownloads(item, text);

        lxb_dom_collection_clean(gameElementCollection);
        resultList = acll_push(resultList, item);
    }
    lxb_dom_collection_destroy(gameElementCollection, true);
    lxb_dom_collection_destroy(gamesCollection, true);
    lxb_dom_collection_destroy(wrapperCollection, true);
    lxb_html_document_destroy(document);

    return resultList;
}

static uint32_t recalcPageCount(char *response) {
    lxb_html_document_t *document;
    lxb_dom_collection_t *navContainer = domparsing_getElementsCollectionByClassName(response, &document, "pagination");
    lxb_dom_collection_t *navItems = domparsing_createCollection(document);

    if (!lxb_dom_collection_length(navContainer)) {
        return 0;
    }

    lxb_dom_element_t *navContainerElement = lxb_dom_collection_element(navContainer, 0);
    domparsing_findChildElementsByTagName(navItems, navContainerElement, "LI", 1);

    lxb_dom_element_t *navItemElement = lxb_dom_collection_element(navItems,
                                                                   lxb_dom_collection_length(navItems) - 2);
    char *pages = domparsing_getText(navItemElement);
    int retVal = atoi(pages);

    lxb_dom_collection_destroy(navContainer, true);
    lxb_dom_collection_destroy(navItems, true);
    lxb_html_document_destroy(document);

    return retVal;
}