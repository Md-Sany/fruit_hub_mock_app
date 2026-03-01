import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;

  void updateName(String newName) {
    userName.value = newName;
  }
}