import 'package:flutter/material.dart';

class PriorityListTile extends StatelessWidget {
  final String title;
  final String? number; // Make the number parameter optional by adding '?'.

  const PriorityListTile({Key? key, required this.title, this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFDEE2E6), width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            if (number != null)
              Text(
                number!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
