import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_ecommerce_app/controllers/theme/ThemesController.dart';
import 'package:test_ecommerce_app/models/cart/cart_item_model/cart_item_model.dart';
import 'package:test_ecommerce_app/models/cart/cart_model/cart_model.dart';
import 'package:test_ecommerce_app/models/companies/company_adapter.dart';
import 'package:test_ecommerce_app/models/offers/offer_model_adapter.dart';
import 'package:test_ecommerce_app/models/offers/offer_options/offer_options_adapter.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/themes/Themes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/AppBinding.dart';
import 'package:test_ecommerce_app/routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/message.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

final languageBox = GetStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  String savedLanguage = languageBox.read('language') ?? 'ar';
  if(languageBox.read('language') == null){
    languageBox.write('language','ar');
  }
  await SharedPreferencesClass.init();
  await Hive.initFlutter();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(OfferModelAdapter());
  Hive.registerAdapter(OfferOptionsAdapter());
  Hive.registerAdapter(CompanyModelAdapter());
  await Hive.openBox<CartModel>('cart_box');
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(Mizaa(savedLanguage: savedLanguage));
}
class Mizaa extends StatelessWidget {
  final String savedLanguage;
  Mizaa({Key? key,required this.savedLanguage}) : super(key: key);

  final ThemesController themeController = Get.put(ThemesController());

  @override
  Widget build(BuildContext context) {
    return

      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale:  Locale(savedLanguage),
        fallbackLocale: const Locale('ar'),
        title: 'Mizaa',
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: getThemeMode(themeController.theme),
        getPages: Routes.routes,
        initialRoute: Routes.INITIAL,
        initialBinding: AppBinding(),
          builder:(context,child){
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.1);
            return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: scale), child: child!);
          }
    );
  }

  ThemeMode getThemeMode(String type) {
    ThemeMode themeMode = ThemeMode.system;
    switch (type) {
      case "system":
        themeMode = ThemeMode.system;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
    return themeMode;
  }
}
