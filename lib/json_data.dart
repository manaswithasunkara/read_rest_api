class User {
  int? userId;
  int? id;
  String? title;
  String? body;

  User({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
