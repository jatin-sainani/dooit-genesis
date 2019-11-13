import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class otpPage extends StatefulWidget {
  @override
  _otpPageState createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {

  final TextEditingController controller = new TextEditingController();
  String api='http://34.93.104.9:3000/api/login';

  Future<String> recomrequest() async {


    var response = await http.post(Uri.encodeFull(api),
      headers: {
        "Accept": "applications/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },

      body: {
        "phone":"7777889167",
        "otp": controller.text
      },

      encoding: Encoding.getByName("utf-8"),

    );

    setState(()
    {

      var extractdata = jsonDecode(response.body);
      print(extractdata);
      print(controller.text);
      if (response.statusCode==200)
      {
        print("OK");
        /*Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => otpPage()));*/
      }

    }
    );

  }



  /*@override
  void initState() {
    this.recomrequest();

  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back,color: Colors.red,),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 0.0, right: 8.0, top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("Please enter 6 digit OTP sent to\nyour mobile number.", style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        child: PinCodeTextField(
                          isCupertino: false,
                          pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                          pinBoxWidth: 40,
                          maxLength: 6,
                          controller: controller,
                        )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Resend code in 00:05",
                                  style: TextStyle(color: Colors.black45, fontSize: 14),
                                  maxLines: 4,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Edit my mobile number",
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                  maxLines: 4,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          elevation: 4,
                          onPressed: () {
                            recomrequest();
                          },
                          backgroundColor: Colors.red,
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
