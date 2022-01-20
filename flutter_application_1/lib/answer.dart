// ignore_for_file: prefer_const_constructors
//Nick was here
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import './setUp.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;
  final String value;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Answer(this.selectHandler, this.answerText, this.value);

  get() => value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: selectHandler,
        onLongPress: () {
          SetUpState.saveAnswer(int.parse(get()));
          print(int.parse(get()));
        },
        label: Text(
          answerText,
          textAlign: TextAlign.start,
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF500000),
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          padding: EdgeInsetsDirectional.fromSTEB(1, 5, 0, 5),
        ),
        icon: IconButton(
          padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
          alignment: Alignment.center,
          icon: Icon(Icons.star_border),
          onPressed: () {},
        ),
      ),
    );
  }
}
