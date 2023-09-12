import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/widgets/PriorityListTile.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationCalendarForm extends StatefulWidget {
  final CheckboxStateController checkboxController =
      Get.put(CheckboxStateController());
  ReservationCalendarForm({
    Key? key,
  }) : super(key: key);

  @override
  _ReservationCalendarFormState createState() =>
      _ReservationCalendarFormState();
}

class CheckboxStateController extends GetxController {
  final RxBool isChecked = false.obs;
  final RxBool isChecked2 = false.obs;
  final RxBool isChecked3 = false.obs;
}

class _ReservationCalendarFormState extends State<ReservationCalendarForm> {
  final ReservationCalendarController controller =
      Get.find<ReservationCalendarController>();
  final DateFormat dateFormat = DateFormat('yy년 MM월 dd일 EEEE');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(() => Column(
                children: [
                  TableCalendar(
                    locale: 'ko_KR',
                    focusedDay: controller.selectedDate.value,
                    firstDay: DateTime.now(), // 현재 날짜부터 선택 가능
                    lastDay: DateTime.now()
                        .add(const Duration(days: 365)), // 선택 가능한 최초 날짜
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (date, _) {
                      controller.updateSelectedDate(date);
                    },
                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.black),
                      todayDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectedDayPredicate: (date) {
                      return isSameDay(date, controller.selectedDate.value);
                    },
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false, // Remove the "2 weeks" button
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Text(
                            '날짜선택',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        final selectedDayOfWeek =
                            controller.selectedDate.value.weekday;
                        final isWeekday =
                            selectedDayOfWeek >= 1 && selectedDayOfWeek <= 5;
                        final formattedFutureDate =
                            controller.formattedNextFuture.value;

                        if (isWeekday && selectedDayOfWeek != 3) {
                          controller.isWeekendSelected.value = false;
                          return Column(
                            children: [
                              PriorityListTile(
                                title: '$formattedFutureDate 예약',
                                number: '01',
                              ),
                            ],
                          );
                        } else if (selectedDayOfWeek == 3) {
                          controller.isWeekendSelected.value = false;
                          // 수요일 선택의 경우
                          final formattedNextSaturday =
                              controller.formattedNextSaturday.value;
                          final formattedNextSunday =
                              controller.formattedNextSunday.value;
                          return Column(
                            children: [
                              CheckboxListTile(
                                title: Text('$formattedFutureDate 예약'),
                                value:
                                    widget.checkboxController.isChecked.value,
                                onChanged: (newValue) {
                                  setState(() {
                                    widget.checkboxController.isChecked.value =
                                        newValue!;
                                    print(
                                        '수요일 예약 : ${widget.checkboxController.isChecked.value}');
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text('$formattedNextSaturday 예약'),
                                value:
                                    widget.checkboxController.isChecked2.value,
                                onChanged: (newValue) {
                                  setState(() {
                                    widget.checkboxController.isChecked2.value =
                                        newValue!;
                                    print(
                                        '토요일 예약 : ${widget.checkboxController.isChecked2.value}');
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text('$formattedNextSunday 예약'),
                                value:
                                    widget.checkboxController.isChecked3.value,
                                onChanged: (newValue) {
                                  setState(() {
                                    widget.checkboxController.isChecked3.value =
                                        newValue!;
                                    print(
                                        '토요일 예약 : ${widget.checkboxController.isChecked3.value}');
                                  });
                                },
                              ),
                            ],
                          );
                        } else {
                          // 토, 일 선택시
                          controller.isWeekendSelected.value = true;
                          return const PriorityListTile(
                            title: '주말에는 예약이 불가능합니다.',
                          );
                        }
                      })
                    ],
                  ),
                ],
              )),
        )
      ],
    );
  }
}
