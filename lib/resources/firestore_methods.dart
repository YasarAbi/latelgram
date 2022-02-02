import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latelgram/models/posts.dart';
import 'package:latelgram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Post atmak
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,

  ) async {
    String res = 'Hata!';
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        profImage: profImage,
        postUrl: photoUrl,
        datePublished: DateTime.now(),
        likes: []
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch(err) {
      res = err.toString();
    }
    return res;
  }
}