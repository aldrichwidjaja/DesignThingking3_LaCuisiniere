import 'package:flutter/material.dart';
import 'package:flutter_app/recipe.dart';

class RecipeTitle extends StatelessWidget {
  final Recipe recipe;
  final double padding;

  RecipeTitle(this.recipe, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.only(left: padding,top: padding,right: padding,bottom: 10.0),
      child: Column(
        // Default value for crossAxisAlignment is CrossAxisAlignment.center.
        // We want to align title and description of recipes left:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.name,
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 22.00),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}