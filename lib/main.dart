import 'package:flutter/material.dart';
import 'package:functions/src/image_converter/image_converter.dart';
import 'package:functions/src/youtube_translator/youtube_translator.dart';

// flutter run -d chrome
// flutter build web --release

// git add .
// git commit -m "git workflow"
// git push main main

/*
git add .
git commit -m "first commit"
git push -u origin main
 */
// flutter build web --release 를 입력해야 웹용 컴파일이됨 // https://dajoonee.tistory.com/35

int _currentIndex = 0;

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'functions',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan,
        accentColor: Colors.blueGrey,
        fontFamily: 'IBMPlexSansKR',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0),
        ),
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    final pageController = PageController();

    List<Map<String, dynamic>> tileMenu = [
      {
        'title' : '유튜브 코드 에디터',
        'icon' : Icons.play_arrow_sharp,
      },
      {
        'title' : '이미지 소스코드 에디터',
        'icon' : Icons.image,
      }
    ];

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FUNCTIONS',
              style: TextStyle(fontFamily: 'IBMPlexSansKR', color: Colors.white, fontSize: 20, letterSpacing: 4.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal)),
          centerTitle: true,
        ),
        body: Row(
          children: <Widget>[
            Container(
              width: size.width < 1000 ? 68 : 280,
                child: ListView.builder(
                  // padding: EdgeInsets.symmetric(vertical: 15),
                    itemCount: tileMenu.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        tileColor: (index == _currentIndex) ? Colors.black.withOpacity(0.1) : Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(horizontal: size.width < 1000 ? 18 : 20, vertical: 8),
                            leading: Icon(tileMenu[index]['icon'], size: 35,
                                color: (index == _currentIndex) ? Colors.cyan : Colors
                                    .black38,),
                            /// 화면 작아지면 타이틀 날리기
                            title: (size.width < 1000) ? null : Text(
                              tileMenu[index]['title'], style: TextStyle(
                                fontWeight: (_currentIndex == index) ? FontWeight.bold : FontWeight.bold,
                                color: (_currentIndex == index) ? Colors.cyan : Colors.black38),
                            ),
                            onTap: () {
                              setState(() {
                                _currentIndex = index;
                              });
                              pageController.jumpToPage(_currentIndex);
                            }
                      );
                    })
            ),
            Container(
              width: size.width < 1000 ? size.width - 68 : size.width - 280,
                // margin: const EdgeInsets.only(
                //     top: 14, bottom: 14, right: 14, left: 0),
                decoration: BoxDecoration(
                  color: Color(0xffe8ebed),
                ),
                child: PageView(
                    controller: pageController,
                    // onPageChanged: onPageChanged,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      YoutubeTrans(size),
                      ImageConverter(size),
                    ]),
              ),
          ],
        ),
      ),
    );
  }
}