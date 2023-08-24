import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ssaksuri/const/colors.dart';
import 'package:ssaksuri/utils/data_utils.dart';

import '../model/request_item_model.dart';

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
  DateTime? date;
  bool isDone = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

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
    titleController.dispose();
    addressController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // dateController.text = DateFormat('yyyy-MM-dd').format(date);
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
                    renderTextFiled(label: '제품명', controller: titleController),
                    renderTextFiled(
                        label: '수거 희망 주소', controller: addressController),
                    renderDateFiled(label: '수거 희망 날짜'),
                    SizedBox(height: 45),
                    renderMileage(context: context),
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

  TextField renderTextFiled(
      {required String label, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      onChanged: (text) {
        setState(
          () {
            controller.text = text;
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

  TextField renderDateFiled({required String label,}) {
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
        // icon: const Icon(Icons.calendar_today_rounded),
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
            FocusManager.instance.primaryFocus?.unfocus();
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.dark(), //다크 테마
                    child: child!,
                  );
                });

            // TODO 구현하기
            if (pickedDate != null) {
              setState(() {
                date = pickedDate;
                if (date!.compareTo(DateTime.now()) >= 1) {
                  print("과거 또는 현재");
                  isDone = true;
                } else {
                  print("미래");
                  isDone = false;
                }
                dateController.text =
                    DataUtils.getDateFormatted(pickedDate: pickedDate);
                reponse.addAll({label: dateController.text});
                print(reponse);
              });
            }
            FocusManager.instance.primaryFocus?.unfocus();
          },
          icon: Icon(Icons.calendar_month),
        ),
        suffixIconColor: primaryColor,
      ),
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.dark(), //다크 테마
                child: child!,
              );
            });

        if (pickedDate != null) {
          setState(() {
            date = pickedDate;
            if (date!.compareTo(DateTime.now()) >= 0) {
              print("현재 또는 미래");
              isDone = false;
            } else {
              print("과거");
              isDone = true;
            }
            dateController.text =
                DataUtils.getDateFormatted(pickedDate: pickedDate);
            reponse.addAll({label: dateController.text});
            print(reponse);
          });
        }
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  // TODO 요청하기 누루면 hive에 데이터 저장.
  ElevatedButton renderRequestButton() {
    final user = Hive.box('info');
    int id = user.get('id');
    final data_box = Hive.box<ItemModel>('$id');

    return ElevatedButton(
      onPressed: () {
        if (titleController.text == '') {
          showToast('제품명을 적어주세요.');
          print('제품명을 적어주세요.');
        } else if (addressController.text == '') {
          showToast('주소를 적어주세요.');
          print('주소를 적어주세요.');
        } else if (date == null) {
          showToast('날짜를 정해주세요.');
          print('날짜를 적어주세요.');
        } else {
          int mileage = DataUtils.getMileageFromCategory(category: widget.category);
          final ItemModel itemModel = ItemModel(
            category: widget.category,
            itemLabel: widget.item_label,
            title: titleController.text,
            pickUpAddress: addressController.text,
            pickUpDate: date!,
            mileage:mileage,
            isDone: isDone,
          );
          // DB에 자료 넣음.
          data_box.add(itemModel);

          if(isDone){
            user.put('mileage', user.get('mileage')+mileage);
            print('누적 mileage 값 : ${user.get('mileage')}');
          }
          showToast('요청을 완료하였습니다!');
          Navigator.of(context).pop();
        }
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

  Widget renderMileage({context}) {
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
                  DataUtils.getMileageFromCategory(category: widget.category)
                      .toString(),
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

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1, //ios및웹용 시간
        textColor: Colors.black, //글자색
        fontSize: 16.0 //폰트사이즈
        );
  }
}
