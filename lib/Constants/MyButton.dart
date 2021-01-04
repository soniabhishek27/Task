import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  MyButton(this.text,@required this.onPressed);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: FlatButton(
        color: Colors.blue,
        onPressed: onPressed,
        child: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
