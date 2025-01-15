import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customtextfieldadd.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldname;
  const EditCategory({super.key, required this.docid, required this.oldname});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  bool isLoading = false;

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  editCategory() async {
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await categories.doc(widget.docid).update({"name": name.text});
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
  void initState() {
    super.initState();
    name.text = widget.oldname;
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
                          editCategory();
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
