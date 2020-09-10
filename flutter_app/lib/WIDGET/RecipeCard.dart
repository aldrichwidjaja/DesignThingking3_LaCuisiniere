import 'package:flutter/material.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_detail.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_title.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_image.dart';
import 'package:flutter_app/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;

  RecipeCard(
      {@required this.recipe,
        @required this.inFavorites,
        @required this.onFavoriteButtonPressed});

  @override
  Widget build(BuildContext context) {
    RawMaterialButton _buildFavoriteButton() {
      return RawMaterialButton(
        constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
        onPressed: () => onFavoriteButtonPressed(recipe.id),
        child: Icon(
          // Conditional expression:
          // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
          inFavorites == true ? Icons.favorite : Icons.favorite_border,
        ),
        elevation: 2.0,
        fillColor: Colors.white,
        shape: CircleBorder(),
      );
    }




    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new DetailScreen(recipe, inFavorites),

        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  RecipeImage(recipe.imageURL),
                  Positioned(
                    child: _buildFavoriteButton(),
                    top: 2.0,
                    right: 2.0,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10),
              child:Text(
                recipe.name,
                style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 23,
                    fontWeight: FontWeight.normal),
              ))
            ],
          ),
        ),
      ),
    );
  }
}