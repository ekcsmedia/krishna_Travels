import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishna_travels/signin.dart';
import 'package:krishna_travels/driverLocationList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart' as loc;

class Home extends StatefulWidget {
  final User? user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// 1

  final loc.Location location = loc.Location();
  late StreamSubscription<loc.LocationData>? _locationSubscription;
  TextEditingController driverId = new TextEditingController();
  late User? _locationId ;

  get user => widget.user;
  @override
  void initState() {
    setState(() {
      _locationId = widget.user;
    });
    super.initState();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Krishna Travels',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('Add my location - Driver')),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: Text('Enable my live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('Stop Sharing my live location')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                    builder: (context) => Homes(user: user),));
              },
              child: Text('Go to Driver Location List')),

       Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('location')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                    }
                   return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Hi ${snapshot.data!.docs[index]['name']
                                .toString()}"),

                            ); } ); }

         ) )  ]));}


_getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('location')
          .doc('user${_locationId!.displayName}')
          .set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'Driver - ${_locationId!.displayName}',
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('location')
          .doc('user${_locationId!.displayName}')
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Driver - ${_locationId!.displayName}',
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
