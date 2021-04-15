import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
  }
}

class DioExamplePage extends StatefulWidget {
  static const PAGE_ROUTE = '/examples/dio';

  @override
  _DioExamplePageState createState() => _DioExamplePageState();
}

class _DioExamplePageState extends State<DioExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Http requests'),
              onPressed: makeHttpRequest,
            ),
          ],
        ),
      ),
    );
  }

  void makeHttpRequest() async {
    try {
      Response<List> response =
          await Dio().get<List>('https://jsonplaceholder.typicode.com/posts');

      final posts = response.data!.map((e) => Post.fromMap(e)).toList();
      posts.forEach((e) => print(e.toJson()));
    } catch (e) {
      print(e);
    }
  }
}
