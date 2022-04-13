import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/helpers/signup_helper.dart';
import 'package:todo_app/widgets/pick_image.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  final _signupHelper = SignupHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              height: 280,
              child: SvgPicture.asset('assets/images/otp-security.svg'),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sign-Up",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Center(
                          child: ValueListenableBuilder(
                            valueListenable: _signupHelper.currentImage,
                            builder: (BuildContext ctx, File? currentValue,
                                Widget? child) {
                              return PickImage(
                                currentImage: currentValue,
                                handlePickImage: _signupHelper.handlePickImage,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _signupHelper.nameController,
                                decoration: const InputDecoration(
                                    hintText: 'Your Name ID'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _signupHelper.emailController,
                                decoration: const InputDecoration(
                                    hintText: 'Your Email ID'),
                              ),
                              
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ValueListenableBuilder(
                                valueListenable: _signupHelper.isPasswordVisible,
                                builder: (BuildContext ctx,bool value,Widget? child) {
                                  return TextField(
                                    controller: _signupHelper.passwordController,
                                    decoration: InputDecoration(
                                        hintText: 'Your password',
                                        suffixIcon:IconButton(onPressed: (){
                                          _signupHelper.toggleIsPasswordVisible();
                                        }, icon:value ? const Icon(Icons.visibility_off): const Icon(Icons.visibility)),),
                                    obscureText: !value,
                                  );
                                }
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ValueListenableBuilder(
                                  valueListenable: _signupHelper.uploading,
                                  builder: (BuildContext ctx,bool value,Widget? child){
                                    return ElevatedButton(
                                    onPressed: value ? null : () {
                                      _signupHelper.signUp(context);
                                    },
                                    child: value ? const CircularProgressIndicator() : const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                  );
                                  },
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account ?'),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
