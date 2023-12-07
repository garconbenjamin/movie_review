import 'dart:convert';

import 'package:movie_review/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:movie_review/models/movie_review.dart';

Future<List> getMovieReview() async {
  final response = await http.get(Uri.parse(ApiString.apiString));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return jsonData.map((json) => MovieData.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> updateMovieReview(
    {required int id, String? titile, String? name, String? content}) async {
  final response = await http.put(Uri.parse(ApiString.apiString), body: {
    'id': id.toString(),
    'title': titile,
    'name': name,
    'content': content,
  });
  if (response.statusCode != 200) {
    throw Exception('Failed to update data');
  }
}

Future<void> deleteMovieReview(int id) async {
  final response = await http.delete(Uri.parse(ApiString.apiString), body: {
    'id': id.toString(),
  });
  if (response.statusCode != 200) {
    throw Exception('Failed to delete data');
  }
}

Future<int> addMovieReview(
    {required String titile, String? name, String? content}) async {
  final response = await http.post(Uri.parse(ApiString.apiString), body: {
    'title': titile,
    'name': name,
    'content': content,
  });
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return jsonData['id'];
  } else {
    throw Exception('Failed to add data');
  }
}
