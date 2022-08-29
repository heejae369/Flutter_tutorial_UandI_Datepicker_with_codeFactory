import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  // 날짜가 변경되면 Dday도 변경되야 하기 때문에
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ); // 기본값은 현

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false, //아랫부분이 닿게 하기위해 false로 설정 true가 디폴트인데 그러면 아래가 뜬다
        child: Container(
          width: MediaQuery.of(context).size.width, // 기기가 사용할 수 있는 너비를 가져옴
          child: Column(children: [
            _TopPart(
              selectedDate: selectedDate,
              onPressed: onHeartPressed,
            ),
            _BottomPart(),
          ] //children
              ),
        ),
      ),
    );
  }

  onHeartPressed() {
    final now = DateTime.now(); // 밑에서 너무 많이 쓰이니까 여기서 변수로 만듬

    showCupertinoDialog(
        context: context,
        barrierDismissible: true, // 기본값은 False, 컨터이너 밖을 누르면 닫힘
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter, // 아래쪽 가운데에 컨테이너 정렬
            child: Container(
              color: Colors.white,
              height: 300.0, // 정렬을 설정하지 않으면 전체화면을 차지함
              // 400만큼의 높이 차지
              child: CupertinoDatePicker(
                //
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                maximumDate: DateTime(
                    // 이것만 설정하면 에러남 이유, 쿠퍼티노 데이트 피커의 처음 선택된 시간은 실행되는 순간의 현시간의 DateTime.now()다
                    // 이미 첫시작의 선택된 날짜가 maximum보다 크기에 에러가 남 그렇기에 위의 이니셜 데이트 타임
                    now.year,
                    now.month,
                    now.day),
                onDateTimeChanged: (DateTime date) {
                  print(date); // TopPart부분에 변경해야할 위젯이 있기에 topPart stateful로 수정
                  setState(() {
                    //topPart는 stateless widget으로 바뀌어서 여기서 setState할 수 없다
                    // stateful 위젯에서 변수를 변경시킬 때 빌드를 다시 실행시킬때 이 함수 사용
                    selectedDate = date;
                  });
                }, //날짜나 시간이 바뀌었을 때, 무슨 액션을 줄지
                // 시간함수의 파라미터로 DateTime date가 들어갈 것을 알 수 있다 날짜로 바꾸기에
              ),
            ),
          );
        });
  }
}

class _TopPart extends StatelessWidget {
  // selectedDate 가 위로 가면서 문제가 생김
  //아래와 같은 코드로 문제 해결 TopPart에서 selectedDate 변수는 필수이다 라고 이야기한 것과 같다,
  // 그러면 위에서 _TopPart()안에 변수를 넣어야한다
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({required this.selectedDate, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //이 위젯트리에서 가장 가까운 위젯 테마 인스턴스를 가져올 수 있다
    //Main.dart에 있는 theme는 HomeScreen보다 더 상위의 위젯에 위치해있다
    final textTheme = theme.textTheme;
    final now = DateTime.now(); // 밑에서 너무 많이 쓰이니까 여기서 변수로 만듬
    //               DateTime.now().year,
    //               DateTime.now().month,
    //               DateTime.now().day,
    //                에서 쓰일 예정
    return Expanded(
      //위에서 Expanded를 여기서 해준다 그러면 위는 깔끔
      child: Column(
        //return 키워드에 기존 자른 것 그대로 붙임
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: textTheme.headline1,
          ),
          Column(
            children: [
              Text(
                '우리처음 만난 날',
                style: textTheme.bodyText1,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                // setState() 에서 변경시킨 selectedDate 값을 바탕으로 바꿈
                style: textTheme.bodyText2,
              ),
            ],
          ),
          IconButton(
            iconSize: 80.0,
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(
                  now.year,
                  now.month,
                  now.day,
                ).difference(selectedDate).inDays + 1}',
            style: textTheme.headline2,
            // 선택한 날짜와 오늘의 날짜 차이를 입력해야함 // inDays 날짜 단위로 만들어줌 안하면 마이크로 초단위로 출력됨

          ),
        ],
      ),
    ); // return 이기에 ; 를 붙임
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Image.asset(
            'asset/img/middle_image.png')); // 254픽셀을 넘기기에 넘기지 않도록 Expanded위젯을 이용
  }
}
