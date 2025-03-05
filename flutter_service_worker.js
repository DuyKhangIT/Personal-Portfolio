'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4d2a1bebca31b105cfabd5ac9cf570b4",
"assets/AssetManifest.bin.json": "83c85fe11b4b627b269d8517f1808c57",
"assets/AssetManifest.json": "f931b2def54e5fadfcbdc0c6917c6c1d",
"assets/assets/fonts/Inter-28pt-Bold.ttf": "14080569c713459a85b1693cf7354cc0",
"assets/assets/fonts/Inter-28pt-Medium.ttf": "4bf75147230e93108702b004fdee55df",
"assets/assets/fonts/Inter-28pt-Regular.ttf": "fc20e0880f7747bb39b85f2a0722b371",
"assets/assets/fonts/Inter-28pt-SemiBold.ttf": "70c03908b3ab82969b38ba14745f3a54",
"assets/assets/images/gif/ic_hi.gif": "ad8453d5ea0c49bac81d88b184aa4d5f",
"assets/assets/images/pdf/HuynhDuyKhang_FlutterEngineer.pdf": "9f9ad6d5051894f9869e8a3ab83e121e",
"assets/assets/images/png/app_icon.png": "187234090e5ff75b6ccd34a83eae737c",
"assets/assets/images/png/avatars.png": "2b2f8118cf5e8b011e76c006250bb96e",
"assets/assets/images/png/avt.png": "845ca926e6af06efaac4a8e57b4d9c5a",
"assets/assets/images/png/en.png": "a90a800e66908047467d439a14e24dc7",
"assets/assets/images/png/ic_ecaraid.png": "31aa2839301d50702f90bd27c85b342d",
"assets/assets/images/png/ic_ecr.png": "50f6847204af538b376c037f062855c1",
"assets/assets/images/png/ic_facebook.png": "bc538dba7efa0995251a7def2ae94c78",
"assets/assets/images/png/ic_github.png": "39166b262bbda823892ae5ffc966c71d",
"assets/assets/images/png/ic_linkedin.png": "0bc3550e55053fc3b16d9c4096c01e0e",
"assets/assets/images/png/ic_logo.png": "59f9360e675a5b40223f2145ad0e682c",
"assets/assets/images/png/logo.png": "1b19e628987e573cb868ae3664c0ee08",
"assets/assets/images/png/vi.png": "f5d2bac0bc9f4be48f0630d5485d64e0",
"assets/assets/images/svg/ic_android.svg": "738b44bad360d874e7d2b9f1054d9638",
"assets/assets/images/svg/ic_copy.svg": "81a977054e6cd126987b405b242c2c0d",
"assets/assets/images/svg/ic_dark_mode.svg": "f41677f3f7558336452c23251f53d923",
"assets/assets/images/svg/ic_dart.svg": "b800aef6e146226148d75c79500ff35d",
"assets/assets/images/svg/ic_error.svg": "a4bcf6040efe9cb7aefc4d0c908d56ea",
"assets/assets/images/svg/ic_flutter.svg": "4c427ffa8428a93bde40268881ef261b",
"assets/assets/images/svg/ic_git.svg": "85fc8097a16a4b437e4b809fc594bb98",
"assets/assets/images/svg/ic_home.svg": "f3f162c9296c513ac8bbc824fed14598",
"assets/assets/images/svg/ic_java.svg": "e5e68eccdb67bc0f55289fcf10ff2b08",
"assets/assets/images/svg/ic_jira.svg": "4ade26ad081b688e9dcd2a4ceb399c5d",
"assets/assets/images/svg/ic_kotlin.svg": "46c2861263111f4773e5e9b4fb7f5a0f",
"assets/assets/images/svg/ic_light_mode.svg": "2d15d3ccaa3cc8580f35e6c199124270",
"assets/assets/images/svg/ic_location.svg": "613b05923e9608e8eceb3a9bf6410336",
"assets/assets/images/svg/ic_mail.svg": "ac91dd12f5d945f78550a5626c504842",
"assets/assets/images/svg/ic_mongo.svg": "0f5d2922d0c0e0be73ee8fd849936d43",
"assets/assets/images/svg/ic_nodejs.svg": "67c4daedf940aa634b4355d3a55ece06",
"assets/assets/images/svg/ic_rocketchat.svg": "191c93d0972193c93ad2d357081dc497",
"assets/assets/images/svg/ic_socket_io.svg": "af1d5df02dbd94b55b794aa21a316fba",
"assets/assets/images/svg/ic_sql.svg": "d81e50090447c6804c1e3600cd6d08b7",
"assets/assets/images/svg/ic_telephone.svg": "e44a8f6accb2603f1734f8656115efa1",
"assets/assets/images/svg/ic_theme.svg": "e94b32c743cf479f13b4908387b42a61",
"assets/assets/images/svg/ic_translate.svg": "862af9f8bc846220606c00c4123ba58b",
"assets/assets/images/svg/ic_vscode.svg": "efd2cd6514803d0dc9d841f3d26974ba",
"assets/assets/translations/en-US.json": "347fade7a632bbcd71f9b690567d31cb",
"assets/assets/translations/vi-VN.json": "fc22afc327b895dc796babeca755ab33",
"assets/FontManifest.json": "bece261b96aa9913bc9722d68aeeba42",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "f02de09d76eb1c623a408d95fc2eb2c2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "6ba9ba5227de2085d4accc47cce61e1f",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "9c4135f34486e4352f39b543a300b8f3",
"icons/Icon-192.png": "e00db5fdba298e236b1137d7db56e8b5",
"icons/Icon-512.png": "313be2ecf5322c88331af3879f2af334",
"icons/Icon-maskable-192.png": "e00db5fdba298e236b1137d7db56e8b5",
"icons/Icon-maskable-512.png": "313be2ecf5322c88331af3879f2af334",
"index.html": "9c1de2d8a022729fd702b50f689ce7e1",
"/": "9c1de2d8a022729fd702b50f689ce7e1",
"main.dart.js": "13202068428c99b265666fd1f908bd0e",
"manifest.json": "bfd20631d6570a19f006928b4df0b6a6",
"version.json": "2a4bdd3370ee966319e180d97d91e050"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
