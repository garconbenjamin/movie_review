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
  updateData(String key, dynamic value) {
    switch (key) {
      case 'id':
        id = value;
        break;
      case 'title':
        movieTitle = value;
        break;
      case 'name':
        userName = value;
        break;
      case 'content':
        review = value;
        break;
    }
  }
}
