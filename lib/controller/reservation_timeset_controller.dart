import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationTimeSetController extends GetxController {
  final List<String> hourList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
  ];
  final List<String> minuteList = [
    '00',
    '05',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
  ];
  RxString selectedHour = '06'.obs;
  RxString selectedMinute = '00'.obs;

  String get formattedTime {
    return '${selectedHour.value}:${selectedMinute.value}';
  }

  void setSelectedHour(String value) {
    selectedHour.value = value;
  }

  void setSelectedMinute(String value) {
    selectedMinute.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    ever(selectedHour, (value) => debugPrint('selectedHour changed: $value'));
    ever(selectedMinute,
        (value) => debugPrint('selectedMinute changed: $value'));
  }
}
