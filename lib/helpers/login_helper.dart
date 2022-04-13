import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helpers/firebase_helper.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/screens/home_screen.dart';

class LoginHelper {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  LoginHelper() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void toggleIsPasswordVisible(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signIn(BuildContext ctx) async {
    isLoading.value = true;
    try {
      await FirebaseHelper.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final user = FirebaseHelper.currentUser;
      if(user != null){
        await pref.setStringList('user', [user.uid,user.displayName ?? "",user.email ?? "",user.photoURL ?? ""]);
      }
    
      Navigator.of(ctx).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext c) => HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text(FirebaseHelper.getErrorMessage(e))));
    }catch(err){
       ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content:Text('Something went wrong')));
    }finally{
      isLoading.value = false;
    }
  }
}
