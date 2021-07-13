import 'package:flutter/material.dart';
import 'package:functions/pages/ImageConverter.dart';
import 'package:functions/pages/youtubeTranslator.dart';

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
        fontFamily: 'Gothic A1',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
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

    // int _currentIndex = 0;

    // void onPageChanged(int index) {
    //   setState(() {
    //     _currentIndex.value = index;
    //   });
    // }

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
          title: Text('F U N C T I O N S',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14),
              width: 300,
              height: size.height,
              child: ListView.builder(
                    itemCount: tileMenu.length,
                    itemBuilder: (_, index) {
                      // padding: EdgeInsets.zero,
                      // children: <Widget>[
                      return ListTile(
                          leading: Icon(tileMenu[index]['icon'],
                            color: (index == _currentIndex) ? Colors.cyan : Colors
                                .black54,),
                          title: Text(
                              tileMenu[index]['title'], style: TextStyle(
                              fontWeight: (_currentIndex == index) ? FontWeight.bold : FontWeight.normal,
                              color: (_currentIndex == index) ? Colors.cyan : Colors.black87),
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
            SizedBox(
              width: size.width - 300,
              height: size.height,
              child: Container(
                margin: EdgeInsets.only(
                    top: 14, bottom: 14, right: 14, left: 0),
                decoration: BoxDecoration(
                  color: Color(0xffe8ebed),
                ),
                child: PageView(
                    controller: pageController,
                    // onPageChanged: onPageChanged,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      YoutubeTrans(),
                      ImageConverter(),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}