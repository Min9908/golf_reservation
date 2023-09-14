import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/main.dart';
import 'package:golf_regist_app/widgets/schedule_reservation_tab.dart';
import 'package:golf_regist_app/screens/login_page.dart';
import '../widgets/reservation_result_tab.dart';
import '../widgets/schedule_check_cancel_tab.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _logout() {
    // 컨트롤러 초기화
    // 로그아웃 후 처음으로 돌아가기
    Get.offAllNamed('/');
  }

  String selectedSortOption = '드비치';

  void selectSortOption(String option) {
    setState(() {
      selectedSortOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('골프 예약'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: [
                PopupMenuButton<String>(
                  onSelected: selectSortOption,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: '드비치',
                      child: Text('드비치'),
                    ),
                    const PopupMenuItem<String>(
                      value: '골프장1',
                      child: Text('골프장1'),
                    ),
                    const PopupMenuItem<String>(
                      value: '골프장2',
                      child: Text('골프장2'),
                    )
                  ],
                  child: Row(
                    children: [
                      Text('$selectedSortOption'),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white70,
                tabs: const [
                  Tab(text: '스케줄 예약'),
                  Tab(text: '스케줄 관리'),
                  Tab(text: '예약 결과'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content for the '스케줄 예약' tab (Page 1)
          ScheduleReservationTab(),
          // Content for the '스케줄 조회/취소' tab (Page 2)
          ScheduleCheckCancelTab(),
          // Content for the '예약 결과' tab (Page 3)
          ReservationResultTab(),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.info), label: '사용법'),
      //     BottomNavigationBarItem(icon: Icon(Icons.logout), label: '로그아웃'),
      //   ],
      //   onTap: (index) {
      //     if (index == 0) {
      //       showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text(
      //               "사용법",
      //               style: TextStyle(
      //                 fontSize: 21,
      //                 fontWeight: FontWeight.bold,
      //                 fontStyle: FontStyle.normal, // fontStyle을 지정
      //               ),
      //             ),
      //             content: Text(
      //               "※ 선택한 날짜 오전 9시에 예약이 진행됩니다. ※\n※ 캘린더 외의 부분을 터치 후 스크롤 해주세요. ※\n※ 설정한 시각과 가장 근접한 시각에 예약됩니다. ※\n\n1. 예약하고자 하는 날짜 선택 후 다음 버튼클릭\n\n(수요일의 경우, 예약하고자 하는 날짜를 선택하세요)\n\n2. 예약하고자 하는 시각을 설정해주세요.\n\n3. 스케줄 관리 탭에서 상세 정보 확인 가능합니다.\n(잘못 설정한 경우 X버튼을 눌러 매크로 예약취소)\n\n4. 예약 결과 탭에서 상세정보를 확인하세요.\n(실제 결과와 다른 경우, 문의부탁드립니다.)\n\n※ 예기치 않은 오류가 발생할 수 있습니다. ※\n※ 확실한 정보는 홈페이지에서 확인하셔야 합니다. ※\n※ 프로그램 오류 발견 시 문의주세요. ※",
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 fontStyle: FontStyle.normal,
      //               ),
      //             ),
      //             actions: <Widget>[
      //               TextButton(
      //                 child: Text("확인"),
      //                 onPressed: () {
      //                   Navigator.of(context).pop(); // AlertDialog 닫기
      //                 },
      //               ),
      //             ],
      //           );
      //         },
      //       );
      //     }
      //     if (index == 1) {
      //       // 로그아웃 처리 코드를 여기에 작성하세요.
      //       _logout();
      //     }
      //   },
      // ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  // backgroundImage: AssetImage('assets/image/dog.jpg'),
                  ),
              accountName: Text('testName'),
              accountEmail: Text('test@Email'),
              onDetailsPressed: () {},
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('사용법'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "사용법",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal, // fontStyle을 지정
                        ),
                      ),
                      content: Text(
                        "※ 선택한 날짜 오전 9시에 예약이 진행됩니다.\n※ 캘린더 외의 부분을 터치 후 스크롤 해주세요.\n※ 설정한 시각과 가장 근접한 시각에 예약됩니다.\n\n1. 예약하고자 하는 날짜 선택 후 다음 버튼클릭\n(수요일의 경우, 날짜를 선택하세요)\n\n2. 예약하고자 하는 시각을 설정해주세요.\n\n3. 스케줄 관리 탭에서 상세 정보 확인 가능합니다.\n(잘못 설정한 경우 X버튼을 눌러 매크로 예약취소)\n\n4. 예약 결과 탭에서 상세정보를 확인하세요.\n(실제 결과와 다른 경우, 문의부탁드립니다.)\n\n※ 예기치 않은 오류가 발생할 수 있습니다.\n※ 결과는 홈페이지에서도 확인해주세요.\n※ 프로그램 오류 발견 시 문의주세요.",
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("확인"),
                          onPressed: () {
                            Navigator.of(context).pop(); // AlertDialog 닫기
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              iconColor: Colors.purple,
              focusColor: Colors.purple,
              title: Text('로그아웃'),
              onTap: () {
                _logout();
              },
              trailing: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
