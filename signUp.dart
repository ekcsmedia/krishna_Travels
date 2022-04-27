import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishna_travels/mainscreen.dart';
import 'package:krishna_travels/parent_registration.dart';
import 'package:krishna_travels/paymentRecord.dart';
import 'package:krishna_travels/signin.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'admin_registration.dart';
import 'driverLocationList.dart';
import 'fire_auth.dart';
import 'home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notificationsApi.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _registerFormKey = GlobalKey<FormState>();
  User? user;
  bool _isProcessing = false;
  final String append = "@kt.in";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.indigoAccent,
          title: const Text(
            'Sign up',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                })
          ],
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Name'),
                                controller: _nameTextController),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Phone Number'),
                                controller: _emailTextController),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: false,
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Password'),
                                controller: _passwordTextController),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _isProcessing
                    ? CircularProgressIndicator() :
                    Container(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 6.0,
                          primary: Colors.indigoAccent, // background
                          onPrimary: Colors.white, // foreground
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Colors.indigoAccent)),
                        ),
                        onPressed: () async {
                              setState(() {
                                _isProcessing = true;
                                              });

                         if (_registerFormKey.currentState!
                               .validate()) {
                              User? user = await FireAuth
                         .registerUsingEmailPassword(
                         name: _nameTextController.text,
                          email: _emailTextController.text + append,
                           password:
                                  _passwordTextController.text,
        );

        setState(() {
            _isProcessing = false;
        });

        if (user != null) {
            Navigator.of(context)
                .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              SignUp(),
                         ),
                            ModalRoute.withName('/signup'),
                      );
                        }
                          }
                            },
                                 child: Text(
                      'Create Account',
                        style: TextStyle(color: Colors.white),
                         ),),),


                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Click to go to driver location list',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                       Navigator.of(context)
                          .pushReplacement(
                      MaterialPageRoute(builder: (context) => Homes(user: user)),
                      );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Notifications Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(builder: (context) => NotificationManagementPage()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Payment Record Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(builder: (context) => PaymentPage()),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    ElevatedButton(
                      child: Text(
                        'Admin Password Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(builder: (context) => AdminRegistration()),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    ElevatedButton(
                      child: Text(
                        'Parent Password Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(builder: (context) => ParentRegistration()),
                        );
                      },
                    ),


             /*       const SizedBox (height:10),
                    TextButton(
                      child: Text('Send Notification', style: TextStyle(fontSize: 20.0),),
                      onPressed: () {},
                    ), */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}