//Navigation Service üzerinde kullanılacak işlemler için soyut sınıf oluşturuldu.
abstract class INavigationService {
  Future<void> navigateToPage({String? path, Object? data});
  Future<void> navigateToPageClear({String? path, Object? data});
}
