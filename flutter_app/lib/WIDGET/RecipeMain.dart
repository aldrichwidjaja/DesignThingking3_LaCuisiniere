import 'package:flutter/material.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_image.dart';
import 'package:flutter_app/recipe.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_detail.dart';


class RecipeMain extends StatelessWidget {
  final Recipe recipe;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;

  const RecipeMain({
    @required this.recipe,
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
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(
            children: <Widget>[
              InkWell(
                onTap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  new DetailScreen(recipe, inFavorites)));
                },
                child: Container(
                  width: 180,
                  height: 145,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 6),
                            blurRadius: 10
                        )
                      ]),
                  child: Column(
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
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                width: 155,
                                child: Text(
                                  recipe.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            )
                          ],
                        ),
                    ] ,
                  ),
                ),
              )
            ]
        )
    );
  }
}

