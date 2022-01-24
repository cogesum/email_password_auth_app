import 'package:email_password_auth_app/screens/home_screen.dart';
import 'package:email_password_auth_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);




  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  //firebase
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator:  (value) {
        if(value!.isEmpty){
          return "Please enter your Email";
        }

        //email validation
        if(!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9+_.-]+.[a-z]").hasMatch(value)){
          return "Not a valid email.";
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      //password validation
      validator: (value) => value!.length < 6 ? 'Password too short.' : null,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Password",
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(1),
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(40),
              color: Colors.white,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      emailField,
                      passwordField,
                      loginButton,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                              child: Text(
                                " Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blue),
                              ),
                            ),
                          ]),
                    ],
                  ))),
        ),
      ),
    );
  }

//login func

  void signIn(String email, String password) async {
    if(_formKey.currentState!.validate()){
        await _auth.signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
               Fluttertoast.showToast(msg: "Log in Successful"),
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()))}
        ).catchError((e){
          Fluttertoast.showToast(msg: e!.message);
        });
     };
  }

}
