class SimpleRecipe {
  late String id;
  late String dishImage;
  late String title;
  late String duration;
  late String source;
  late List<String> information;

  SimpleRecipe(this.id, this.dishImage, this.title, this.duration, this.source,
      this.information);

  SimpleRecipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dishImage = json['dishImage'];
    title = json['title'];
    duration = json['duration'];
    source = json['source'];
    information = json['information'].cast<String>();
  }
}
