class MovieData {
  int? id;
  String? movieTitle;
  String? userName;
  String? review;

  MovieData({
    this.id,
    required this.movieTitle,
    required this.userName,
    required this.review,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': movieTitle,
      'userName': userName,
      'content': review,
    };
  }

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      id: json['id'],
      movieTitle: json['title'],
      userName: json['name'],
      review: json['content'],
    );
  }
}
