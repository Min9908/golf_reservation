import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/reservation_personnel_controller.dart';

class ReservationPersonnelForm extends StatelessWidget {
  final ReservationPersonnelController controller;
  final String tag;
  final List<String> lst = ['3', '4'];
  final List<String> name = ['3명', '4명'];

  ReservationPersonnelForm({
    required this.controller,
    required this.tag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customRadio(lst[0], tag, name[0]),
            customRadio(lst[1], tag, name[1]),
          ],
        ),
      ),
    );
  }

  Widget customRadio(String index, String tag, String name) {
    return Obx(
      () => ElevatedButton(
        onPressed: () => controller.setSelectedValue(index, tag),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            primary: controller.getSelectedValue(tag).value == index
                ? Colors.cyan
                : Colors.grey,
            fixedSize: const Size(120, 35)),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
