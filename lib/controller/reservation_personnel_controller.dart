import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationPersonnelController extends GetxController {
  final Map<String, RxString> selectedValues = {
    'container': '4'.obs,
    'container2': '4'.obs,
    'container3': '4'.obs,
  };

  RxString getSelectedValue(String tag) {
    return selectedValues[tag]!;
  }

  void setSelectedValue(String value, String tag) {
    selectedValues[tag]!.value = value;
  }
}
