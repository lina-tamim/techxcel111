import 'dart:core';

class CardQview {
  final int id;
  final String title;
  final String description;
  final List<String> topics;
  final String userId;
  String? docId;
  String? username;
  String? userPhotoUrl;
  String questionDocId;
  String? reason; // Add the reason property

  CardQview({
    required this.id,
    required this.title,
    required this.description,
    required this.topics,
    required this.userId,
    this.docId,
    required this.username,
    required this.userPhotoUrl,
    required this.questionDocId,
    this.reason, // Add the reason property
  });

  Map<String, dynamic> toJson() => {
        'questionCount': id,
        'postTitle': title,
        'postDescription': description,
        'selectedInterests': topics,
        'userId': userId,
        'docId': docId,
        'username': username,
        'userPhotoUrl': userPhotoUrl,
        'questionDocId': questionDocId,
        'reason': reason,
      };

  static CardQview fromJson(Map<String, dynamic> json) => CardQview(
        id: json['questionCount'],
        title: json['postTitle'],
        description: json['postDescription'],
        topics: List<String>.from(json['selectedInterests']),
        userId: json['userId'],
        docId: json['docId'],
        username: json['username'],
        userPhotoUrl: json['userPhotoUrl'] as String?,
        questionDocId: json['questionDocId'],
        reason: json['reason'] as String?,
      );
}
