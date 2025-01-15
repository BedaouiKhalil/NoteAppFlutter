import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customlogo.dart';
import 'package:courseapp/components/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                CustomLogoAuth(),
                SizedBox(height: 20),
                Text("SignUp",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("SignUp To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 20),
                Text(
                  "UserName",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Username",
                  mycontroller: username,
                  validator: (val) {
                    if (val == "") {
                      return "can't to be empty";
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Email",
                  mycontroller: email,
                  validator: (val) {
                    if (val == "") {
                      return "can't to be empty";
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Password",
                  mycontroller: password,
                  validator: (val) {
                    if (val == "") {
                      return "can't to be empty";
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CusttomButtonAuth(
            title: "SignUp",
            onPresed: () async {
              if (formState.currentState!.validate()) {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text.trim(), // Enlever les espaces inutiles
                    password: password.text.trim(),
                  );
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  Navigator.of(context).pushReplacementNamed("homepage");
                } on FirebaseAuthException catch (e) {
                  String errorMessage;
                  if (e.code == 'weak-password') {
                    errorMessage = 'The password provided is too weak.';
                  } else if (e.code == 'email-already-in-use') {
                    errorMessage = 'The account already exists for that email.';
                  } else {
                    errorMessage = 'An unexpected error occurred: ${e.message}';
                  }
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: errorMessage,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                } catch (e) {
                  print(e);
                }
              } else {
                print("no validate");
              }
            },
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
            child: Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          ),
        ]),
      ),
    );
  }
}
