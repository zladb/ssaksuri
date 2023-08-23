import 'package:flutter/material.dart';
import 'package:ssaksuri/const/colors.dart';

class RequestBottomSheet extends StatelessWidget {
  final String category;
  final String item_label;

  const RequestBottomSheet({
    required this.category,
    required this.item_label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                '$category 수거 정보 입력',
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
              Container(
                height: 100,
                width: 100,
                color: primaryColor,
              ),
              SizedBox(height: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    renderTextFiled(label: '제품명'),
                    renderTextFiled(label: '수거 희망 주소'),
                    renderTextFiled(label: '수거 희망 날짜'),
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

  ElevatedButton renderRequestButton() {
    return ElevatedButton(
      onPressed: () {},
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

  Widget renderMileage(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10,),
        Text(
          '  예상 마일리지',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black87,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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
}
