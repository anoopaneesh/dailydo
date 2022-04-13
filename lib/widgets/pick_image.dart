import 'dart:io';

import 'package:flutter/material.dart';

class PickImage extends StatelessWidget {
  final File? currentImage;
  final void Function() handlePickImage;
  const PickImage({Key? key, required this.currentImage,required this.handlePickImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return currentImage == null ? TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        shape: const CircleBorder(),
        minimumSize: const Size(100, 100),
      ),
      onPressed:handlePickImage ,
      child: const Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
    ) : GestureDetector(
      onTap: handlePickImage,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color:  const Color.fromARGB(255, 230, 230, 230),
        ),
        child:CircleAvatar(
          backgroundImage: FileImage(currentImage!)
        )
      ),
    );
  }
}
