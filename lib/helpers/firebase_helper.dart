import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {


  static User? get currentUser{
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> signOut()async{
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      rethrow;
    }
  }

  static Future<String> uploadImage(
      {required File file, required String filename}) async {
    try {
      final _storage = FirebaseStorage.instance;
      final uploadTask = await _storage
          .ref()
          .child('user_profile_img/$filename')
          .putFile(file);
      return uploadTask.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  static Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try{
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      rethrow;
    }
  }

  static Future<void> updateUserProfile(
      {String? name, String? photoUrl}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      if (name != null) await user.updateDisplayName(name);
      if (photoUrl != null) await user.updatePhotoURL(photoUrl);
    } catch (err) {
      rethrow;
    }
  }

  static void deleteCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.delete();
    }
  }

  static String getErrorMessage(FirebaseException e) {
    final String errorMessage;
    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'Account already exists';
        break;
      case 'invalid-email':
        errorMessage = 'Email address is invalid';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Something went wrong';
        break;
      case 'weak-password':
        errorMessage = 'Try using a strong password';
        break;
      case 'user-disabled':
        errorMessage = 'The account is disabled';
        break;
      case 'user-not-found':
        errorMessage = 'User not found';
        break;
      case 'wrong-password':
        errorMessage = 'Password is incorrect';
        break;
      default:
        errorMessage = e.message!;
    }
    return errorMessage;
  }
}
