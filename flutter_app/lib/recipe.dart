enum RecipeType {
  Italian,
  Indonesian,
  Japanese,
  Western
}

class Recipe {
  final String id;
  final RecipeType type;
  final String name;
  final List<String> ingredients;
  final List<String> preparation;
  final String imageURL;
  final String videoURL;
  final int click;
  final String estimatedTime;
  final String chefName;
  final String chefPic;

  const Recipe({
    this.id,
    this.name,
    this.type,
    this.ingredients,
    this.preparation,
    this.imageURL,
    this.videoURL,
    this.click,
    this.estimatedTime,
    this.chefName,
    this.chefPic,
  });

  Recipe.fromMap(Map<String, dynamic> data, String id)
      : this(
    id: id,
    name: data['name'],
    type: RecipeType.values[data['type']],
    ingredients: new List<String>.from(data['ingredients']),
    preparation: new List<String>.from(data['steps']),
    imageURL: data['image'],
    videoURL: data['video'],
    click: data['click'],
    estimatedTime: data['time'],
    chefName: data["chef-name"],
    chefPic: data["chef-pic"],
  );
}

