import 'package:flutter/material.dart';
import 'package:functions/widgets/widgets.dart';

class ImageConverter extends StatefulWidget {
  final Size size;
  const ImageConverter(this.size, {Key? key}) : super(key: key);


  @override
  _ImageConverterState createState() => _ImageConverterState();
}

class _ImageConverterState extends State<ImageConverter> {
  final _formKey = GlobalKey<FormState>();
  final _sourceCodeController = TextEditingController();
  final _convertedController = TextEditingController();
  final _widthValueController = TextEditingController();
  final _heightValueController = TextEditingController();

  final _dropDownValue = ['가로 길이에 맞춤', '세로 길이에 맞춤', '사용자 맞춤 설정'];
  var _selectedValue = '가로 길이에 맞춤';

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          color: Color(0xffe8ebed),
          child: Form(
            key: _formKey,
            child: Padding(
                padding:
                EdgeInsets.only(top: 28, bottom: 28, right: 30, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("이미지 소스코드 에디터",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 13),
                    Container(
                      // TODO:  Switches
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.cyan),
                        // borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 6, left: 10, right: 10),
                        child: TextFormField(
                          controller: _sourceCodeController,
                          decoration: InputDecoration(
                              hintText: '이곳에 원본 소스코드를 입력해주세요.',
                              border: InputBorder.none),
                          style: TextStyle(fontSize: 15),
                          minLines: 12,
                          maxLines: 12,
                          autofocus: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return '원본 이미지 소스코드가 입력되어야합니다.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          Row(children: [
                            Text(
                              "이미지 사이즈 변경 : ",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                            SizedBox(width: 18),
                            _dropDown(),
                            if (widget.size.width > 760)
                              SizedBox(width: 30),
                            if (widget.size.width > 760)
                              _setSize(),
                          ],),
                          if (widget.size.width > 760)
                            _confirmButton(),
                        ],
                      ),
                      if (widget.size.width <= 760)
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          _setSize(),
                          SizedBox(width: 35),
                          _confirmButton(),
                        ]
                        )
                    ],
                    ),

                    SizedBox(height: 60),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.grey),
                        // borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 6, left: 10, right: 10),
                        child: TextFormField(
                          controller: _convertedController,
                          decoration: InputDecoration(
                              hintText: '변환된 소스코드가 입력될 공간입니다.',
                              border: InputBorder.none),
                          style: TextStyle(fontSize: 15, color: Colors.black38),
                          minLines: 12,
                          maxLines: 12,
                          autofocus: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.cyan)),
                            onPressed: () {
                              copyToClipboard(_convertedController);
                              _convertedController.text.isEmpty
                                  ? alertBox(context, "복사 실패: 텍스트 상자가 비어있음", "소스코드 복사에 실패했습니다.")
                                  : alertBox(context, "복사 완료", "소스코드 복사가 정상적으로 완료되었습니다.");
                            },
                            child: Text("소스코드 자동 복사",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))),
                      ),
                    ]),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DropdownButton(
        value: _selectedValue,
        items: _dropDownValue.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Padding(
                padding: const EdgeInsets.only(bottom:2.8),
                child: Text(value, style: const TextStyle(color: Colors.black87, fontSize: 16.2))),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedValue = value.toString();
          });
        });
  }

  Widget _setSize() {
    return Row(
        children: [
          if (_selectedValue == "가로 길이에 맞춤")
            whTextField(_widthValueController, "가 로"),

          if (_selectedValue == "세로 길이에 맞춤")
            whTextField(_heightValueController, "세 로"),

          if (_selectedValue == "사용자 맞춤 설정")
            Row(children: [
              whTextField(_widthValueController, "가 로"),
              SizedBox(width: 14),
              Text("x"),
              SizedBox(width: 14),
              whTextField(_heightValueController, "세 로"),
            ]),
        ]);
  }

  Widget _confirmButton() {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  Colors.cyan)),
          onPressed: () {
            _formKey.currentState!.validate();
            // TODO: validator(on error -> alert) 이후 변환 코드 실
          },
          child: Text(
            "변 환",
            style:
            TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}