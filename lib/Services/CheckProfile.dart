import 'package:flutter/material.dart';
import 'package:sevenbitstask/Screens/Home.dart';
import 'package:sevenbitstask/Screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckProfile extends StatefulWidget {

  static String id = 'CheckProfile';
  @override
  _CheckProfileState createState() => _CheckProfileState();
}

class _CheckProfileState extends State<CheckProfile> {


  @override
  void initState() {

    checkProfileStatus();

    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }


  checkProfileStatus() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var status = sharedPreferences.getBool("ProfileSaved") ?? false;

    if(status)
    {
      print(status);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (route) => false);

    }
    else
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
      }

  }


}
