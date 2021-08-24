import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_programming/pages/registration_page.dart';
import 'package:task_programming/pages/task_list.dart';
import 'registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  login() async {
    if (t1.text.isEmpty || t2.text.isEmpty) return;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: t1.text, password: t2.text);
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Lists()),
      );
    } catch (e) {
      print(e);
    }
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Lists()),
    );
  }

  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Form(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage('asset/login_image.png'),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Expanded(
                                          flex: 1,
                                          child: Icon(
                                              Icons.arrow_right_alt_outlined)),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[500],
                                  padding: EdgeInsets.all(10),
                                  side: BorderSide(
                                      color: Colors.black,
                                      width: 3.0,
                                      style: BorderStyle.solid),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: t1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 1))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: t2,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 1,
                                ))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Expanded(
                                    flex: 1,
                                    child:
                                        Icon(Icons.arrow_right_alt_outlined)),
                              ),
                            ],
                          ),
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple[700],
                            padding: EdgeInsets.all(10),
                            side: BorderSide(
                                color: Colors.black,
                                width: 3.0,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 150,
                        child: ListView(
                          children: <Widget>[
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.purple),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                leading: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Login with Email',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right,
                                  size: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.purple),
                              ),
                              child: ListTile(
                                onTap: () => signInWithGoogle(),
                                leading: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Login with Google',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right,
                                  size: 32,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleuser!.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
