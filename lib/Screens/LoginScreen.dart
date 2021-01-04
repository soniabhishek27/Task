import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:sevenbitstask/Constants/MyButton.dart';
import 'package:sevenbitstask/Constants/MyText.dart';
import 'package:sevenbitstask/Screens/Otp.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Form(
        key: _formKey,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    'Phone Authentication',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CountryCodePicker(
                      onChanged: _onCountryChange,
                      initialSelection: 'IN',
                      showCountryOnly: false,
                      alignLeft: true,
                    ),
                  ),

                  // Text('2sadasdasdasdasdasdasdasdas'),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(top:20.0),
                        child: TextFormField(
                          validator: (value)
                          {
                            return value.isEmpty ? 'Mobile Number is required' : null;


                          },
                          decoration: InputDecoration(
                            hintText: 'Phone Number',

                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          controller: _controller,
                        ),
                      ),
                    ),
                  ),

                ],

              )


            ]),
            MyButton("Next", ()
            {
              if (_formKey.currentState.validate())
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPScreen(_controller.text)));
                      }

            })
          ],
        ),
      ),
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(()
    {

      MyText.countryCode = countryCode;



    });
    print("New Country selected: " + countryCode.toString());
  }

}