import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univ_schedule/models/univ_state.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var univState = Provider.of<UniversityState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          univState.currentUnivKoName,
          style: TextStyle(fontFamily: 'DonghyunKo', color: Colors.white),
        ),
        backgroundColor: Color(int.parse(univState.currentHexCode)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/${univState.currentUnivEnName}.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16,),
              Text(
                '${univState.currentUnivEnName}\n Schedule',
                style: TextStyle(fontFamily:'DonghyunEn',fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),

              SizedBox(height: 10),
              _buildText('추후에 종합하여 많은 수정사항을 \n보내주신 분께 소정의 기프티콘을 드립니다.\n'),
              _buildText('따라서 수정사항 or 추가일정을 보낼때 \n본인의 카톡아이디를 남겨주시기 바랍니다.\n'),


              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: univState.currentColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Text('문의\n\n', style: TextStyle(fontSize: 20),),
                    _buildText('email : kimvjgd0515@gmail.com\n'),
                    _buildText('kakao talk ID : rladh\n'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildText(String text) {
    return Text(
              text,
              style: TextStyle(fontSize: 14),
            );
  }
}

