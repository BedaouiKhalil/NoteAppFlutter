import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customlogo.dart';
import 'package:courseapp/components/textformfield.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              CustomLogoAuth(),
              SizedBox(height: 20),
              Text("SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("SignUp To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              Text(
                "UserName",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              CustomTextForm(hinttext: "Username", mycontroller: username),
              SizedBox(height: 10),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              CustomTextForm(hinttext: "Email", mycontroller: email),
              SizedBox(height: 10),
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              CustomTextForm(hinttext: "Password", mycontroller: password),
            ],
          ),
          CusttomButtonAuth(title: "SignUp", onPresed: (){}),
          SizedBox(height: 20),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed("login");
            },
            child: Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                  text: "Login",
                  style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold)
                ),
              ])),
            ),
          ),
        ]),
      ),
    );
  }
}