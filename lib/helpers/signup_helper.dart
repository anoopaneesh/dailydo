import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/helpers/firebase_helper.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/screens/home_screen.dart';

class SignupHelper {
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<File?> currentImage = ValueNotifier(null);
  final ValueNotifier<bool> uploading = ValueNotifier(false);
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  void handlePickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      currentImage.value = File(image.path);
    }
  }

  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  SignupHelper() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }
  void toggleIsPasswordVisible(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signUp(BuildContext ctx) async {
    uploading.value = true;
    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final image = currentImage.value;
    try {
      await FirebaseHelper.signUpWithEmailAndPassword(
          email: email, password: password);
      String? downloadUrl;
      if (image != null) {
        downloadUrl = await FirebaseHelper.uploadImage(
            file: image, filename: email.split('@')[0]);
      }
      await FirebaseHelper.updateUserProfile(name: name, photoUrl: downloadUrl);
      final user = FirebaseHelper.currentUser;
      if(user != null){
        await pref.setStringList('user', [user.uid,user.displayName ?? "",user.email ?? "",user.photoURL ?? ""]);
      }
      Navigator.pushAndRemoveUntil(
        ctx,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      FirebaseHelper.deleteCurrentUser();
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text(FirebaseHelper.getErrorMessage(e))));
    } catch (e) {
      FirebaseHelper.deleteCurrentUser();
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    } finally {
      uploading.value = false;
    }
  }
}
