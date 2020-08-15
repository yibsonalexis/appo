'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/Icon-192.png": "511883f25c1ca4f445518534a302f675",
"icons/Icon-512.png": "bc31e23f8fb04d6a62250f472e27882f",
"favicon.png": "fc784a761d22837d836b0ba7e7b0f233",
"main.dart.js": "b9b5eb37d742595e063b760854e1b7e9",
"index.html": "afc5bb6a6a834a43bf5fac6df7c9559e",
"/": "afc5bb6a6a834a43bf5fac6df7c9559e",
"manifest.json": "92f66eddaae4cbaa5dd7af850471216d",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/AssetManifest.json": "b35f3b1c6eef1139500f1be107a76fdc",
"assets/NOTICES": "204ee9054ac67eab60c9d14a8e1c62fc",
"assets/assets/images/logo.png": "bc31e23f8fb04d6a62250f472e27882f",
"assets/assets/images/screenshot2.png": "ca03ff90caf53d32a315d1dd978c5d76",
"assets/assets/images/rocket.png": "39a8232eb66a662de8f7ea6a2032373e",
"assets/assets/images/screenshot9.png": "8f198e00bbfa33057a4bb05196381a4c",
"assets/assets/images/applestore.png": "c03635ae6aedd4616802eee6d53e1515",
"assets/assets/images/screenshot5.png": "68d29006d60ba008179ee8a5a7961b7e",
"assets/assets/images/screenshot4.png": "07211ef9f2a2aae423e0d85b7a9a72d8",
"assets/assets/images/bg2.png": "763ab3fd41441a104472cfb9126f4f98",
"assets/assets/images/bg1.png": "1f8e3dab6b16a97e530d59302d9942f7",
"assets/assets/images/screenshot11.png": "80ed0246880f11c99e755b095a7ee57f",
"assets/assets/images/screenshot10.png": "7a6148367c4764de5efcbccfcf701592",
"assets/assets/images/screenshot8.png": "b1afbf801768474fe88c90ff8833e8e6",
"assets/assets/images/screenshot7.png": "68a245abbe25a686e80d513adbb11aaf",
"assets/assets/images/social/instagram_.png": "be06d2915e77036dc9ccdb5d9e9108cf",
"assets/assets/images/social/linkedin.png": "edf1196401d8495e07067f861b0a1155",
"assets/assets/images/social/twitter.png": "faa8186784f6d162786c5c0eb53c4a09",
"assets/assets/images/social/youtube.png": "688896c12cc147b26cd6e1c9db2eb58b",
"assets/assets/images/social/facebook.png": "9d2f79cdfcdf767f952000893939f877",
"assets/assets/images/screenshot3.png": "016cb780e35f735787d677c27e151b3f",
"assets/assets/images/screenshot_ios1.png": "79c8e8ccfbf26899e366df0e5e6571f9",
"assets/assets/images/screenshot6.png": "42d4d445a98015fe2d50d0b4d3187829",
"assets/assets/images/screenshot1.png": "6f8acc0bf6fbd035b4ab66eb6f9a42be",
"assets/assets/images/screenshot12.png": "a5c0fa412c35967e2f0150c877705164",
"assets/assets/images/googleplay.png": "19fb58bc0e8b2117b51c2d719cc8a17a"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
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
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
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
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
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
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
