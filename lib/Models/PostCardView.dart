import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardFTview {
  final String title;
  final String description;
  final DateTime date;
  final List<String> topics;
  final String userId;
  final String docId;
  String? username;
  String? userPhotoUrl;
  String email;
  String userType;
  String? teamDocId;

  CardFTview({
    required this.title,
    required this.description,
    required this.date,
    required this.topics,
    required this.userId,
    this.docId = '',
    required this.username,
    required this.userPhotoUrl,
    required this.email,
    required this.userType,
    required this.teamDocId,
  });

  Map<String, dynamic> toJson() => {
        'postTitle': title,
        'postDescription': description,
        'deadlineDate': date,
        'selectedInterests': topics,
        'userId': userId,
        'docId': docId,
        'username': username,
        'userPhotoUrl': userPhotoUrl,
        'email': email,
        'userType': userType,
        'teamDocId': teamDocId,
        // 'projectDocId': projectDocId,
      };

  static CardFTview fromJson(Map<String, dynamic> json) => CardFTview(
        title: json['postTitle'],
        description: json['postDescription'],
        topics: List<String>.from(json['selectedInterests']),
        date: (json['deadlineDate'] as Timestamp).toDate(),
        userId: json['userId'],
        username: json['username'] ?? '',
        docId: json['docId'],
        userPhotoUrl: json['userPhotoUrl'] as String?,
        email: json['email'] ?? '',
        userType: json['userType'] ?? '',
        teamDocId: json['teamDocId'],
        // projectDocId: json['projectDocId'],
      );
}
