import 'package:get/get.dart';
import 'package:realestate/screens/main_screen.dart';

List<GetPage<dynamic>>? getPages () {
  return [
    GetPage(name: MainScreen.routeName, page: () => MainScreen())
  ];
}