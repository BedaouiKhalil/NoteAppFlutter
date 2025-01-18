import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customtextfieldadd.dart';
import 'package:courseapp/note/view.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final String notedocid;
  final String categorydocid;
  final String value;
  const EditNote({super.key, required this.notedocid, required this.categorydocid, required this.value});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  bool isLoading = false;

  editNote() async {
    CollectionReference collectionNote = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categorydocid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
         await collectionNote.doc(widget.notedocid).update(
            {"note": note.text});

        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => NoteView(categoryid: widget.categorydocid)));
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void initState() {
    note.text = widget.value;
    super.initState();
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
        title: Text("Edit Note"),
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
                        title: "save",
                        onPresed: () {
                          editNote();
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
