import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/category/category_1.dart';
import 'package:flutter_app/category/category_2.dart';
import 'package:flutter_app/category/category_3.dart';
import 'package:flutter_app/category/category_4.dart';


class category_food extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Container(
          height: 200,
            width: double.infinity,
            child:
            FittedBox(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => category_1()));
                },
                child: Image.asset('assets/images/FOOD_BANNER-03-min.jpg'),
            ),
              fit: BoxFit.fill,)),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 200,
            width: double.infinity,
            child:
            FittedBox(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => category_2()));
                },
                child: Image.asset('assets/images/FOOD_BANNER-05-min.jpg'),
              ),
              fit: BoxFit.fill,)),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 200,
            width: double.infinity,
            child:
            FittedBox(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => category_3()));
                },
                child: Image.asset('assets/images/FOOD_BANNER-02-min.jpg'),
              ),
              fit: BoxFit.fill,)),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 200,
            width: double.infinity,
            child:
            FittedBox(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => category_4()));
                },
                child: Image.asset('assets/images/FOOD_BANNER-01-min.jpg'),
              ),
              fit: BoxFit.fill,)),
      ],
      ),

    );
  }

}