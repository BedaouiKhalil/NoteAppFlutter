import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseapp/categories/edit.dart';
import 'package:courseapp/note/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addcategory");
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
        ),
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: WillPopScope(
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 160),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NoteView(categoryid: data[i].id)));
                        },
                        onLongPress: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Warning',
                            desc: "What do you want to choose?",
                            btnCancelText: "Delete",
                            btnCancelOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection("categories")
                                  .doc(data[i].id)
                                  .delete();
                              Navigator.of(context)
                                  .pushReplacementNamed("homepage");
                            },
                            btnOkText: 'Update',
                            btnOkOnPress: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditCategory(
                                      docid: data[i].id,
                                      oldname: data[i]['name'])));
                            },
                          ).show();
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/folder.png",
                                  height: 100,
                                ),
                                Text("${data[i]['name']}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ), 
                  onWillPop:(){
                    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
                    return Future.value(false);
                  }
                  ));
  }
}
