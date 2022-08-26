import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

bool autoPlay = true;
bool loop = true;

class YoutubeTrans extends StatefulWidget {
  final Size size;

  const YoutubeTrans(this.size, {Key? key}) : super(key: key);

  @override
  _YoutubeTransState createState() => _YoutubeTransState();
}

class _YoutubeTransState extends State<YoutubeTrans> {
  final _formKey = GlobalKey<FormState>();
  final _sourceCodeController = TextEditingController();
  final _convertedController = TextEditingController();
  final _widthValueController = TextEditingController(text: 1500.toString());
  final _heightValueController = TextEditingController(text: 800.toString());

  final _dropDownValue = ['가로 길이에 맞춤', '세로 길이에 맞춤', '사용자 맞춤 설정', '변경 없음'];
  var _selectedValue = '가로 길이에 맞춤';

  final _regID = RegExp(r'(?:youtube.com/embed/)([a-zA-Z0-9_]*)');
  var regWidth = RegExp(r'(?:width\s*=\s*)"(\d+)"');
  var regHeight = RegExp(r'(?:height\s*=\s*)"(\d+)"');

  String convertSC() {
    String sc = _sourceCodeController.text;
    int _oriWidth = int.parse(regWidth.firstMatch(sc)!.group(1)!);
    int _oriHeight = int.parse(regHeight.firstMatch(sc)!.group(1)!);
    String? _youtubeID = _regID.firstMatch(sc)!.group(1);

    if (autoPlay && loop) {
      sc = sc.replaceFirst(
          _youtubeID!, '?version=3&autoplay=1&loop=1&playlist=' + _youtubeID);
    }

    if (autoPlay && !loop) {
      sc = sc.replaceFirst(
          _youtubeID!, '?version=3&autoplay=1&playlist=' + _youtubeID);
    }

    if (loop && !autoPlay) {
      sc = sc.replaceFirst(
          _youtubeID!, '?version=3&loop=1&playlist=' + _youtubeID);
    }

    if (_selectedValue == "가로 길이에 맞춤") {
      int _wantedHeight = resizeCal(
          _oriWidth, _oriHeight, int.parse(_widthValueController.text), true);
      sc = sc.replaceAll(regWidth, 'width="${_widthValueController.text}"');
      sc = sc.replaceAll(regHeight, 'height="$_wantedHeight"');
    }
    if (_selectedValue == "세로 길이에 맞춤") {
      int _wantedWidth = resizeCal(
          _oriWidth, _oriHeight, int.parse(_heightValueController.text), false);
      sc = sc.replaceAll(regHeight, 'height="${_heightValueController.text}"');
      sc = sc.replaceAll(regWidth, 'width="$_wantedWidth"');
    }
    if (_selectedValue == "사용자 맞춤 설정") {
      sc = sc.replaceAll(regWidth, 'width="${_widthValueController.text}"');
      sc = sc.replaceAll(regHeight, 'height="${_heightValueController.text}"');
    }
    return sc;
  }

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
                    const Text("유튜브 소스코드 에디터",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 13),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.cyan),
                        // borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 6, left: 10, right: 10),
                        child: TextFormField(
                          controller: _sourceCodeController,
                          decoration: const InputDecoration(
                              hintText: '이곳에 원본 소스코드를 입력해주세요.',
                              border: InputBorder.none),
                          style: const TextStyle(fontSize: 15),
                          minLines: 12,
                          maxLines: 12,
                          autofocus: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return '원본 소스코드가 입력되어야합니다.';
                            } else if (_regID
                                    .allMatches(_sourceCodeController.text)
                                    .length >
                                1) {
                              return '다수의 소스코드를 한번에 변환할 수 없습니다.';
                            } else if (_sourceCodeController.text
                                        .trim()
                                        .split("width")
                                        .length !=
                                    2 ||
                                _sourceCodeController.text
                                        .trim()
                                        .split("height")
                                        .length !=
                                    2 ||
                                _sourceCodeController.text
                                        .trim()
                                        .split("embed/")
                                        .length !=
                                    2 ||
                                (_sourceCodeController.text
                                            .trim()
                                            .split('"')
                                            .length +
                                        _sourceCodeController.text
                                            .trim()
                                            .split("'")
                                            .length) <
                                    10 ||
                                !(_regID
                                    .hasMatch(_sourceCodeController.text)) ||
                                !(_sourceCodeController.text
                                    .contains(regWidth)) ||
                                !(_sourceCodeController.text
                                    .contains(regHeight))) {
                              return '올바른 유튜브 소스코드가 아닙니다.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          // TODO: 화면 크기 작아지면 잘리는데, 이거 70% / 30% 이런 식으로 나누는거 있었는데 찾아보기
                          Row(children: [
                            Checkbox(
                                value: loop,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      loop = value;
                                    });
                                  }
                                }),
                            const SizedBox(width: 8),
                            const Text(
                              "반복 재생",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 40),
                            Checkbox(
                                value: autoPlay,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      autoPlay = value;
                                    });
                                  }
                                }),
                            const SizedBox(width: 8),
                            const Text("자동 재생", style: TextStyle(fontSize: 15)),
                          ]),
                          Row(children: [
                            if (widget.size.width > 1220)
                            // TODO: Column 만들기
                              _resizerSetting(),
                            if (widget.size.width > 1220)
                              const SizedBox(width: 30),
                            if (widget.size.width > 1220)
                              _resizingValue(),
                          ]),
                          _confirmButton(),
                        ],
                      ),
                      Row(children: [
                        if (widget.size.width <= 1220)
                          _resizerSetting(),
                        if (widget.size.width <= 1220 && widget.size.width > 635)
                          const SizedBox(width: 30),
                        if (widget.size.width <= 1220 && widget.size.width > 635)
                          _resizingValue(),
                      ],),
                      if (widget.size.width <= 635)
                        _resizingValue(),
                    ],
                    ),

                    const SizedBox(height: 60),
                    // TODO: 변환 이후의 코드
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.grey),
                        // borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 6, left: 10, right: 10),
                        child: TextFormField(
                          controller: _convertedController,
                          decoration: const InputDecoration(
                              hintText: '변환된 소스코드가 입력될 공간입니다.',
                              border: InputBorder.none),
                          style: const TextStyle(fontSize: 15, color: Colors.black38),
                          minLines: 12,
                          maxLines: 12,
                          autofocus: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.cyan)),
                            onPressed: () {
                              copyToClipboard(_convertedController);
                              _convertedController.text.isEmpty
                                  ? alertBox(context, "복사 실패: 텍스트 상자가 비어있음",
                                      "소스코드 복사에 실패했습니다.")
                                  : alertBox(context, "복사 완료",
                                      "소스코드 복사가 정상적으로 완료되었습니다.");
                            },
                            child: const Text("소스코드 자동 복사",
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

  Widget _resizerSetting() {
    return Row(
      children: [
        const Text(
          "동영상 사이즈 변경 : ",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        const SizedBox(width: 18),
        DropdownButton(
            value: _selectedValue,
            items: _dropDownValue.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 2.8),
                    child: Text(value,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.2))),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value.toString();
              });
            }),
      ],
    );
  }

  Widget _resizingValue() {
    return Row(children: [
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
        ])
    ]);
  }

  Widget _confirmButton() {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan)),
          onPressed: () {
            _formKey.currentState!.validate();

            // TODO: 변환 기능 넣어야함
            if (_sourceCodeController.text.isEmpty == true) {
              alertBox(context, "변환 실패", "원본 소스코드가 입력되어야합니다.");
            } else if (_regID.allMatches(_sourceCodeController.text).length >
                1) {
              alertBox(context, "변환 실패", "다수의 소스코드를 한번에 변환할 수 없습니다.");
            } else if (_sourceCodeController.text
                        .trim()
                        .split("width")
                        .length !=
                    2 ||
                _sourceCodeController.text.trim().split("height").length != 2 ||
                _sourceCodeController.text.trim().split("embed/").length != 2 ||
                (_sourceCodeController.text.trim().split('"').length +
                        _sourceCodeController.text.trim().split("'").length) <
                    10 ||
                !(_regID.hasMatch(_sourceCodeController.text)) ||
                !(_sourceCodeController.text.contains(regWidth)) ||
                !(_sourceCodeController.text.contains(regHeight))) {
              alertBox(context, "변환 실패", "올바른 유튜브 소스코드가 아닙니다.");
            } else if (_selectedValue == "가로 길이에 맞춤" &&
                _widthValueController.text.isEmpty) {
              alertBox(context, "변환 실패", "변환할 영상의 가로 길이가 비어있습니다.");
            } else if (_selectedValue == "세로 길이에 맞춤" &&
                _heightValueController.text.isEmpty) {
              alertBox(context, "변환 실패", "변환할 영상의 세로 길이가 비어있습니다.");
            } else if (_selectedValue == "사용자 맞춤 설정" &&
                (_widthValueController.text.isEmpty ||
                    _heightValueController.text.isEmpty)) {
              alertBox(context, "변환 실패", "변환할 영상의 가로 혹은 세로 길이가 비어있습니다.");
            } else {
              // TODO: 변환 기능 넣어야함
              _convertedController.text = convertSC();
            }
          },
          child: Text(
            "변 환",
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}
