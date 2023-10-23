import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationOrderCheckController extends GetxController {
  final Map<String, RxString> selectedValues = {
    'container': '1'.obs,
    'container2': '1'.obs,
    'container3': '1'.obs,
  };

  RxString getSelectedValue(String tag) {
    return selectedValues[tag]!;
  }

  void setSelectedValue(String value, String tag) {
    selectedValues[tag]!.value = value;
  }
}
