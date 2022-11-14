import 'dart:io';
import 'package:assigment/components/btn.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> departments = ["HR", "Finance", "House Keeping", "Marketing"];

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final formGlobalKey = GlobalKey<FormState>();
  String dropDownValue = "HR";
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  File? file;
  String addPhoto = "+ Add Photo";
  late String imageUrl;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.file = imageTemporary;
      addPhoto = "Photo Selected!";
      setState(() {});
    } on PlatformException catch (e) {
      print("Failed to pick image! $e");
    }
    print(file);
  }

  Future uploadImage() async {
    isLoading = true;
    setState(() {});
    final _firebaseStorage = FirebaseStorage.instance;

    if (file != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${file?.path}')
          .putFile(file!);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Image Path Received');
    }
  }

  Future createUser(
      {required String name,
      required String number,
      required String age,
      required String department,
      required String imageUrl}) async {
    final docUser = FirebaseFirestore.instance.collection("userlist");
    final json = {
      "name": name,
      "number": number,
      "age": age,
      "department": department,
      "imageUrl": imageUrl
    };
    await docUser.add(json);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "Please enter details",
              style: TextStyle(
                color: Colors.pink.shade700,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Khushi Vyas",
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                validator: (val) {
                  if (val!.length < 3) {
                    return "Length of name should be at least 3.";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: numberController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "9999999999",
                  labelText: "Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                validator: (val) {
                  if (val!.length < 10) {
                    return "Please enter valid phone number.";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: ageController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: InputDecoration(
                  hintText: "22",
                  labelText: "Age",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                validator: (val) {
                  if (val!.length < 2) {
                    return "Please enter age!";
                  }
                  if (int.parse(val) < 16 || int.parse(val) > 120) {
                    return "Please enter correct age.";
                  }
                },
              ),
            ),
            DropdownButton(
              value: dropDownValue,
              items: departments.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newVal) {
                setState(() {
                  dropDownValue = newVal!;
                });
              },
            ),
            CustomButton(
              title: addPhoto,
              onPress: () => pickImage(),
            ),
            CustomButton(
              title: "Save",
              onPress: () {
                if (formGlobalKey.currentState!.validate()) {
                  print("Valid.");
                  if (file == null) {
                    final snackBar = SnackBar(
                      content: const Text("Please select a photo!"),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    uploadImage().then((value) {
                      createUser(
                          name: nameController.text,
                          number: numberController.text,
                          age: ageController.text,
                          department: dropDownValue,
                          imageUrl: imageUrl);
                      nameController.clear();
                      ageController.clear();
                      numberController.clear();
                      dropDownValue = "HR";
                      file?.delete();
                      addPhoto = "+ Add Photo";
                    }).then((value) {
                      final snackBar = SnackBar(
                        content: const Text("Data Saved!"),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      isLoading = false;
                      setState(() {});
                    });
                  }
                } else {
                  print("Error");
                }
              },
            ),
            isLoading ? CircularProgressIndicator() : Text(""),
          ],
        ),
      ),
    );
  }
}
