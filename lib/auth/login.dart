import 'package:courseapp/components/custombuttonauth.dart';
import 'package:courseapp/components/customlogo.dart';
import 'package:courseapp/components/textformfield.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
              Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
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
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          CusttomButtonAuth(title: "Login", onPresed: (){}),
          SizedBox(height: 20),

          MaterialButton(
              height: 45,
              padding: EdgeInsets.symmetric(vertical:5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey),
                  ),
              color: Colors.white,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login With Google  "),
                  Image.asset(
                    "images/google.png",
                    width: 18,
                  )
                ],
              ),),
          SizedBox(height: 20),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed("signup");
            },
            child: Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                  text: "Register",
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