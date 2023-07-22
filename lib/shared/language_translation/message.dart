import 'package:get/get.dart';
import 'package:mizaa/shared/language_translation/ar.dart';
import 'package:mizaa/shared/language_translation/En.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': Ar().messages,
        'en': En().messages,
      };
}
