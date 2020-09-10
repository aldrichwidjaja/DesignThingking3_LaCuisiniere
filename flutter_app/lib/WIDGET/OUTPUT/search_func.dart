import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/State.dart';
import 'package:flutter_app/WIDGET/RecipeCard.dart';
import 'package:flutter_app/recipe.dart';
import 'package:flutter_app/state_widget.dart';

class search_func extends StatefulWidget {
  final Recipe recipe;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;
  final String textinput;

  const search_func({Key key, this.recipe, this.inFavorites, this.onFavoriteButtonPressed, this.textinput, }) : super(key: key);


  @override
  search_func_state createState() => search_func_state(textinput);
}

class search_func_state extends State<search_func> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String textinput;

  Stream<QuerySnapshot> stream;

  search_func_state(this.textinput);


  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = new TextEditingController();
    double width = MediaQuery.of(context).size.width;
    StateModel appState;
    appState = StateWidget.of(context).state;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xFF00C853),
        title:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Container(
              width: width-140,
              child: TextFormField(
                controller: emailController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: "Input your recipe you looking for",
                      labelText: 'What are you looking for?'
                  ),
                validator: (value){
                    if(value.isEmpty){
                      return 'Please enter something';
                    }
                    return null;
                },
                onFieldSubmitted: (value){
                  setState(() {
                    value = value;
                    textinput = value;
                  });
                  refreshIndicatorKey.currentState.show();

                    InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Input your recipe you looking for",
                        labelText: value
                    );
                },
              ),
          ),
            ],
        )
        ),
      body:
      content(emailController)
    );
  }

  Widget content(TextEditingController mamat){
    CollectionReference collectionReferences =
    Firestore.instance.collection('rekomen');
    //add good query or maybe seperate with list and capitalize
    stream = collectionReferences.where("name",isEqualTo: this.textinput).snapshots();

    List<String> ids;
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
               return RefreshIndicator(
                  key: refreshIndicatorKey,
                  onRefresh: refreshList,
                  child:
                  new ListView(
                    children: snapshot.data.documents
                    // Check if the argument ids contains document ID if ids has been passed:
                        .where((d) => ids == null || ids.contains(d.documentID))
                        .map((document) {
                      StateModel appState;
                      print(Recipe.fromMap(document.data, document.documentID));
                      appState = StateWidget.of(context).state;
                      return new RecipeCard(
                          recipe:
                          Recipe.fromMap(document.data, document.documentID),
                          inFavorites:
                          appState.favorites.contains(document.documentID)
                      );
                    }).toList(),
//                  )
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<Null> refreshList() async {
    refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      new search_func(textinput:"");
    });

    return null;
  }

}