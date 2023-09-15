import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/reservation_personnel_controller.dart';

class ReservationPersonnelForm extends StatelessWidget {
  final ReservationPersonnelController controller;
  final String tag;

  ReservationPersonnelForm(
      {required this.controller, required this.tag, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Obx(() => Transform.scale(
                        scale: 1.3, // Adjust the scale factor as needed
                        child: Radio<String>(
                          value: '3',
                          activeColor: Colors.black,
                          groupValue: controller.getSelectedValue(tag).value,
                          onChanged: (value) {
                            controller.setSelectedValue(value!, tag);
                          },
                        ),
                      )),
                ),
                const Text(
                  '3명',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Obx(() => Transform.scale(
                        scale: 1.3, // Adjust the scale factor as needed
                        child: Radio<String>(
                          value: '4',
                          activeColor: Colors.black,
                          groupValue: controller.getSelectedValue(tag).value,
                          onChanged: (value) {
                            controller.setSelectedValue(value!, tag);
                          },
                        ),
                      )),
                ),
                const Text(
                  '4명',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
