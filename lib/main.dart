import 'package:flutter/services.dart';
import 'package:mizaa/controllers/notification_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mizaa/controllers/theme/ThemesController.dart';
import 'package:mizaa/models/cart/cart_item_model/cart_item_model.dart';
import 'package:mizaa/models/cart/cart_model/cart_model.dart';
import 'package:mizaa/models/companies/company_adapter.dart';
import 'package:mizaa/models/offers/offer_model_adapter.dart';
import 'package:mizaa/models/offers/offer_options/offer_options_adapter.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/themes/Themes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mizaa/AppBinding.dart';
import 'package:mizaa/routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/language_translation/message.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final languageBox = GetStorage();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  String savedLanguage = languageBox.read('language') ?? 'ar';
  if (languageBox.read('language') == null) {
    languageBox.write('language', 'ar');
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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationController.initializeLocalNotifications();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(Mizaa(savedLanguage: savedLanguage));
  });
}

// create an instance of FlutterLocalNotificationsPlugin
fln.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    fln.FlutterLocalNotificationsPlugin();

// create a method to initialize notification channels
Future<void> initNotifications() async {
  // Android-specific: create a notification channel
  const fln.AndroidNotificationChannel channel = fln.AndroidNotificationChannel(
    'default_notification_channel_id', // ID for the channel
    'default_notification_channel_id', // name of the channel
    // 'Channel description', // description of the channel
    importance: fln.Importance.high, // importance level of the notifications
  );

  // register the notification channel with the plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          fln.AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: -1,
      // message.hashCode,
      channelKey: "alerts",
      title: message.data['title'],
      body: message.data['body'],
      bigPicture:
          'https://firebasestorage.googleapis.com/v0/b/muhammadrabeapharmacy.appspot.com/o/logo%2Flogo.jpeg?alt=media&token=b061bbea-a329-4500-95f7-a83f1d208992',
      largeIcon:
          'https://firebasestorage.googleapis.com/v0/b/muhammadrabeapharmacy.appspot.com/o/logo%2Flogo.jpeg?alt=media&token=b061bbea-a329-4500-95f7-a83f1d208992',
      notificationLayout: NotificationLayout.BigPicture,
      // largeIcon: message.data['image'],
      payload: Map<String, String>.from(message.data),
      hideLargeIconOnExpand: true,
    ),
  );

  await FirebaseMessaging.onMessage.listen((event) async {
    NotificationController.startListeningNotificationEvents();
  });
  await FirebaseMessaging.instance.getInitialMessage().then((message) async {
    // print('message is id is  ${message!.messageId} , message type is ${message!.messageType} and message data ${message.data}');
  });
}

class Mizaa extends StatelessWidget {
  final String savedLanguage;
  Mizaa({Key? key, required this.savedLanguage}) : super(key: key);

  final ThemesController themeController = Get.put(ThemesController());

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Get.isDarkMode
            ? ColorConstants.darkMainColor
            : Colors.white, // navigation bar color
        systemNavigationBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: Locale(savedLanguage),
        fallbackLocale: const Locale('ar'),
        title: 'Mizaa',
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: getThemeMode(themeController.theme),
        getPages: Routes.routes,
        initialRoute: Routes.INITIAL,
        initialBinding: AppBinding(),
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.1);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!);
        });
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
