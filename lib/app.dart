import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:getx_connect_example/src/domain/repositories/user/user_repository.dart';

import 'src/ui/pages/home/controller/home_controller.dart';
import "src/ui/pages/home/home_page.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          binding: BindingsBuilder(() {
            Get.lazyPut(() => UserRepository());
            Get.lazyPut(() => HomeController(
                  userRepository: Get.find<UserRepository>(),
                ));
          }),
          page: () => const HomePage(),
        ),
      ],
    );
  }
}
