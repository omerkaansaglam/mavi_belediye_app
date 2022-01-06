//Uygulama görsellerini erişebilmek ve app ayağa kalktığında yüklenmesi için eager bir singleton oluşturuldu.
class ImageConstants {
  static final ImageConstants _instance = ImageConstants._init();
  static ImageConstants get instance => _instance;

  ImageConstants._init();

  //Görselleri farklı ekranlarda gösterebilmek için görselin getter ı oluşturuldu.
  String get loginBackground => toJpg("bg");

  //Görselleri jpg,png gibi dosya tiplerine işlemek ve rahat erişebilmek için bu method kullanıldı.
  //Burada sadece jpg üzerinden değerlendirildi.
  String toJpg(String name) => 'assets/images/$name.jpg';
}
