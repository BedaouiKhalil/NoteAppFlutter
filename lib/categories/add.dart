import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customtextfieldadd.dart';
import 'package:courseapp/components/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  bool isLoading = false;

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  addCategory() async {
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await categories.add(
            {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(20),
              child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      CustomTextFormAdd(
                        hinttext: "Enter Name",
                        mycontroller: name,
                        validator: (val) {
                          if (val == "") {
                            return "Can't To Be Empty";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CusttomButtonAuth(
                        title: "Add",
                        onPresed: () {
                          addCategory();
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
