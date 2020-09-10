import 'package:flutter/material.dart';
import 'package:flutter_app/size_config.dart';

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String caption;
  final Function onPressed;

  SettingsButton(this.icon, this.title, this.caption, this.onPressed);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialButton(
      height: SizeConfig.blockSizeVertical * 1,
      textColor: const Color(0xFF807a6b),
      onPressed: this.onPressed,
      child: Row(
        children: <Widget>[
          Icon(this.icon),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.title),
              SizedBox(height: 5.0),
              Text(this.caption, style: Theme.of(context).textTheme.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class UpperSection extends StatelessWidget {

  final String title;
  final String image;

  UpperSection(this.title,this.image);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var color1 = Color(0xFF4CAF50);
    var color2 = Color(0xFF81C784);
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockSizeVertical * 8,
        ),
        Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  image,
                  width: 140.0,
                  height: 140.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Container(
            height: SizeConfig.blockSizeVertical * 0.1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color1, color2])),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
