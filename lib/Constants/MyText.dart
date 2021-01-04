import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class MyText extends StatelessWidget {

  final String text;

  MyText(this.text);

  static var countryCode;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: AutoSizeText('$text',
        maxLines: 1,
        style: TextStyle(
          fontSize: 20.0
        ),

      ),
    );
  }
}


