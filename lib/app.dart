import 'package:crudusers/src/pages/home_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      smartManagement: SmartManagement.onlyBuilder,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
