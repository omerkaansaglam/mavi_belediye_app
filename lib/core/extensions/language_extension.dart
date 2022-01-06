//Multi language için generate olan propertylerin default dil durumu için locale getter ı oluşturuldu.
import 'package:easy_localization/easy_localization.dart';

extension StringLocalization on String {
  String get locale => this.tr();
}
