import 'dart:core';
class CardQuestion {
  final int id;
  final String title;
  final String description;
  final List<String> topics;
  final String userId;
  String? userPhotoUrl;
  final String? docId;
  String? username;

  CardQuestion({
    required this.id,
    required this.title,
    required this.description,
    required this.topics,
    required this.userId,
    this.docId = '',
    required this.username,
    required this.userPhotoUrl,
  });

  Map<String, dynamic> toJson() => {
        'questionCount': id,
        'postTitle': title,
        'postDescription': description,
        'selectedInterests': topics,
        'userId': userId,
        'docId': docId,
        'username': '',
        'userPhotoUrl': userPhotoUrl,
      };

  static CardQuestion fromJson(Map<String, dynamic> json) => CardQuestion(
        id: json['questionCount'],
        title: json['postTitle'],
        description: json['postDescription'],
        topics: List<String>.from(json['selectedInterests']),
        userId: json['userId'],
        docId: json['docId'] ?? '',
        username: json['username'] ?? '',
        userPhotoUrl: json['userPhotoUrl'] as String?,
      );
}

 