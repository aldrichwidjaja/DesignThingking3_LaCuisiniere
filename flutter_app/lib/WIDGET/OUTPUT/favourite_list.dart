import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/State.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_detail.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_title.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_image.dart';
import 'package:flutter_app/WIDGET/RecipeCard.dart';
import 'package:flutter_app/recipe.dart';
import 'package:flutter_app/state_widget.dart';

class favourite_list extends StatelessWidget {
  final Recipe recipe;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;

  favourite_list({@required this.recipe,
    @required this.inFavorites,
    @required this.onFavoriteButtonPressed});

  @override
  Widget build(BuildContext context) {
    StateModel appState;
    appState = StateWidget.of(context).state;
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        title: Text("My Favourite"),
        backgroundColor: Color(0xFF00C853),
      ),
      body: _buildRecipes(ids: appState.favorites));
  }

  Padding _buildRecipes({RecipeType recipeType, List<String> ids}) {
    CollectionReference collectionReference =
    Firestore.instance.collection('rekomen');//there is error in recipes db
    Stream<QuerySnapshot> stream;

    // The argument recipeType is set
    // Use snapshots of all recipes if recipeType has not been passed
    stream = collectionReference.snapshots();

    // Define query depeneding on passed args
    return Padding(
      // Padding before and after the list view:
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: new StreamBuilder(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return new ListView(
                  children: snapshot.data.documents
                  // Check if the argument ids contains document ID if ids has been passed:
                      .where((d) => ids == null || ids.contains(d.documentID))
                      .map((document) {
                    StateModel appState;
                    appState = StateWidget.of(context).state;
                    return new RecipeCard(
                      recipe:
                      Recipe.fromMap(document.data, document.documentID),
                      inFavorites:
                      appState.favorites.contains(document.documentID)
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}