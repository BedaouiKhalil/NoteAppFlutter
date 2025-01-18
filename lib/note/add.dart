import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customtextfieldadd.dart';
import 'package:courseapp/note/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  final String docid;
  const AddNote({super.key, required this.docid});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  bool isLoading = false;

  addNote() async {
    CollectionReference collectionNote = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await collectionNote.add(
            {"name": note.text, "id": FirebaseAuth.instance.currentUser!.uid});
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => NoteView(categoryid: widget.docid)));
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
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
                        hinttext: "Enter Note",
                        mycontroller: note,
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
                          addNote();
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
