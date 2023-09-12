import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/widgets/reservation_timeset_form.dart';

class ReservationPersonnelAndTimesetForm extends StatelessWidget {
  // 예약 주문일 지정 달력 폼
  ReservationPersonnelAndTimesetForm({Key? key}) : super(key: key);

  final ReservationCalendarController controller =
      Get.find<ReservationCalendarController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('매크로 진행일'),
            Container(
              width: 200.0,
              margin: const EdgeInsets.only(left: 10.0), // 좌우 간격 조절
              color: Colors.grey[200], // 배경색 지정
              child: TextField(
                controller: TextEditingController(
                    text: '${controller.formattedSelectedDay}'), // 초기값 지정
                enabled: false, // 수정 불가능하도록 설정
                showCursor: false, // 커서 제거
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '예약 시간',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const ReservationTimeSetForm(),
      ],
    );
  }
}
