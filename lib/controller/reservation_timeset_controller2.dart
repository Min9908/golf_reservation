import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationTimeSetController2 extends GetxController {
  final List<String> amPmList = ['AM', 'PM'];
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
    '12'
  ];
  final List<String> minuteList = [
    '00',
    '05',
    '10',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
  ];

  RxString selectedAmPm = 'AM'.obs;
  RxString selectedHour = '06'.obs;
  RxString selectedMinute = '00'.obs;

  String get formattedTime {
    int hour24Format = selectedAmPm.value == 'AM'
        ? int.parse(selectedHour.value)
        : int.parse(selectedHour.value) + 12;
    return '${hour24Format.toString().padLeft(2, '0')}:${selectedMinute.value}';
  }

  void setSelectedAmPm(String value) {
    selectedAmPm.value = value;
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
    ever(selectedAmPm, (value) => debugPrint('selectedAmPm2 changed: $value'));
    ever(selectedHour, (value) => debugPrint('selectedHour2 changed: $value'));
    ever(selectedMinute,
        (value) => debugPrint('selectedMinute2 changed: $value'));
  }
}
