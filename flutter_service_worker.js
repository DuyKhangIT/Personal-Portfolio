'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "53eac7d5e57cf2ad48ef08c7bea28da4",
"version.json": "2a4bdd3370ee966319e180d97d91e050",
"index.html": "ac9f94f6e70d0272a4b8b82230c6ef21",
"/": "ac9f94f6e70d0272a4b8b82230c6ef21",
"main.dart.js": "4b0a622d05d562aa6ae37127394b9cb2",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "6ba9ba5227de2085d4accc47cce61e1f",
"icons/Icon-192.png": "e00db5fdba298e236b1137d7db56e8b5",
"icons/Icon-maskable-192.png": "e00db5fdba298e236b1137d7db56e8b5",
"icons/Icon-maskable-512.png": "313be2ecf5322c88331af3879f2af334",
"icons/Icon-512.png": "313be2ecf5322c88331af3879f2af334",
"manifest.json": "bfd20631d6570a19f006928b4df0b6a6",
"assets/AssetManifest.json": "f931b2def54e5fadfcbdc0c6917c6c1d",
"assets/NOTICES": "8d2128b441b3b5c4c18dccc9f9a6f8aa",
"assets/FontManifest.json": "bece261b96aa9913bc9722d68aeeba42",
"assets/AssetManifest.bin.json": "83c85fe11b4b627b269d8517f1808c57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "4d2a1bebca31b105cfabd5ac9cf570b4",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/svg/ic_mail.svg": "736230d436202085f4d55f18650d9e26",
"assets/assets/images/svg/ic_git.svg": "2596c7f8ad3a5870cf584db7f86c850c",
"assets/assets/images/svg/ic_telephone.svg": "3aa777200fbbaa056a9d8e7aeb2a5678",
"assets/assets/images/svg/ic_jira.svg": "84c3fdd277a70705498940cb476f1216",
"assets/assets/images/svg/ic_error.svg": "a4bcf6040efe9cb7aefc4d0c908d56ea",
"assets/assets/images/svg/ic_light_mode.svg": "201ec9f264efd138616dbca21293d230",
"assets/assets/images/svg/ic_location.svg": "5795c062d9b42c143b4bb5dcdb9b1197",
"assets/assets/images/svg/ic_home.svg": "5ad91a32b6da2d0151918aa6b6626cc8",
"assets/assets/images/svg/ic_kotlin.svg": "c87a4641aea95f81f8697aa9bd8b2bd4",
"assets/assets/images/svg/ic_nodejs.svg": "8a38d3da54571b8d343f7dbd4c754936",
"assets/assets/images/svg/ic_sql.svg": "aafcc22965c7a95738833476f3f0a4f3",
"assets/assets/images/svg/ic_java.svg": "89b7dd8645c7e6e3dbeb6053ae7410f6",
"assets/assets/images/svg/ic_flutter.svg": "491765cf8dbdfb6080b65e4daed1b7ae",
"assets/assets/images/svg/ic_socket_io.svg": "a25aaf2aab279b9f95a7fd90432047b0",
"assets/assets/images/svg/ic_translate.svg": "665ece292e57bfa2bdcfcb08fe22f669",
"assets/assets/images/svg/ic_rocketchat.svg": "06b5f6a311b45973422a011aa624b5c6",
"assets/assets/images/svg/ic_android.svg": "ef94e4511456318d8557fc946196b0ab",
"assets/assets/images/svg/ic_dart.svg": "2b7ce633b4986beafbb5dd759f5fe563",
"assets/assets/images/svg/ic_mongo.svg": "026ad1a38128cca286bcf6af285a30cf",
"assets/assets/images/svg/ic_dark_mode.svg": "dd70a1bad66380cfa2aad41a38309692",
"assets/assets/images/svg/ic_copy.svg": "8e438a3bef0d6967e218bb25283e2ae0",
"assets/assets/images/svg/ic_vscode.svg": "f3411d0ca405a4c07bcc1a541438138a",
"assets/assets/images/svg/ic_theme.svg": "a81b028c9e983588bad71e8b1df3962d",
"assets/assets/images/pdf/HuynhDuyKhang_FlutterEngineer.pdf": "9f9ad6d5051894f9869e8a3ab83e121e",
"assets/assets/images/png/ic_ecr.png": "50f6847204af538b376c037f062855c1",
"assets/assets/images/png/vi.png": "f5d2bac0bc9f4be48f0630d5485d64e0",
"assets/assets/images/png/ic_linkedin.png": "0bc3550e55053fc3b16d9c4096c01e0e",
"assets/assets/images/png/app_icon.png": "187234090e5ff75b6ccd34a83eae737c",
"assets/assets/images/png/avt.png": "845ca926e6af06efaac4a8e57b4d9c5a",
"assets/assets/images/png/en.png": "a90a800e66908047467d439a14e24dc7",
"assets/assets/images/png/ic_facebook.png": "bc538dba7efa0995251a7def2ae94c78",
"assets/assets/images/png/ic_ecaraid.png": "31aa2839301d50702f90bd27c85b342d",
"assets/assets/images/png/ic_github.png": "39166b262bbda823892ae5ffc966c71d",
"assets/assets/images/png/logo.png": "1b19e628987e573cb868ae3664c0ee08",
"assets/assets/images/png/avatars.png": "2b2f8118cf5e8b011e76c006250bb96e",
"assets/assets/images/png/ic_logo.png": "59f9360e675a5b40223f2145ad0e682c",
"assets/assets/images/gif/ic_hi.gif": "ad8453d5ea0c49bac81d88b184aa4d5f",
"assets/assets/fonts/Inter-28pt-Bold.ttf": "14080569c713459a85b1693cf7354cc0",
"assets/assets/fonts/Inter-28pt-SemiBold.ttf": "70c03908b3ab82969b38ba14745f3a54",
"assets/assets/fonts/Inter-28pt-Medium.ttf": "4bf75147230e93108702b004fdee55df",
"assets/assets/fonts/Inter-28pt-Regular.ttf": "fc20e0880f7747bb39b85f2a0722b371",
"assets/assets/translations/en-US.json": "b47a6492a723c11fb4e68253b7d82bf1",
"assets/assets/translations/vi-VN.json": "d376333d63043c1d8866631bd4921059",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
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
