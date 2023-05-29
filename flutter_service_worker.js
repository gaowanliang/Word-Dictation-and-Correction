'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "59bf3e229f228433449aafb5282e5418",
".git/config": "755bafe0ce5d0b735794a0c6073711b4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "d0396c84f889a78746c06d2c92a0e824",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "299d9d6963460aa47ac5df5350698511",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "cd8b366b8d80ccfa98ce2f0072772feb",
".git/logs/refs/heads/gh-pages": "cd8b366b8d80ccfa98ce2f0072772feb",
".git/logs/refs/remotes/Word-Dictation-and-Correction/gh-pages": "6c35d65d4d01a63a473bdab437518950",
".git/logs/refs/remotes/Word-Dictation-and-Correction/main": "ea99f03ef5c00c6689fcc27b78da6130",
".git/objects/00/c2e81a3c1575f1816daab8a913cc7f668cece4": "b692a118fa6c46c8b4f30d719fe16ba8",
".git/objects/03/c531a7a4eadfbb97e5434401927ee31890cf33": "fe6b24f60048b7f218835d95c2c650ae",
".git/objects/0b/85bcdb86bf9e9f9fda81b13cec9c9349d47d77": "77cbf4b6cc88e2471afd14a98ef2e0ed",
".git/objects/1c/869c7fa4613a451fa57e45c69751dde9b094ad": "39fc87fc9f1266a6d47a71dc914dfb8a",
".git/objects/1d/384f3748038966a5c7316223edf120dd5894dd": "a8d542276aa823dfefb8d26439e1077a",
".git/objects/1e/bf993c04c08e17a0122730f8d7ce6e139c8bad": "eeb4f0d71f24758335fe1753273ad6c2",
".git/objects/1f/686edd1465272558af328ca43cb7189a0059e6": "5e83820f6d3e5392693d45bc239b2b61",
".git/objects/23/8e1239f456ff5cace81555b7b20241b0e63ce2": "041b4ec54a784d1cf1050e1a4e3909d2",
".git/objects/26/882ed104fd5f2905b76745c6321f34f1b4fae6": "e330c4ef65b85572e2a3d9741f5d02a6",
".git/objects/35/91af41948adc8001f3586d76b91181311953fc": "c91d33b29071dcff3b2b3385383761cb",
".git/objects/37/7580cbf691d03aea79c63a3a251b1b48ac01f1": "c196d282a50e3c372b4445c6b8868297",
".git/objects/3d/7e6593f86e4325a35869f7389b1a40a39dfdd8": "8f5a0f7e61ee99b12ac413b9f9d6e824",
".git/objects/47/b6517816895b7bef13e3ac07eef9063bdb923f": "a0342a941ddc30fec229d933ea83d94b",
".git/objects/51/34e6402246228fb7f58ce8fe76727a61d99a62": "6b5e5b48febe40daec7062aecdc3b39f",
".git/objects/57/94cf990bd843110307551c2c7aa2835a3ffb42": "c3a6016058a6ff68be87592ec16ef97c",
".git/objects/58/8bbb40ee7ea7522d7f466cb1f89c0f304fe988": "4415315227359b2ee528da0889c16aa9",
".git/objects/62/a01d6826913d9efa140d2e9f4bc0f13918e607": "44ba2af6a4f05cb190463143170ae010",
".git/objects/70/010cc4761157d9d7cc2d082cf342e63fe1190a": "baf21d1dacab382149ee93266543ff40",
".git/objects/71/c17b2b92e2ba3178bf5ffa892ad872896e3837": "af82b933c82ec5234d25745655587301",
".git/objects/8e/7f4b338840099949781ab85496d7a67fae46f1": "7f2803c236e9e7d95ef6ed16a3a2bd13",
".git/objects/93/f7bf471bcd26a9c93299593413785c6aa46d5e": "32fea0126ef385995ccdf6e29cc000be",
".git/objects/ae/37803d1933c3979fd1b939ff61cc667b0b70dc": "f5c08c98e82ebd9034dbd78b64a292fa",
".git/objects/b2/2fdb2d1fa6a3bced274617d58f6ab432bb0d8b": "1b405e4dfab487f51d41422d52600614",
".git/objects/bb/ac29f5ef7a40bf14c0901bc1457724156bc0de": "1393f20f0610cabefe2d4f45865b0f54",
".git/objects/be/d9475a8eb5a708cd4f9e88d9697a7d5e4da324": "cf64a020ed2b4444d51a72caca11c7a0",
".git/objects/c7/2b0b00da9c5229f7cfc9737f3228dc16d935c2": "6702dc146a45168424edf7aeb187308c",
".git/objects/ca/726f9a5c0648c4d505d85a9bc62b9f10f18461": "e56052fa3d6a2c085191c67c5bddd098",
".git/objects/d3/15499f157d7c206029b48779baf4b8be4d3355": "6928bd0449c9418bb486a5672a47adf1",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/e6/abf8518d9e0eb2aff700e98abc361c23a3f36f": "11cd46c0d76a815d76c0f7938866d3ca",
".git/objects/e7/5e920f175da53dd6f04d858636baa25dc702f4": "0fd694d0b7477cee41611e70d0cd6732",
".git/objects/ea/ebd4fd58afce8710b21ba1d6ca00879b9a0fd6": "ff4c5026ef4183dc02e0e43046cec5c8",
".git/objects/f3/59cad6f0ccdbe3ee831b3d8d0e1a25fe06982f": "eb877ddeed759cbc520ccb0d9a16d36f",
".git/objects/pack/pack-52a9c543c9aac2d006934e9817a7595b5ed8a373.idx": "f80300751c9677cd6aec214c8a5d17d0",
".git/objects/pack/pack-52a9c543c9aac2d006934e9817a7595b5ed8a373.pack": "c1cd9e1f3ba9671e73c75c8a20e62194",
".git/refs/heads/gh-pages": "1bcc976b38798c446c1ce5885bd64dea",
".git/refs/remotes/Word-Dictation-and-Correction/gh-pages": "1bcc976b38798c446c1ce5885bd64dea",
".git/refs/remotes/Word-Dictation-and-Correction/main": "492dda387cdc73b576a4897d843253d9",
".git/refs/tags/v1.0.0": "93d7ed7bd09349e14c12f954d8ba8687",
"assets/AssetManifest.json": "6810f7d39243dc4cf7b505d92a75eb1b",
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
"index.html": "2602926d8a9f27b067766e571507b8cc",
"/": "2602926d8a9f27b067766e571507b8cc",
"main.dart.js": "cb3d7400f254331bcc74606bb4ef6b8c",
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
