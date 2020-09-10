import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Carousel_banner extends StatefulWidget {
  @override
  _Carousel_bannerState createState() => _Carousel_bannerState();
}

class _Carousel_bannerState extends State<Carousel_banner> {
  int _current = 0;
  final List<Widget> _children = [];
  List imgList = [
    'assets/images/fad1.jpg',
    'assets/images/fad2.jpg',
    'assets/images/fad3.jpg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          height: 225,
          child: CarouselSlider(
            height: 225.0,
            autoPlay: true,
            viewportFraction: 1.0,
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            autoPlayInterval: Duration(seconds: 3),
            pauseAutoPlayOnTouch: Duration(seconds: 2),
            onPageChanged: (index){
              setState(() {
                _current = index;
              });
            },
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: double.infinity,
                      child: Image.asset(i)
                  );
                },
              );
            }).toList(),
          ),
        ),
        new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imgList, (index, url) {
              return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,)
              );
            }
            )
        )
      ],
    );
  }
}
