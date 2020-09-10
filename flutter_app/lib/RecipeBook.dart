import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Home.dart';
import 'package:flutter_app/WIDGET/OUTPUT/category_food.dart';
import 'package:flutter_app/WIDGET/OUTPUT/search_func.dart';
import 'package:flutter_app/recipe.dart';
import 'package:flutter_app/WIDGET/OUTPUT/favourite_list.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/util/store.dart';
import 'package:flutter_app/WIDGET/RecipeCard.dart';
import 'package:flutter_app/State.dart';
import 'package:flutter_app/state_widget.dart';
import 'package:flutter_app/login.dart';
import 'WIDGET/setting_button.dart';

class recipebookstate extends StatefulWidget {

  @override
  RecipeBook createState() => new RecipeBook();
}

class RecipeBook extends State<recipebookstate> {
  StateModel appState;

  DefaultTabController _buildTabView({Widget body}) {
    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 4,
      child:
      Scaffold(
        appBar:
        AppBar(
          backgroundColor: Color(0xFF00C853),
          title:
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("La Cuisiniere"),
                        Spacer(),
                        Container(
                          width: 60,
                          height: 40,
                          child: FlatButton.icon(
                            label: Text(""),
                            icon: Icon(Icons.search),
                            onPressed: ()
                            {Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => new search_func(),
                              ),
                            );
                            },
                          ),
                        ),
                      ]
                  ),
                ],
              ),

            bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.trending_up, size: _iconSize)),
              Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
              Tab(icon: Icon(Icons.category, size: _iconSize)),
              Tab(icon: Icon(Icons.settings, size: _iconSize)),
            ],
        ),),
          // We set Size equal to passed height (50.0) and infinite width:
        body: Padding(
          padding: EdgeInsets.all(0.0),
          child: body,
        ),
      ),

    );
  }

  Widget _buildContent() {
    if (appState.isLoading) {
      return _buildTabView(
        body: _buildLoadingIndicator()
      );
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return _buildTabView(
        body: _buildTabsContent(),
      );
    }
  }

  Center _buildLoadingIndicator() {
    return Center(
      child:

      new CircularProgressIndicator(),
    );
  }


  Column _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        UpperSection(appState.user.displayName, appState.user.photoUrl),
        Container(
          height: SizeConfig.blockSizeVertical * 20,
          width: SizeConfig.blockSizeHorizontal * 50,
          child:
        RaisedButton(
          color: Color(0xFF00C853),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => favourite_list()),
            );
          },
          child:
          Text("My Favourite"),),),
        Spacer(),
        SettingsButton(
          Icons.exit_to_app,
          "Log out",
          appState.user.displayName,
              () async {
            await StateWidget.of(context).signOutOfGoogle();
          },
        ),
      ],
    );
  }

  TabBarView _buildTabsContent() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Padding _buildRecipes({RecipeType recipeType, List<String> ids}) {
      CollectionReference collectionReference =
      Firestore.instance.collection('rekomen');//there is error in recipes db
      Stream<QuerySnapshot> stream;
      // The argument recipeType is set
        // Use snapshots of all recipes if recipeType has not been passed
//        stream = collectionReference.snapshots();
      stream = stream = collectionReference.snapshots();

      // Define query depeneding on passed args

      return Padding(
        // Padding before and after the list view:
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child:
          Column(
              children: <Widget>[
                Expanded(
                  child: new StreamBuilder(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return _buildLoadingIndicator();
                      return new ListView(
                        children: snapshot.data.documents
                        // Check if the argument ids contains document ID if ids has been passed:
                            .where((d) => ids == null || ids.contains(d.documentID))
                            .map((document) {
                          return new RecipeCard(
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
      );
    }

    return TabBarView(
      children: [
        MyHomePage(),
        _buildRecipes(recipeType: RecipeType.Indonesian),
        category_food(),
        _buildSettings(),
      ],
    );
  }

  void _handleFavoritesListChanged(String recipeID) {
    updateFavorites(appState.user.uid, recipeID)
        .then((result) {
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    return _buildContent();
  }


}


