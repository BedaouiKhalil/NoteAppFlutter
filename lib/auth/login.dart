import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customlogo.dart';
import 'package:courseapp/components/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                      Text("Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Text("Login To Continue Using The App",
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 20),
                      Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                      InkWell(
                        onTap: () async {
                          if (email.text == "") {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Login Error',
                              desc: "we send you link",
                              btnOkOnPress: () {},
                            ).show();
                          }
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Login Error',
                            desc: "Verify your email",
                            btnOkOnPress: () {},
                          ).show();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          alignment: Alignment.topRight,
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CusttomButtonAuth(
                    title: "Login",
                    onPresed: () async {
                      if (formState.currentState!.validate()) {
                        try {
                          isLoading = true;
                          setState(() {});
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          isLoading = false;
                          setState(() {});
                          if (credential.user!.emailVerified) {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Login Error',
                              desc: "Verify your email",
                              btnOkOnPress: () {},
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          isLoading = false;
                          setState(() {});
                          print('Error code: ${e.code}, message: ${e.message}');
                          String errorMessage;
                          if (e.code == 'user-not-found') {
                            errorMessage = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            errorMessage =
                                'Wrong password provided for that user.';
                          } else if (e.code == 'invalid-email') {
                            errorMessage =
                                'The email address is badly formatted.';
                          } else {
                            errorMessage =
                                'An unexpected error occurred: ${e.message}';
                          }

                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Login Error',
                            desc: errorMessage,
                            btnOkOnPress: () {},
                          ).show();
                        }
                      } else {
                        print("not valide");
                      }
                    }),
                SizedBox(height: 20),
                MaterialButton(
                  height: 45,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login With Google  "),
                      Image.asset(
                        "images/google.png",
                        width: 18,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Don't Have An Account ? ",
                      ),
                      TextSpan(
                          text: "Register",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                    ])),
                  ),
                ),
              ]),
            ),
    );
  }
}
