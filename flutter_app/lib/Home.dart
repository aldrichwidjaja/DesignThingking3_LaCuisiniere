import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/WIDGET/RecipeMain.dart';
import 'package:flutter_app/State.dart';
import 'package:flutter_app/recipe.dart';
import 'package:flutter_app/state_widget.dart';
import 'package:flutter_app/util/store.dart';
import 'package:flutter_app/WIDGET/carousel_banner.dart';

class MyHomePage extends StatefulWidget {

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<MyHomePage> {
  StateModel appState;
  final Recipe recipe;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;

  _HomePage(
      {@required this.recipe,
        @required this.inFavorites,
        @required this.onFavoriteButtonPressed});

  @override
  Widget build(BuildContext context, {RecipeType recipeType, List<String> ids}) {
    appState = StateWidget.of(context).state;

    CollectionReference collectionReference = Firestore.instance.collection('rekomen');
    CollectionReference col2 = Firestore.instance.collection('rekomen');
    Stream<QuerySnapshot> stream,stream2;
    // The argument recipeType is set
    // Use snapshots of all recipes if recipeType has not been passed
    stream2 = collectionReference.where('click', isGreaterThan: 0).orderBy('click',descending: true).limit(5).snapshots();
    stream = col2.limit(5).snapshots();

    return new SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Carousel_banner(),
          Container(
            padding: new EdgeInsets.all(8),
            child: new Text(
              'Trending',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            height: 160,
            // Padding before and after the list view:
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new StreamBuilder(
                    stream: stream2,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return new ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: snapshot.data.documents
                        // Check if the argument ids contains document ID if ids has been passed:
                            .where((d) => ids == null || ids.contains(d.documentID))
                            .map((document) {
                          return new RecipeMain(
                            recipe:
                            Recipe.fromMap(document.data, document.documentID),
                            inFavorites:
                            appState.favorites.contains(document.documentID),
                            onFavoriteButtonPressed: _handleFavoritesListChanged,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: new EdgeInsets.all(8),
            child: new Text(
              'Recommended',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            height: 160,
            // Padding before and after the list view:
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new StreamBuilder(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return new ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: snapshot.data.documents
                        // Check if the argument ids contains document ID if ids has been passed:
                            .where((d) => ids == null || ids.contains(d.documentID))
                            .map((document) {
                          return new RecipeMain(
                              recipe:
                              Recipe.fromMap(document.data, document.documentID),
                              inFavorites:
                              appState.favorites.contains(document.documentID),
                              onFavoriteButtonPressed: _handleFavoritesListChanged
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  void _handleFavoritesListChanged(String recipeID) {
    updateFavorites(appState.user.uid, recipeID).then((result) {
      // Update the state:
      if (result == true) {
        setState(() {
          if (!appState.favorites.contains(recipeID))
            appState.favorites.add(recipeID);
          else
            appState.favorites.remove(recipeID);
        });
      }
    });
  }
}
