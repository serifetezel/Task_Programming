import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  kayitOl() async {
    print(t1.text);
    print(t2.text);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: t1.text, password: t2.text);
    
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Registration Page',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
          
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('asset/register2.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
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
                                color: Colors.purple,
                                width: 1
                              )
                            )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: t2,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            
                            labelText: "Password",
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.purple,
                                width: 1,
                              )
                            )
                          ),
                        ),
                        SizedBox(height: 40,),
                        ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Enter',
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
                                      child: Icon(Icons.arrow_right_alt_outlined)),
                                ),
                              ],
                            ),
                            onPressed: kayitOl,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple[700],
                              padding: EdgeInsets.all(10),
                              side: BorderSide(color: Colors.black, width: 3.0, style: BorderStyle.solid),
                              
                            ),
                          ),
                                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
