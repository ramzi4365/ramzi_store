



import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ramzi_store/binding/initialBinding.dart';
import 'package:ramzi_store/core/localization/chageLocal.dart';
import 'package:ramzi_store/core/localization/translation.dart';
import 'package:ramzi_store/core/services/services.dart';
import 'package:ramzi_store/routes.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initialServices();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);


    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        LocaleController controller = Get.put(LocaleController());
        return GetMaterialApp(
            translations: MyTranslation(),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            locale: controller.language,
            theme: controller.appTheme,
            initialBinding: InitialBinding(),
            //routes: routes,
            getPages: routes,
        );
    }
}


