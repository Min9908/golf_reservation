import 'package:get/get.dart';

class TimePrioritiesController extends GetxController {
  final timePriorities = <RxInt>[
    1.obs,
    2.obs,
    3.obs,
  ];
  void reorderTimePriorities(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = timePriorities.removeAt(oldIndex);
    timePriorities.insert(newIndex, item);
  }
}
