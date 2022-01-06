import 'ICache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Cache kullanımı için bir Cache Manager sınıfı lazy singleton oluşturuldu.
class CacheManager implements ICacheManager {
  static CacheManager? _instace;
  static CacheManager get instance {
    if (_instace != null) return _instace!;
    _instace = CacheManager._init();
    return _instace!;
  }

  late SharedPreferences prefs;
  CacheManager._init() {
    initPrefences();
  }

  Future<void> initPrefences() async {
    prefs = await SharedPreferences.getInstance();
  }

  //ICacheManager soyut sınıfından ovveride edilen cache data ekleme methodu oluşturuldu.
  @override
  Future<bool> addCacheBoolItem({String? key, bool? value}) async {
    await prefs.setBool(key!, value!);
    return value;
  }

  //ICacheManager soyut sınıfından ovveride edilen cache data çağırma methodu oluşturuldu.
  @override
  Future<bool> getCacheBoolItem({String? key}) async {
    bool? getCacheItem = prefs.getBool(key!);
    return getCacheItem ?? false;
  }
}
