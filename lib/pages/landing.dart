import 'package:doit/pages/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

final TextEditingController controller = new TextEditingController();

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 8.0, right: 8.0, top: 80.0),
              child: ImageWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 40.0),
              child: BottomWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/logo.jpeg"),
      ),
    );
  }
}

class BottomWidget extends StatefulWidget {
  bool isPressed;


  @override
  _BottomWidgetState createState() => _BottomWidgetState();

  BottomWidget({this.isPressed = false});
}



class _BottomWidgetState extends State<BottomWidget> {


  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "BottomWidgetLanding",
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: widget.isPressed
                    ? Text(
                        "Please enter your mobile number",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "Start DOOing it with DOO.it",
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 2.2),
                      )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: 4,
                          child: Image.asset(
                            "assets/images/flag.png",
                            width: 6,
                            height: 20,
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text("+91",
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 200,
                          child: widget.isPressed?
                          TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.black,), onPressed: () {
                                controller.clear();
                              }),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    )),
                                hintText: "9415625789"),
                          ):TextField(

                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => PhoneNumberPage()));
                            },
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: "Enter your mobile number"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String api='http://34.93.104.9:3000/api/signup';

  Future<String> recomrequest() async {


    var response = await http.post(Uri.encodeFull(api),
        headers: {
          "Accept": "applications/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },

        body: {
          "phone":controller.text
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
          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => otpPage()));
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
                  bottom: 8.0, left: 8.0, right: 8.0, top: 40.0),
              child: BottomWidget(
                isPressed: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "By continuing you may recieve an SMS for verification. Message and data rates may apply.",
                          style: TextStyle(color: Colors.black45, fontSize: 12),
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.clip,
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
          ],
        ),
      ),
    );
  }
}
