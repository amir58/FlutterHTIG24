import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class QuizProfileScreen extends StatefulWidget {
  @override
  State<QuizProfileScreen> createState() => _QuizProfileScreenState();
}

class _QuizProfileScreenState extends State<QuizProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  String imageUrl =
      "https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg";

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Profile"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => selectImage(),
                child: imageFile == null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                        radius: 40,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          imageFile!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {},
                  child: const Text(
                    "Update",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1 : Pick file
  // 2 : upload file => Firebase storage
  // 3 : get file url => Firebase storage
  // 4 : save url in database => Firebase Firestore

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    imageFile = File(image.path);

    setState(() {});

    uploadFile(imageFile!);
  }

  void uploadFile(File imageFile) {
    final userId = auth.currentUser!.uid;

    storage
        .ref("images/$userId")
        .putFile(imageFile)
        .then((value) => getFileUrl())
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
  }

  getFileUrl() {
    final userId = auth.currentUser!.uid;

    storage
        .ref("images/$userId")
        .getDownloadURL()
        .then((imageUrl) => saveImageUrlInDatabase(imageUrl))
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
  }

  saveImageUrlInDatabase(String imageUrl) {
    final userId = auth.currentUser!.uid;

    Map<String, dynamic> data = {
      "imageUrl": imageUrl,
    };

    firestore
        .collection("quizUsers")
        .doc(userId)
        .update(data)
        .then((imageUrl) => Fluttertoast.showToast(msg: "Image Updated!"))
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  void getProfileData() {
    final userId = auth.currentUser!.uid;

    firestore
        .collection("quizUsers")
        .doc(userId)
        .get()
        .then((value) => updateUi(value.data()!));
  }

  updateUi(Map<String, dynamic> map) {
    nameController.text = map['name'];
    phoneController.text = map['phone'];
    emailController.text = map['email'];

    if (map.containsKey("imageUrl")) {
      imageUrl = map['imageUrl'];
      setState(() {});
    }
  }
}
