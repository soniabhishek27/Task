
import 'dart:io';


import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sevenbitstask/Constants/MyText.dart';
import 'package:sevenbitstask/Screens/LoginScreen.dart';
import 'package:sevenbitstask/Services/Logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home>
{

  static String name;
  static String mobileNumber;
  static String email;
  static var profile;
  File pic;



  @override
  void initState() {
    getProfileDetails();



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              Logout l = Logout();
              l.logout();
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
            },
          )
        ],
      ),
      body: name == null ? Text('Loading') : Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          elevation: 5.0,
          child: Column(

            children: [

              Container(

                height: size.height *.40,
                width: double.infinity,
                child: Image.file(pic),


              ),
              SizedBox(height: 50.0,),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   MyText('Name'),
                    MyText(name),


                  ],
                ),
              ),

              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText('Mobile Number'),
                    MyText(mobileNumber),

                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText('Email'),
                    AutoSizeText(email),


                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }




  getProfileDetails() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {

      name = preferences.getString("Name");
      email = preferences.getString("Email");
      mobileNumber = preferences.getString('Number');
      profile = preferences.getString("Image");

      pic = File(profile);


    });


  }


}