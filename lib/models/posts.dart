import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String uid;
  final String description;
  final datePublished;
  final String postId;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.profImage,
    required this.postUrl,
    required this.likes
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'uid': uid,
    'description': description,
    'datePublished': datePublished,
    'postId': postId,
    'profImage': profImage,
    'postUrl': postUrl,
    'likes': likes
  };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      profImage: snapshot['profImage'],
      postUrl: snapshot['postUrl'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      description: snapshot['description']
    );
  }
}