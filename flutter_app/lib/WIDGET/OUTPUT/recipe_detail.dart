import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/WIDGET/video_button.dart';

import 'package:flutter_app/recipe.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_title.dart';
import 'package:flutter_app/State.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/state_widget.dart';
import 'package:flutter_app/util/store.dart';
import 'package:flutter_app/WIDGET/OUTPUT/recipe_image.dart';
import 'package:advanced_share/advanced_share.dart';

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;

  IngredientsView(this.ingredients);

  @override
  Widget build(BuildContext context) {

    List<Widget> children = new List<Widget>();
    ingredients.forEach((item) {
      children.add(
        new Row(
          children: <Widget>[
            new Icon(Icons.arrow_forward),
            new SizedBox(width: 5.0),
            new Flexible(child: Text(item,style: TextStyle(fontSize: 20),))
          ],
        ),
      );
      // Add spacing between the lines:
      children.add(
        new SizedBox(
          height: 10.0,
        ),
      );
    });

    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      children: children
    );

  }
}

class PreparationView extends StatelessWidget {
  final List<String> preparationSteps;
  PreparationView(this.preparationSteps);

  @override
  Widget build(BuildContext context) {
    List<Widget> textElements = List<Widget>();
    preparationSteps.forEach((item) {
      // try to make it card
      textElements.add(
        Text(item,style: TextStyle(fontSize: 18),textAlign: TextAlign.justify,),
      );
      // Add spacing between the lines:
      textElements.add(
        SizedBox(
          height: 10.0,
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      children: textElements,
    );
  }
}


class DetailScreen extends StatefulWidget {
  final Recipe recipe;
  final bool inFavorites;

  DetailScreen(this.recipe, this.inFavorites);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  bool _inFavorites;
  StateModel appState;

  _DetailScreenState();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();
    _inFavorites = widget.inFavorites;
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleInFavorites() {
    setState(() {
      _inFavorites = !_inFavorites;
    });

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Firestore.instance.collection("rekomen").document(widget.recipe.id).updateData({
      "click": FieldValue.increment(1)
    });
    appState = StateWidget.of(context).state;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.green,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RecipeImage(widget.recipe.imageURL),
                    Row(
                      children: <Widget>[
                        RecipeTitle(widget.recipe, 15.0),
                        Spacer(),
                        FlatButton.icon(
                            padding: EdgeInsets.only(top: 10.0),
                            onPressed: shareRecipe,
                            icon: Icon(Icons.share,
                                color: Colors.white,
                                size: 25.0,),
                            label: Text(""),
                        )
                      ],
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 95,
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.timer,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              Text(widget.recipe.estimatedTime,
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Text("Recipe by "+widget.recipe.chefName+" ",
                              style: TextStyle(color: Colors.white),
                              ),
                              new ClipRRect(
                                borderRadius: new BorderRadius.circular(20.0),
                                child: Image.network(widget.recipe.chefPic,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              expandedHeight: SizeConfig.blockSizeVertical * 40,
              pinned: true,
              floating: true,
              elevation: 1.0,
              forceElevated: innerViewIsScrolled,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: "Home"),
                  Tab(text: "Preparation"),
                  Tab(text: "Video")
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            IngredientsView(widget.recipe.ingredients),
            PreparationView(widget.recipe.preparation),
            VideoPlayerScreen(videoURL: widget.recipe.videoURL)
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateFavorites(appState.user.uid, widget.recipe.id).then((result) {
            // Toggle "in favorites" if the result was successful.
            if (result) _toggleInFavorites();
          });
        },
        child: Icon(
          _inFavorites ? Icons.favorite : Icons.favorite_border,
          color: Theme.of(context).iconTheme.color,
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
    );
  }

  void shareRecipe(){
    String ingredientsItem = "";
    widget.recipe.ingredients.forEach((item) => ingredientsItem += item+"\n");
    String preparationStep = "";
    widget.recipe.preparation.forEach((step) => preparationStep += step+"\n");
    String chefName = ""+widget.recipe.chefName;
    AdvancedShare.generic(
        title: widget.recipe.name,
        msg: widget.recipe.name+"\n"
            +"\nIngredients:\n"+ingredientsItem+"\n"+"\n"
            +"Preparations:\n"+preparationStep+"\n"+"\n"
            +"Recipe by "+chefName);
  }
}