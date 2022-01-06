import 'package:shared_preferences/shared_preferences.dart';

//Proje büyümesi durumunda SharedPreferences yerine farklı cache kullanılabilir diye soyut sınıf oluşturuldu.
abstract class ICacheManager {
  late SharedPreferences prefs;
  Future<bool> addCacheBoolItem({String key, bool value});
  Future<bool> getCacheBoolItem({String key});
}
