import 'package:flutter/material.dart';
import 'package:u_and_i_datepicker_practice/screen/home_screen.dart';

void main() {

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower', //기본 폰트 지정가능,
          // 따로 폰트를 지정하지 않는다면 해당 폰트로 적용됨 ,
          // 그러면 기존의 TextFamily의 sunflower 폰트를 지울 수 있음
        textTheme: TextTheme(
          headline1: TextStyle( // text 'U&I'
            color: Colors.white,
            fontFamily: 'parisienne',
            fontSize: 80.0,
          ),

          headline2: TextStyle( // text "D +"
              color: Colors.white,
              fontFamily: 'parisienne',
              fontSize: 50.0,
              fontWeight: FontWeight.w700),

            bodyText1: TextStyle( // '우리처음만난날'
              color: Colors.white,
              fontSize: 30.0,
            ),

          bodyText2: TextStyle( // 년월일
            color: Colors.white,
            fontSize: 20.0,
          ),

        )
      ),
        home: HomeScreen()
    ),
  );
}
