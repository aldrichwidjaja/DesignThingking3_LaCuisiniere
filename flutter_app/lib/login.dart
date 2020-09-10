import 'package:flutter/material.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/state_widget.dart';
//import 'signup.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);

    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_login_2.jpg"),
          fit: BoxFit.cover,
        ),
      );
    }

    Text _buildText() {
      return Text(
        'Recipes',
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
        Center(
        child: new Opacity(
          opacity: 1,
          child: new Image.asset(
            'assets/images/bg_login_2.jpg',
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
        )
    ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 50,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                          color: Colors.green,
                            fontSize: SizeConfig.blockSizeVertical * 9, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 200.0, 0.0, 0.0),
                    child: Text('Cuisiniere',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: SizeConfig.blockSizeVertical * 9, fontWeight: FontWeight.bold)),
                   ),
                  ],
              ),
             ),
                   SizedBox(height: SizeConfig.blockSizeVertical*25),
                    Container(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        height: 60.0,
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                                onTap: () {StateWidget.of(context).signInWithGoogle();},
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child:
                                              Container(
                                                height: 30.0,
                                        child:  Image.asset('assets/images/google_login_icon.png'),
                                    )
                                        ),
                                        SizedBox(width: 10.0),
                                        Center(
                                            child: Text(
                                              'LOGIN WITH GOOGLE',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat'),
                    )),

                              ],
    )
                                )
                            )
                        )
                    ),
                  ]
    ),
    ]));


  }
}