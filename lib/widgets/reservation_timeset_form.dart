// 예약 시간 지정 폼
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/controller/reservation_orderCheck_Controller.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller2.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller3.dart';
import 'package:golf_regist_app/controller/time_priorities_controller.dart';
import 'package:golf_regist_app/widgets/PriorityListTile.dart';
import 'package:golf_regist_app/widgets/reservation_calendar_form.dart';
import 'package:golf_regist_app/widgets/reservation_personnel_form.dart';
import 'package:golf_regist_app/widgets/reservation_orderCheck_form.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';

class ReservationTimeSetForm extends StatefulWidget {
  const ReservationTimeSetForm({Key? key}) : super(key: key);
  @override
  _ReservationTimeSetFormState createState() => _ReservationTimeSetFormState();
}

class _ReservationTimeSetFormState extends State<ReservationTimeSetForm> {
  late final ReservationTimeSetController controller;
  late final ReservationTimeSetController2 controller2;
  late final ReservationTimeSetController3 controller3;
  late final ReservationCalendarController calendarController;
  late final TimePrioritiesController prioritiesController;
  final ReservationCalendarForm calendarForm = ReservationCalendarForm();
  // late final ReservationPersonnelController personnelController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ReservationTimeSetController>();
    controller2 = Get.find<ReservationTimeSetController2>();
    controller3 = Get.find<ReservationTimeSetController3>();
    // personnelController = Get.find<ReservationPersonnelController>();

    calendarController = Get.find<ReservationCalendarController>();
    prioritiesController =
        Get.put<TimePrioritiesController>(TimePrioritiesController());
  }

  @override
  Widget build(BuildContext context) {
    print('수요일 예약 설정 : ${calendarForm.checkboxController.isChecked.value}');
    print('토요일 예약 설정 : ${calendarForm.checkboxController.isChecked2.value}');
    print('일요일 예약 설정 : ${calendarForm.checkboxController.isChecked3.value}');
    final selectedDayOfWeek = calendarController.selectedDate.value.weekday;
    if (!calendarForm.checkboxController.isChecked.value &&
        !calendarForm.checkboxController.isChecked2.value &&
        !calendarForm.checkboxController.isChecked3.value &&
        selectedDayOfWeek == 3) {
      return const AlertDialog(
        title: Center(child: Text('예약 날짜')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.warning, color: Colors.red, size: 48.0),
            SizedBox(height: 20),
            Text(
              '예약 날짜(체크박스)를 설정해주세요.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

      // return const PriorityListTile(
      //   title: '일자를 선택해 주세요.',
      // );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          // height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Obx(() {
            if (calendarController.selectedFutureDate.value.weekday == 3) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Visibility(
                    visible: calendarForm.checkboxController.isChecked.value,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${calendarController.formattedNextFuture}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCupertinoPicker(
                                controller.hourList,
                                controller.selectedHour,
                                controller.setSelectedHour,
                              ),
                              const Text(
                                ':',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _buildCupertinoPicker(
                                controller.minuteList,
                                controller.selectedMinute,
                                controller.setSelectedMinute,
                              ),
                            ],
                          ),
                          ReservationPersonnelForm(
                              controller:
                                  Get.put(ReservationPersonnelController()),
                              tag: 'container'),
                          ReservationOrderCheckForm(
                              controller:
                                  Get.put(ReservationOrderCheckController()),
                              tag: 'container'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: calendarForm.checkboxController.isChecked2.value,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${calendarController.formattedNextSaturday}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCupertinoPicker(
                                  controller2.hourList,
                                  controller2.selectedHour,
                                  controller2.setSelectedHour),
                              const Text(
                                ':',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _buildCupertinoPicker(
                                  controller2.minuteList,
                                  controller2.selectedMinute,
                                  controller2.setSelectedMinute),
                            ],
                          ),
                          ReservationPersonnelForm(
                              controller:
                                  Get.put(ReservationPersonnelController()),
                              tag: 'container2'),
                          ReservationOrderCheckForm(
                              controller:
                                  Get.put(ReservationOrderCheckController()),
                              tag: 'container2'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: calendarForm.checkboxController.isChecked3.value,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${calendarController.formattedNextSunday}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildCupertinoPicker(
                                    controller3.hourList,
                                    controller3.selectedHour,
                                    controller3.setSelectedHour),
                                const Text(
                                  ':',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _buildCupertinoPicker(
                                    controller3.minuteList,
                                    controller3.selectedMinute,
                                    controller3.setSelectedMinute),
                              ],
                            ),
                            ReservationPersonnelForm(
                                controller:
                                    Get.put(ReservationPersonnelController()),
                                tag: 'container3'),
                            ReservationOrderCheckForm(
                                controller:
                                    Get.put(ReservationOrderCheckController()),
                                tag: 'container3'),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            } else {
              return Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${calendarController.formattedNextFuture}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCupertinoPicker(
                                controller.hourList,
                                controller.selectedHour,
                                controller.setSelectedHour),
                            const Text(
                              ':',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _buildCupertinoPicker(
                                controller.minuteList,
                                controller.selectedMinute,
                                controller.setSelectedMinute),
                          ],
                        ),
                        ReservationPersonnelForm(
                            controller:
                                Get.put(ReservationPersonnelController()),
                            tag: 'container'),
                        ReservationOrderCheckForm(
                            controller:
                                Get.put(ReservationOrderCheckController()),
                            tag: 'container'),
                      ]));
            }
          }),
        )
      ],
    );
  }

  Widget _buildCupertinoPicker(List<String> itemList, RxString selectedItem,
      Function(String) setSelectedItem) {
    return Container(
      width: 120,
      height: 120,
      child: Obx(
        () => CupertinoPicker(
          scrollController: FixedExtentScrollController(
            initialItem: itemList.indexOf(selectedItem.value),
          ),
          itemExtent: 50,
          onSelectedItemChanged: (index) {
            setState(() {
              setSelectedItem(itemList[index]);
              HapticFeedback.mediumImpact();
            });
          },
          children: itemList.map((String item) {
            return Text(
              item,
              style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            );
          }).toList(),
        ),
      ),
    );
  }
}
