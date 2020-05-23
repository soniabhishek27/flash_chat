import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flashchat/Components/rounded_button.dart';
import 'package:flashchat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget
{
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static const String id = 'login_screen';
}

class _LoginScreenState extends State<LoginScreen>
{
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;

                  //Do something with the user input.
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
           RoundedButton(
             colour: Colors.lightBlueAccent,
             title: 'Login',
             onPressed: ()
             {
               setState(() {
                 showSpinner = true;
               });
               Login();
             },
           ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                color: Colors.lightBlueAccent,
//                borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                elevation: 5.0,
//                child: MaterialButton(
//                  onPressed: () {
//                    //Implement login functionality.
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Log In',
//                  ),
//                ),
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }

  void Login() async
  {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user !=null)
      {
        Navigator.pushNamed(context,ChatScreen.id);
        
      }
      setState(() {
        showSpinner = false;

      });
    }
    catch(e)
    {
      print(e);

      
    }

  }
}
