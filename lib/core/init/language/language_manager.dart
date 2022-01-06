import 'package:flutter/cupertino.dart';

//Proje büyümesi durumunda multi language kullanımı ve gerekli default dili çekmek için Lazy singleton oluşturuldu.
class LanguageManager {
  static LanguageManager? _instance;

  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final turkishLocale = const Locale('tr', 'TR');
  final englishLocale = const Locale('en', 'US');

  List<Locale> get supportedLocales => [englishLocale, turkishLocale];
}
