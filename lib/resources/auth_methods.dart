import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latelgram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcı Kaydı
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Hata oluştu.';
    try {
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || email.isNotEmpty)
      {
        //  Kullanıcıyı Firebase'e ekleme
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);
        // Kullanıcı hakkındaki verileri ekleme
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        res = 'Başarılı';
      }
    } on FirebaseAuthException catch(err) {
      if(err.code == 'invalid-email') {
        res = 'E-posta adresini kontrol edin.';
      } else if(err.code == 'weak-password') {
        res = 'Şifre basit. Lütfen zor bir şifre oluşturunuz.';
      }
    }
    
    catch(err) {
      res = err.toString();
    }
    return res;
  }
  // Kullanıcı girişi
  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res = 'Hatalar';

    try {
      if(email.isNotEmpty || password.isNotEmpty) {
         await _auth.signInWithEmailAndPassword(email: email, password: password);
         res = 'success';
      } else {
        res = 'Lütfen giriş bilgilerini girin.';
      }
    } catch(err) {
      res = err.toString();
    }
    return res;
  }
}