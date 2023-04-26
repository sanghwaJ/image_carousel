import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    // 초기화 시, 이동할 페이지(index)
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    // Future.delayed와 비슷한 구조의 함수
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // page는 double?로 값을 받는데, 이는 page가 null일 수도 있고 페이지를 반만 넘긴 상태는 0.5로 인식하기 때문
      // 아래는 !로 null일 수 없음을 선언하고, double을 int로 변환하여 처리한 것
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }

      // controller.animateToPage : 어떠한 페이지로 애니메이션을 지정하는 것
      controller.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    // 메모리 issue 때문에, dispose시 controller.dispose()
    controller.dispose();

    // Timer는 백그라운드에서 계속 돌기 때문에(메모리 issue), dispose시 Timer.cancel()
    if (timer != null) {
      timer!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome : 상단의 배터리, 시간 등의 상태바 style 지정
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      // PageView는 스크롤할 수 있는 화면을 제공해 줌
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Image.asset(
                'asset/img/image_$e.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
