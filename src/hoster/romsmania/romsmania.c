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
#include "romsmania.h"
#include "mapping.h"
#include "../urlhandling.h"
#include "src/helper/utils.h"
#include "../../helper/regex.h"

#define SHORTNAME "RCC"
#define FULLNAME "https://www.romsmania.cc"
#define URL_TEMPLATE "https://romsmania.cc/roms/%system%/search?name=%query%&genre=&region=&orderBy=name&orderAsc=1&page=%page%"
#define URL_FAVICON "https://romsmania.cc/favicon.ico"

static acll_t *search(rl_system *system, char *searchString);

static void download(rl_result *item, rl_download_callback_function downloadCallbackFunction, void *appData);

static acll_t *fetchingResultItems(rl_system *system, acll_t *resultList, char *response);

static char *fetchDownloadPageLink(char *response);

static char *fetchDownloadLink(char *response);

static uint32_t recalcPageCount(char *response);

static rl_hoster *hoster = NULL;

rl_hoster *romsmania_getHoster(rl_cache *cacheHandler) {
    if (hoster == NULL) {
        hoster = calloc(1, sizeof(rl_hoster));
        hoster->name = SHORTNAME;
        hoster->fullname = FULLNAME;
        hoster->active = 1;
        hoster->search = search;
        hoster->download = download;
        hoster->cacheHandler = cacheHandler;

        chttp_response *faviconResponse = chttp_fetch(URL_FAVICON, NULL, GET, 0L);
        hoster->favicon = calloc(1, sizeof(rl_image));
        hoster->favicon->binary = calloc(faviconResponse->size, sizeof(char));
        memcpy(hoster->favicon->binary, faviconResponse->data, faviconResponse->size);
        hoster->favicon->size = faviconResponse->size;
        chttp_free(faviconResponse);
    }
    return hoster;
}

static acll_t *search(rl_system *system, char *searchString) {
    uint32_t pageCount = 1;
    uint32_t page = 1;
    char *urlTemplate = URL_TEMPLATE;

    acll_t *resultList = NULL;
    while (page <= pageCount) {
        char *url = urlhandling_substitudeVariables(urlTemplate, system, &romsmania_deviceMapping, searchString, page);
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
    char *linkDownload = fetchDownloadLink(downloadPageResponse->data);

    char *filename = str_concat(item->title, file_suffix(linkDownload));
    downloadCallbackFunction(appData, item->system, item->title, linkDownload, NULL, filename, GET);
    free(filename);

    chttp_free(downloadPageResponse);
    free(linkDownloadPage);
    chttp_free(detailPageResponse);
    free(linkDownload);
}

static char *fetchDownloadLink(char *response) {
    char *regexString = "<a class=\"wait__link\" href=\"([^\"]+)\">";

    regexMatches_t *matches = regex_getMatches(response, regexString, 1);
    if (matches == NULL) {
        return NULL;
    }
    char *link = regex_cpyGroupText(matches, 0);
    regex_destroyMatches(matches);
    return link;
}

static char *fetchDownloadPageLink(char *response) {
    char *regexString = "<a href=\"([^\"]+)\" rel=\"nofollow\" id=\"download_link\" class=\"btn is-with-ico\">";

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
        char *downloads = str_replace(text, ",", "");
        rl_result_setDownloads(item, downloads);
        free(downloads);

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
    lxb_dom_collection_t *navContainer = domparsing_getElementsCollectionByClassName(response, &document,
                                                                                     "pagination__list");
    lxb_dom_collection_t *navItem = domparsing_createCollection(document);

    if (!lxb_dom_collection_length(navContainer)) {
        return 0;
    }

    lxb_dom_element_t *navContainerElement = lxb_dom_collection_element(navContainer, 0);
    domparsing_findChildElementsByTagName(navItem, navContainerElement, "LI", 1);

    lxb_dom_element_t *navItemElement = lxb_dom_collection_element(navItem,
                                                                   lxb_dom_collection_length(navItem) - 2);
    char *pages = domparsing_getText(navItemElement);
    int retVal = atoi(pages);

    lxb_dom_collection_destroy(navContainer, true);
    lxb_dom_collection_destroy(navItem, true);
    lxb_html_document_destroy(document);

    return retVal;
}