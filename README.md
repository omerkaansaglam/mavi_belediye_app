# Mavi Belediyesi

## Proje Hakkında: 
- Projenin büyümesi ve genişletilebilir bir clean cod yapısında olması için gerekli Solid Prensipleri ve Design Pattern kullanıldı.
- Proje MVVM Standartlarına göre inşaa edildi ve Manage Statement için istenilen Provider kullanıldı.
- Duruma göre kullanılabilir olacağından Multi Language eklendi.
- İhtiyaç dahilinde kullanılması için Manage sınıfları, Eager ve Lazy singleton yapıları oluşturuldu. 
- Çeşitlilik ve alternatif olması için 2 farklı cache kütüphanesi kullandım.
- Model yapılarının cache de tutulması için yeni, güvenlikli ve güncel olan Hive paketi kullanıldı.
- Kullanıcı tarafında SharedPreferences için CacheManager yazıldı ve farklı bir cache yöntemi kullanılması durumu için ICacheManager soyut sınıfı oluşturuldu.
- Responsive Design için MediaQuery bağımlı erişilebilir extensionlar oluşturuldu.
- Gerekli Custom Componentler ve Atomic Widgetlar oluşturuldu.
- Navigation Service yapısı kuruldu ve gerekli navigate parametreleri oluşturuldu.
- Test için mock datalar eklendi.

## Klasör Yapısı
- asets
    - images
    - language
- lib
    -   + core
            - components
            - constants
            - extensions
            - init
    -   + features
            - models
            - viewmodels
            - views
    -   + product
            - cache
            - mocks
            - service
            - state
            - widgets
- scripts
    - cache
    - language



