'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "6810f7d39243dc4cf7b505d92a75eb1b",
"assets/AssetManifest.smcbin": "d925e4cb57d562e852466a09fb04ee98",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "6ae72183e8ca1909aae8391f1c808bbe",
"assets/image/1.jpeg": "90ca2beb1a3af8f2cf4ab5d6e8c737ea",
"assets/image/2.jpeg": "64d2b810612b705580366da7e0d2f00f",
"assets/image/3.jpeg": "ca524a726a89ec003634cdafd192d8a8",
"assets/image/4.jpeg": "7db27e0d263d4159153b9bc48f914f02",
"assets/image/5.jpeg": "c6063eac32781ec8afb6720f04dd5479",
"assets/image/6.jpeg": "f018aca3f7dc4bee4fdb74b70b2a68a2",
"assets/image/github.svg": "5ee6a951bbcd15ca968ae25972e7292d",
"assets/image/Icon-1152.png": "9207a26883e0a75a4b0e8422d0618681",
"assets/image/icon.png": "7264e640f3ce807ed90d7b9f31e278ea",
"assets/image/main.jpeg": "665d3f28065d21b5979c8584602fd901",
"assets/NOTICES": "f9dc1603ee107b4519d6f2cf0c461b7f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5f8b6a5b7a1c139aaef03e41a113bf2b",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "5f8b6a5b7a1c139aaef03e41a113bf2b",
"icons/Icon-512.png": "7264e640f3ce807ed90d7b9f31e278ea",
"icons/Icon-maskable-192.png": "5f8b6a5b7a1c139aaef03e41a113bf2b",
"icons/Icon-maskable-512.png": "7264e640f3ce807ed90d7b9f31e278ea",
"index.html": "b98615364f2669765e2f7fc149f84205",
"/": "b98615364f2669765e2f7fc149f84205",
"main.dart.js": "3cdefd4e569e77bdce50e13ef7c8dfb8",
"manifest.json": "30edd7ea36c60aabba68e7ae797e66e6",
"splash/img/branding-1x.png": "cb8a91bc765cccb9a4a55672d5352607",
"splash/img/branding-2x.png": "c2de756d0eb3b7f5f45e44e6d7f31102",
"splash/img/branding-3x.png": "57ca5afd89597bb2b0a673557b4bcc4d",
"splash/img/branding-4x.png": "0f07fdeb3628f5b3177a558181e426a3",
"splash/img/branding-dark-1x.png": "cb8a91bc765cccb9a4a55672d5352607",
"splash/img/branding-dark-2x.png": "c2de756d0eb3b7f5f45e44e6d7f31102",
"splash/img/branding-dark-3x.png": "57ca5afd89597bb2b0a673557b4bcc4d",
"splash/img/branding-dark-4x.png": "0f07fdeb3628f5b3177a558181e426a3",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "862483e90899a5ebf9c74206a29e6d12",
"version.json": "eb94694c18af6fc3d7562093e0939a4e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
