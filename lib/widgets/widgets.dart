import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<dynamic> alertBox(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 20,
        title: Text(title, style: TextStyle(fontStyle: FontStyle.normal, fontSize: 13, fontWeight: FontWeight.bold),),
        content: Text(content, style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          SizedBox(height: 3),
          TextButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 3),
        ],
      );
    },
  );
}

Widget whTextField (TextEditingController controller, String hintText) {
  return Padding(
    padding: EdgeInsets.only(top: 19, bottom: 0, left: 0, right: 0),
    child: Container(
      height: 25,
      width: 80,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black45, letterSpacing: 4.0),
        textAlignVertical: TextAlignVertical.bottom,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 5,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 1.8),
          counterText:'',
          hintText: hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.5, style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan, width: 1.5, style: BorderStyle.solid)),
        ),

      ),
    ),
  );
}

int resizeCal(int oriWidth, int oriHeight, int sizeWanted, bool wantHeight) {
  /// (안바꾸는거 / 바꾸는거) * 바꾸고 싶은 숫자
  double oriRatio = wantHeight? (oriHeight / oriWidth) : (oriWidth / oriHeight);
  double ratio = double.parse(oriRatio.toStringAsFixed(2));
  int newSize = (ratio * sizeWanted).toInt();

  return newSize;
}

Future<void> copyToClipboard(TextEditingController converted) async{
  await Clipboard.setData(ClipboardData(text: converted.text));
}

