import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginController extends GetxController {
  final _id = ''.obs; // set the initial value
  final _pw = ''.obs; // set the initial value

  String get id => _id.value;
  String get pw => _pw.value;

  set id(String value) => _id.value = value;
  set pw(String value) => _pw.value = value;

  @override
  void onInit() {
    super.onInit();
    // Read environment variables and assign them to the controller
    // _id.value = dotenv.env['ID'] ?? '';
    // _pw.value = dotenv.env['PW'] ?? '';
    _id.value = '01071443006';
    _pw.value = 's1823642@@';
  }

  void clear() {
    _id.value = '';
    _pw.value = '';
  }
}
