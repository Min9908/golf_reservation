import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationCalendarController extends GetxController {
  Rx<DateTime> selectedFutureDate =
      DateTime.now().add(const Duration(days: 14)).obs;
  Rx<DateTime> nextSaturday = DateTime.now().add(const Duration(days: 10)).obs;
  Rx<DateTime> nextSunday = DateTime.now().add(const Duration(days: 11)).obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxBool isWeekendSelected = false.obs;

  RxString formattedNextFuture = ''.obs;
  RxString formattedNextSaturday = ''.obs;
  RxString formattedNextSunday = ''.obs;
  RxString formattedSelectedDay = ''.obs;

  void updateSelectedDate(DateTime date) {
    selectedFutureDate.value = date.add(const Duration(days: 14));
    nextSaturday.value = date.add(const Duration(days: 10));
    nextSunday.value = date.add(const Duration(days: 11));
    selectedDate.value = date;

    formattedNextFuture.value =
        '${selectedFutureDate.value.year}년 ${selectedFutureDate.value.month}월 ${selectedFutureDate.value.day}일 ${_getWeekdayString(selectedFutureDate.value.weekday)}';
    formattedNextSaturday.value =
        '${nextSaturday.value.year}년 ${nextSaturday.value.month}월 ${nextSaturday.value.day}일 ${_getWeekdayString(nextSaturday.value.weekday)}';
    formattedNextSunday.value =
        '${nextSunday.value.year}년 ${nextSunday.value.month}월 ${nextSunday.value.day}일 ${_getWeekdayString(nextSunday.value.weekday)}';
    formattedSelectedDay.value =
    '${selectedDate.value.year}년 ${selectedDate.value.month}월 ${selectedDate.value.day}일 ${_getWeekdayString(selectedDate.value.weekday)}';
  }

  String _getWeekdayString(int weekday) {
    switch (weekday) {
      case 1:
        return '월요일';
      case 2:
        return '화요일';
      case 3:
        return '수요일';
      case 4:
        return '목요일';
      case 5:
        return '금요일';
      case 6:
        return '토요일';
      case 7:
        return '일요일';
      default:
        return '';
    }
  }

  @override
  void onInit() {
    super.onInit();

    final today = DateTime.now();
    isWeekendSelected.value =
        today.weekday == DateTime.saturday || today.weekday == DateTime.sunday;

    formattedNextFuture.value =
        '${selectedFutureDate.value.year}년 ${selectedFutureDate.value.month}월 ${selectedFutureDate.value.day}일 ${_getWeekdayString(selectedFutureDate.value.weekday)}';
    formattedNextSaturday.value =
        '${nextSaturday.value.year}년 ${nextSaturday.value.month}월 ${nextSaturday.value.day}일 ${_getWeekdayString(nextSaturday.value.weekday)}';
    formattedNextSunday.value =
        '${nextSunday.value.year}년 ${nextSunday.value.month}월 ${nextSunday.value.day}일 ${_getWeekdayString(nextSunday.value.weekday)}';
    formattedSelectedDay.value =
    '${selectedDate.value.year}년 ${selectedDate.value.month}월 ${selectedDate.value.day}일 ${_getWeekdayString(selectedDate.value.weekday)}';

    ever(selectedFutureDate,
        (date) => debugPrint('selectedFutureDate changed: $date'));
    ever(nextSaturday, (date) => debugPrint('nextSaturday changed: $date'));
    ever(nextSunday, (date) => debugPrint('nextSunday changed: $date'));
    ever(isWeekendSelected,
        (flag) => debugPrint('isWeekendSelected changed: $flag'));
    ever(selectedDate,
        (date) => debugPrint('selectedDate changed: $date'));
  }
}
