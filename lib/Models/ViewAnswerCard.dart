class CardAview {
  String questionDocId;
  String userId;
  String answerText;
  int upvoteCount;
  String? username;
  List<String> upvotedUserIds;
  final String docId;
  String? userPhotoUrl;
  String userType;


  CardAview({
    required this.questionDocId,
    required this.userId,
    required this.answerText,
    required this.upvoteCount,
    this.upvotedUserIds = const [],
    required this.docId,
    required this.username,
    required this.userPhotoUrl,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'questionDocId': questionDocId,
        'userId': userId,
        'answerText': answerText,
        'upvoteCount': upvoteCount,
        'username': '',
        'upvotedUserIds': upvotedUserIds,
        'docId': docId,
        'userPhotoUrl': userPhotoUrl,
        'userType': userType,
      };

  factory CardAview.fromJson(Map<String, dynamic> json) {
    return CardAview(
      questionDocId: json['questionDocId'],
      userId: json['userId'] as String,
      answerText: json['answerText'] as String,
      upvoteCount: json['upvoteCount'] as int,
      upvotedUserIds: List<String>.from(json['upvotedUserIds'] ?? []),
      docId: json['docId'],
      username: json['username'] ?? '',
      userPhotoUrl: json['userPhotoUrl'] as String?,
      userType: json['userType'] ?? '',
    );
  }
}