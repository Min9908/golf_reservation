import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationPersonnelController extends GetxController {
  final Map<String, RxString> selectedValues = {
    'container': '3'.obs,
    'container2': '3'.obs,
    'container3': '3'.obs,
  };

  RxString getSelectedValue(String tag) {
    return selectedValues[tag]!;
  }

  void setSelectedValue(String value, String tag) {
    selectedValues[tag]!.value = value;
  }
}