import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReservationTablePage extends StatefulWidget {
  const ReservationTablePage({Key? key}) : super(key: key);

  @override
  _ReservationTablePageState createState() => _ReservationTablePageState();
}

class _ReservationTablePageState extends State<ReservationTablePage> {
  List<Map<String, dynamic>> reservationData =
      []; // List to store reservation data

  @override
  void initState() {
    super.initState();
    _fetchReservationData(); // Fetch reservation data when the page is initialized
  }

  Future<void> _fetchReservationData() async {
    try {
      final response = await http.get(
        // Uri.parse("${dotenv.env['BASEURL']}/reservation_table"),
        Uri.parse("http://192.168.250.27:5000/reservation_table"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        // Assuming the data is under the key 'reservations' in the JSON response
        reservationData = jsonData['reservations'].cast<Map<String, dynamic>>();
        setState(() {});

        debugPrint('Received data from server:');
        debugPrint(reservationData.toString());
      } else {
        // Handle HTTP error (status code other than 200)
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as JSON decoding error
      debugPrint('Error: $e');
    }
  }

  Future<void> _cancelReservation(int id) async {
    // 예약 취소 기능
    try {
      final response = await http.delete(
        // Uri.parse("${dotenv.env['BASEURL']}/reservation_cancel/$id"),
        Uri.parse("http://192.168.250.27:5000/reservation_cancel/$id"),
      );

      if (response.statusCode == 200) {
        // Reservation canceled successfully, you can handle the response if needed
        debugPrint('Reservation canceled for ID: $id');
        _fetchReservationData(); // Refresh the reservation data after cancellation
      } else {
        // Handle HTTP error (status code other than 200)
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as network error
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예약 조회 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              horizontalMargin: 10,
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Customize the heading text color
                fontSize: 16, // Customize the heading font size
              ),
              dataTextStyle: const TextStyle(
                color: Colors.black87, // Customize the data text color
                fontSize: 14, // Customize the data font size
              ),
              columns: const [
                DataColumn(label: Text('예약 취소')),
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('인원')),
                DataColumn(label: Text('예약 실행일')),
                DataColumn(label: Text('예약 지정일(14일 뒤)')),
                DataColumn(label: Text('예약 시간(14일 뒤)')),
                DataColumn(label: Text('예약 지정일(토요일)')),
                DataColumn(label: Text('예약 시간(토요일)')),
                DataColumn(label: Text('예약 지정일(일요일)')),
                DataColumn(label: Text('예약 시간(일요일)')),
                DataColumn(label: Text('3 = 수요일 예약')),
              ],
              rows: reservationData.map((reservation) {
                final int id = reservation['id'] as int;

                return DataRow(cells: [
                  DataCell(
                    ElevatedButton(
                      onPressed: () => _cancelReservation(id),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Customize the button color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8), // Customize the button padding
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.white, // Customize the text color
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text(id.toString())),
                  DataCell(Text(reservation['personnel'])),
                  DataCell(Text(reservation['selectedDay'])),
                  DataCell(Text(reservation['nextFuture'])),
                  DataCell(Text(reservation['futureTime'])),
                  DataCell(Text(reservation['nextSaturday'])),
                  DataCell(Text(reservation['saturdayTime'])),
                  DataCell(Text(reservation['nextSunday'])),
                  DataCell(Text(reservation['sundayTime'])),
                  DataCell(Text(reservation['wednesdayCheck'])),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
