class Post {
  late String id;
  late String profileImageUrl;
  late String comment;
  late String foodPictureUrl;
  late String timestamp;

  Post(
      {required this.id,
      required this.profileImageUrl,
      required this.comment,
      required this.foodPictureUrl,
      required this.timestamp});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImageUrl = json['profileImageUrl'];
    comment = json['comment'];
    foodPictureUrl = json['foodPictureUrl'];
    timestamp = json['timestamp'];
  }
}
