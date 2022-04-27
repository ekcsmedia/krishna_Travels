import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishna_travels/driverLocationList.dart';
import 'package:krishna_travels/fire_auth.dart';
import 'package:krishna_travels/home.dart';
import 'package:krishna_travels/parent_login.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


import 'admin_login.dart';
import 'admin_registration.dart';

User? user;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _parentTextController = TextEditingController();

  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  @override
  void initState() {
    setState(() {
      //   _locationId = widget.user;
    });
    super.initState();
    _checkPermission();
  }

  late String? selectedCategory;

  String? value;

  final String append = "@kt.in";

  final _formKey = GlobalKey<FormState>();




 List<String> parentPasswordList = [
    'parent',
    'parent@',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Sign in',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.login),
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginUser(),
                  ),
                );
              })
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
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
                              obscureText: true,
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
                        if (_formKey.currentState!.validate()) {
                          User? user = await FireAuth.signInUsingEmailPassword(
                            email: _emailTextController.text + append,
                            password: _passwordTextController.text,
                          );
                          if (user != null) {
                            Navigator.of(context)
                                .pushReplacement(
                              MaterialPageRoute(builder: (context) => Home(user: user)),
                            );
                          }
                        }
                      },
                      child: Text('Driver Login'),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),


              child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? Contact Admin"),

                        const SizedBox(
                          height: 24,
                        ),
            /*            TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Parent Password'),
                            controller: _parentTextController), */

                        ElevatedButton(
                          child: Text(
                            'Parent Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(
                              MaterialPageRoute(builder: (context) => LoginParent()),
                            );
                          },
                        )] ) )
                      ],
                    ),


              ),
            ),
        ),
        ),
      );


  }

  /*
  _validateParentInput(String value) {
    if (parentPasswordList.contains (value.toLowerCase())) {
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => Homes(user: user)),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Login"),
      ));
    }
  } */
}


