import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ssaksuri/const/colors.dart';

class RequestBottomSheet extends StatefulWidget {
  final String category;
  final String item_label;

  const RequestBottomSheet({
    required this.category,
    required this.item_label,
    super.key,
  });

  @override
  State<RequestBottomSheet> createState() => _RequestBottomSheetState();
}

class _RequestBottomSheetState extends State<RequestBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = [];
  Map<String, String> reponse = {};
  DateTime date = DateTime.now();
  final dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dateController.addListener();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _boxContents = [
      IconButton(
        onPressed: () {
          _pickImg();
        },
        icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
          child: Icon(
            CupertinoIcons.camera,
            color: primaryColor,
          ),
        ),
      ),
      Container(),
      Container(),
      _pickedImgs.length <= 4
          ? Container()
          : FittedBox(
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle),
                child: Text(
                  '+${(_pickedImgs.length - 4).toString()}',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
    ];

    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom; // 시스템 ui 만큼 가려진 크기

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 600,
        // height: MediaQuery.of(context).size.height / 2 + bottomInset,
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 70,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${widget.category} 수거 정보 입력',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Text(
                '사진 등록하기',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              // Container(
              //   height: 100,
              //   width: 100,
              //   color: primaryColor,
              // ),
              SizedBox(
                height: 100,
                child: GridView.count(
                  padding: EdgeInsets.all(2),
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: List.generate(
                    4,
                    (index) => Container(
                      child: Center(
                        child: _boxContents[index],
                      ),
                      decoration: index <= _pickedImgs.length - 1
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      FileImage(File(_pickedImgs[index].path))))
                          : BoxDecoration(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    renderTextFiled(label: '제품명'),
                    renderTextFiled(label: '수거 희망 주소'),
                    renderDateFiled(label: '수거 희망 날짜'),
                    SizedBox(height: 45),
                    renderMileage(context),
                  ],
                ),
              ),
              renderRequestButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextField renderTextFiled({required String label}) {
    return TextField(
      onChanged: (text) {
        setState(
          () {
            reponse.addAll({label: text});
            print(reponse);
          },
        );
      },
      cursorColor: primaryColor,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkColor),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black87),
      ),
    );
  }

  TextField renderDateFiled({required String label}) {
    return TextField(
      controller: dateController,
      onChanged: (text) {
        dateController.text = date.toString();
        setState(
          () {

            reponse.addAll({label: text});
            print(reponse);
          },
        );
      },
      cursorColor: primaryColor,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkColor),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black87),
        suffixIcon: IconButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.dark(), //다크 테마
                  child: child!,
                );
              },
            );
            if (selectedDate != null) {
              setState(() {
                date = selectedDate;
              });
            }
            print('{$date.year}');
          },
          icon: Icon(Icons.calendar_month),
        ),
        suffixIconColor: primaryColor,
      ),
    );
  }

  ElevatedButton renderRequestButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return darkColor;
            }
            return primaryColor;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            //side: BorderSide(color: Colors.red) // border line color
          ),
        ),
      ),
      child: Text(
        '수거 요청하기',
      ),
    );
  }

  Widget renderMileage(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          '  예상 마일리지',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black87,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Center(
                child: Text(
                  '5,000',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: primaryColor,
                  ),
                ),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width - 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Text(
              'M',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

}
