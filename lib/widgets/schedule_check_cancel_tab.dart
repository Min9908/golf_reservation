import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../config.dart';

class ScheduleCheckCancelTab extends StatefulWidget {
  ScheduleCheckCancelTab({Key? key}) : super(key: key);

  @override
  _ScheduleCheckCancelTabState createState() => _ScheduleCheckCancelTabState();
}

class _ScheduleCheckCancelTabState extends State<ScheduleCheckCancelTab> {
  List<Map<String, dynamic>> reservationData = [];
  String selectedBtn = '전체';
  String selectedSortOption = '최근일자순';

  @override
  void initState() {
    super.initState();
    _fetchReservationData();
  }

  Future<void> _fetchReservationData() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/reservation_table"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        reservationData = jsonData['reservations'].cast<Map<String, dynamic>>();
        _sortResultLogData('최근일자순');
        // 오늘의 날짜를 가져옵니다.
        final today = DateTime.now();

        if (selectedBtn == '당일') {
          // 당일 버튼을 클릭한 경우, 오늘 날짜와 스케줄 일시가 같은 데이터만 가져옵니다.
          reservationData = reservationData.where((reservation) {
            DateFormat format = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR');
            final selectedDay = format.parse(reservation['selectedDay']);
            return _isSameDate(selectedDay, today);
          }).toList();
        } else if (selectedBtn == '1주일') {
          // 1주일 버튼을 클릭한 경우, 오늘부터 1주일 후까지 스케줄 일시가 겹치는 데이터만 가져옵니다.
          final oneWeekLater = today.add(Duration(days: 7));
          reservationData = reservationData.where((reservation) {
            DateFormat format = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR');
            final selectedDay = format.parse(reservation['selectedDay']);
            return selectedDay.isAfter(today) &&
                selectedDay.isBefore(oneWeekLater);
          }).toList();
        } else if (selectedBtn == '1개월') {
          // 1개월 버튼을 클릭한 경우, 오늘부터 1개월 후까지 스케줄 일시가 겹치는 데이터만 가져옵니다.
          final oneMonthLater = today.add(Duration(days: 30));
          reservationData = reservationData.where((reservation) {
            DateFormat format = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR');
            final selectedDay = format.parse(reservation['selectedDay']);
            return selectedDay.isAfter(today) &&
                selectedDay.isBefore(oneMonthLater);
          }).toList();
        }
        debugPrint('Received data from server:');
        debugPrint(reservationData.toString());
      } else {
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _showCancelConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Center(child: Text('스케줄 취소')),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.warning, color: Colors.red, size: 48.0),
              SizedBox(height: 20),
              Text(
                '해당 스케줄 예약을 취소하시겠습니까?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            SizedBox(
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _cancelReservation(id);
                      },
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelReservation(int id) async {
    // 예약 취소 기능
    try {
      final response = await http.delete(
        // Uri.parse("${dotenv.env['BASEURL']}/reservation_cancel/$id"),
        Uri.parse("$baseUrl/reservation_cancel/$id"),
      );

      if (response.statusCode == 200) {
        // Reservation canceled successfully, you can handle the response if needed
        debugPrint('Reservation canceled for ID: $id');
        setState(() {
          reservationData.removeWhere((reservation) => reservation['id'] == id);
        });
      } else {
        // Handle HTTP error (status code other than 200)
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as network error
      debugPrint('Error: $e');
    }
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void selectBtn(String btnText) {
    setState(() {
      selectedBtn = btnText;
    });
    _fetchReservationData();
  }

  void _sortResultLogData(String option) {
    setState(() {
      selectedSortOption = option;
      if (selectedSortOption == '최근일자순') {
        reservationData.sort((a, b) {
          final DateFormat format = DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR');
          final DateTime dateA = format.parse(a['selectedDay'] + ' 09:00');
          final DateTime dateB = format.parse(b['selectedDay'] + ' 09:00');
          return dateB.compareTo(dateA);
        });
      } else if (selectedSortOption == '오래된순') {
        reservationData.sort((a, b) {
          final DateFormat format = DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR');
          final DateTime dateA = format.parse(a['selectedDay'] + ' 09:00');
          final DateTime dateB = format.parse(b['selectedDay'] + ' 09:00');
          return dateA.compareTo(dateB);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 3.0,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('당일'),
                    style: ElevatedButton.styleFrom(
                      primary: selectedBtn == '당일'
                          ? Colors.green
                          : Colors.white, // 안쪽 색깔
                      onPrimary: selectedBtn == '당일'
                          ? Colors.white
                          : Colors.black, // 글꼴 색깔
                      side: BorderSide(
                        color: selectedBtn == '당일'
                            ? Colors.green
                            : Colors.black, // 테두리 색깔
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text('당일'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('1주일'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedBtn == '1주일' ? Colors.green : Colors.white,
                      onPrimary:
                          selectedBtn == '1주일' ? Colors.white : Colors.black,
                      side: BorderSide(
                        color:
                            selectedBtn == '1주일' ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text('1주일'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('1개월'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedBtn == '1개월' ? Colors.green : Colors.white,
                      onPrimary:
                          selectedBtn == '1개월' ? Colors.white : Colors.black,
                      side: BorderSide(
                        color:
                            selectedBtn == '1개월' ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(50, 40),
                    ),
                    child: const Text('1개월'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('전체'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedBtn == '전체' ? Colors.green : Colors.white,
                      onPrimary:
                          selectedBtn == '전체' ? Colors.white : Colors.black,
                      side: BorderSide(
                        color:
                            selectedBtn == '전체' ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(50, 40),
                    ),
                    child: const Text('전체'),
                  ),
                ),
                // const Spacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${reservationData.length.toString()}건',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  PopupMenuButton<String>(
                    onSelected: _sortResultLogData,
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: '최근일자순',
                        child: Text('최근일자순'),
                      ),
                      const PopupMenuItem<String>(
                        value: '오래된순',
                        child: Text('오래된순'),
                      )
                    ],
                    child: Row(
                      children: [
                        Text('정렬: $selectedSortOption'),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reservationData.length,
                itemBuilder: (context, index) {
                  final reservation = reservationData[index];
                  final String scheduleRegistrationTime =
                      '${reservation['selectedDay']} 09:00';

                  final String reservationTimeWeekday =
                      '${reservation['nextFuture']} ${reservation['futureTime']} ${reservation['personnel']}명';

                  String reservationTimeSaturday =
                      ''; // Initialize as an empty string
                  String reservationTimeSunday =
                      ''; // Initialize as an empty string

                  // if (reservation['wednesdayCheck'] == '3') {
                  //   reservationTimeSaturday =
                  //   '${reservation['nextSaturday']}    ${reservation['saturdayTime']}                 인원: ${reservation['saturdayPersonnel']}';
                  //   reservationTimeSunday =
                  //   '${reservation['nextSunday']}    ${reservation['sundayTime']}                 인원: ${reservation['sundayPersonnel']}';
                  // }

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 10), // 오른쪽 여백을 10으로 변경
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '스케줄 일시 : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Expanded(
                              child: Text(scheduleRegistrationTime,
                                  style: TextStyle(fontSize: 13)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              color: Colors.red,
                              onPressed: () {
                                _showCancelConfirmationDialog(
                                    reservation['id']);
                              },
                            ),
                          ],
                        ),
                        const Divider(
                          // Add a divider here
                          height: 20,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '예약 일시 : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Expanded(
                              child: Text(reservationTimeWeekday,
                                  style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                        // if (reservation['wednesdayCheck'] == '3')
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text(
                        //         '예약 일시 : ',
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       Text(reservationTimeSaturday),
                        //     ],
                        //   ),
                        // if (reservation['wednesdayCheck'] == '3')
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text(
                        //         '예약 일시 : ',
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       Text(reservationTimeSunday),
                        //     ],
                        //   ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
