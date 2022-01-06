import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/cache/cache_constant.dart';
import 'product/cache/announcements.dart';
import 'product/mocks/announcement_mock_datas.dart';
import 'product/mocks/facilities_mock_datas.dart';
import 'product/service/cache_manager.dart';
import 'product/cache/facilities.dart';
import 'package:provider/provider.dart';
import 'core/constants/app/app_constant.dart';
import 'core/init/app-notifier/provider_list.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/theme/panache/custom_theme.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  await _init();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
      child: const MyApp(),
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.LANG_ASSET_PATH,
      startLocale: LanguageManager.instance.turkishLocale,
    ),
  ));
}

//Uygulama açılışında kullanılacak durumlar initilaize edildi.
Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Ekran Landscape durumu kapatıldı.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await EasyLocalization.ensureInitialized();
  await CacheManager.instance.initPrefences();
  await Hive.initFlutter();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //Generic Hive sınıflarının kaydedilmesi için gerekli alanlar eklendi.
  Hive.registerAdapter(FacilitiesAdapter());
  Hive.registerAdapter(AnnouncementsAdapter());
  //Proje içinde kullanılacak cache sınıfları açıldı
  Hive.openBox<Announcements>(CacheConstants.ANNOUNCEMENT_BOX);
  Hive.openBox<Facilities>(CacheConstants.FAVORITED_BOX);
  //Uygulama ilk yüklendiğinde ve açıldığında mock data eklenmesi için bu method kullanıldı.
  await isFirstAppOpened();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mavi Belediyesi Mobil Uygulaması",
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      initialRoute: '/',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: NavigationRoute.instance.routeGenerate,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}

//Hive ile ilk açılışta cache mock data oluşturulması için yazılan method api servisi olduğunda gerek kalmayabilir.
Future<void> isFirstAppOpened() async {
  bool isFirstApp = await CacheManager.instance.getCacheBoolItem(key: 'firstOpenedApp');
  Box boxFacilities = await Hive.openBox<Facilities>(CacheConstants.FACILITIES_BOX);
  Box boxAnnouncements = await Hive.openBox<Announcements>(CacheConstants.ANNOUNCEMENT_BOX);
  if (isFirstApp == null || isFirstApp == false) {
    for (var i = 0; i < FacilitiesMockData.mockFacilities.length; i++) {
      boxFacilities.put(
        i,
        Facilities(
          id: i,
          title: FacilitiesMockData.mockFacilities[i],
          isFavorited: false,
        ),
      );
    }
    for (var i = 0; i < AnnouncementsMockData.mockAnnouncementTitle.length; i++) {
      boxAnnouncements.put(
        i,
        Announcements(
          id: i,
          title: AnnouncementsMockData.mockAnnouncementTitle[i],
          description: AnnouncementsMockData.mockAnnouncementDescription[i],
        ),
      );
    }

    CacheManager.instance.addCacheBoolItem(key: 'firstOpenedApp', value: true);
  }
}
