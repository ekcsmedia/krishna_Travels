import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishna_travels/mymap.dart';
import 'package:krishna_travels/paymentPage.dart';
import 'package:krishna_travels/signin.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart' as loc;

class Homes extends StatefulWidget {
  final User? user;
  const Homes({Key? key, required this.user}) : super(key: key);

  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
// 1

  final loc.Location location = loc.Location();
  late StreamSubscription<loc.LocationData>? _locationSubscription;
  TextEditingController _payment = new TextEditingController();
  late User? _locationId;

  @override
  void initState() {
    setState(() {
      _locationId = widget.user;
    });
 //   setState(() {
   //   String pay = _payment.text;
 //     int _payable = int.parse(pay);
   // });
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
          'Driver Location List',
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
      body:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter Payment Amount'),
                    controller: _payment,
                keyboardType: TextInputType.number, ),
              ),
              TextButton(
                  onPressed: () {

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                        builder: (context) => MyPaymentApp(payment: int.parse(_payment.text))));
                  },
                  child: Text('PROCEED FOR PAYMENT')),
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
                                title: Text(snapshot.data!.docs[index]['name']
                                    .toString()),
                                subtitle: Row(
                                  children: [
                                    Text(snapshot.data!.docs[index]['latitude']
                                        .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(snapshot.data!.docs[index]['longitude']
                                        .toString()),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => MyMap(
                                                snapshot.data!.docs[index].id,)));
                                              //  _locationId!.displayName.toString()
                                  },
                                ),
                              );
                            });
                      },),),
            ],
          ),);
  }


}
