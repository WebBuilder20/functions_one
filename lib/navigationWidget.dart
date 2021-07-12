import 'package:flutter/material.dart';
import 'package:functions/pages/ImageConverter.dart';
import 'package:functions/pages/youtubeTranslator.dart';

import 'package:flutter/material.dart';


// Container(
// width: 300,
// height: size.height,
// child: Padding(
// padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),



/// https://stackoverflow.com/questions/57601220/is-it-possible-to-make-the-navigation-drawer-always-open-in-flutter
//
//
// Widget NavigationWidget(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.zero,
//       children: <Widget>[
//         // DrawerHeader(decoration: BoxDecoration(color: Colors.cyanAccent,), child: Text(''),),
//         ListTile(
//           leading: Icon(Icons.image, color: Colors.cyan),
//           title: Text('HTML 이미지 변환기', style: TextStyle(color: Colors.cyan),),
//           onTap: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => ImageConverter()))),
//         ListTile(
//           leading: Icon(Icons.play_arrow_sharp),
//           title: Text('유튜브 소스코드 에디터'),
//           onTap: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => YoutubeTrans()))),
//       ],
//     );
//   }
//
// class MenuAndContentScreen extends StatefulWidget {
//   @override
//   _MenuAndContentScreenState createState() => _MenuAndContentScreenState();
// }
//
// class _MenuAndContentScreenState extends State<MenuAndContentScreen> {
//   final _navigatorKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         color: Colors.grey[200],
//         child: Row(
//           children: [
//             MainMenu(
//               navigatorKey: _navigatorKey,
//             ),
//             Expanded(
//               child: Navigator(
//                   key: _navigatorKey,
//                   onGenerateRoute: ...
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Then somewhere in MainMenu:
// final anotherContext = navigatorKey.currentContext;
// Navigator.of(anotherContext).push(...);
