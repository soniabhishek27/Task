import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sevenbitstask/Constants/MyButton.dart';
import 'package:sevenbitstask/Screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget
{

  static String id = "Profile";

  @override
  _ProfileState createState() => _ProfileState();
}

TextEditingController name = TextEditingController();
TextEditingController mobile = TextEditingController();

TextEditingController email = TextEditingController();

File sampleImage;



final _formKey = GlobalKey<FormState>();



@override
void initState()
{
  // TODO: implement initState

}




class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

            sampleImage == null ?  Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: 100.0,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo,
                      size: 50.0,
                      ),
                      onPressed: () async
                      {

                        await getImage();
                      },

                    ),
                  ),
                ),
              ) : Flexible(
                child: Image.file(sampleImage,
                    height: 150.0,
                    width: 2000,
            ),
              ),
              

              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Name is required' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Name',

                ),
                keyboardType: TextInputType.text,
                controller: name,
              ),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Mobile Number is required' : null;
                },

                decoration: InputDecoration(
                  hintText: 'Mobile Number',

                ),
                keyboardType: TextInputType.number,
                controller: mobile,
              ),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Email is required' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Email Address',

                ),
                keyboardType: TextInputType.emailAddress,
                controller: email,
              ),
              SizedBox(height: 80.0,),
              // FlatButton(
              //   color: Colors.blue,
              //   onPressed: () {
              //     saveProfile();
              //
              //   },
              //   child: Text(
              //     'SAVE',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              MyButton("SAVE",(){saveProfile();} ),

            ],
          ),
        ),
      ),


    );
  }

  saveProfile() async
  {
    if (_formKey.currentState.validate())
    {
      setState(() {
        print("ture");
      });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString("Name", name.text);
      sharedPreferences.setString("Email", email.text);
      sharedPreferences.setString("Number", mobile.text);
      // sharedPreferences.setString("Profile", sampleImage.toString());


      sharedPreferences.setBool("ProfileSaved", true);


      var status = sharedPreferences.getBool("ProfileSaved") ?? false;

      if(status)
        {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);

        }


    }
  }



  Future getImage() async
  {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Image'),
            // content: Text('Click to select Image'),
            actions: <Widget>[
              FlatButton (
                child: Text('CAMERA'),
                onPressed: ()async
                {
                  var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);

                  final path = await getApplicationDocumentsDirectory();

                  var temp = path.path;

                  final File newImage = await sampleImage.copy('$temp');









                setState(() {

                    sampleImage = tempImage;
                  });
                  Navigator.pop(context);

                },
              ),
              FlatButton(
                child: Text('Gallery'),
                onPressed: ()async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);


                  sharedPreferences.setString("Image", tempImage.path);




                  setState(() {

                    sampleImage = tempImage;
                    Navigator.pop(context);

                  });


//                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
            elevation: 24.0,
          );
        });


  }

}

