import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Payment Record Page',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _fatherController = TextEditingController();
  final TextEditingController _motherController = TextEditingController();
  final TextEditingController _fatherCellController = TextEditingController();
  final TextEditingController _motherCellController = TextEditingController();
  final TextEditingController _jun2021FeeController = TextEditingController();
  final TextEditingController _jul2021FeeController = TextEditingController();
  final TextEditingController _aug2021FeeController = TextEditingController();
  final TextEditingController _sep2021FeeController = TextEditingController();
  final TextEditingController _oct2021FeeController = TextEditingController();
  final TextEditingController _nov2021FeeController = TextEditingController();
  final TextEditingController _dec2021FeeController = TextEditingController();
  final TextEditingController _jan2022FeeController = TextEditingController();
  final TextEditingController _feb2022FeeController = TextEditingController();
  final TextEditingController _mar2022FeeController = TextEditingController();
  final TextEditingController _apr2022FeeController = TextEditingController();
  final TextEditingController _may2022FeeController = TextEditingController();


  CollectionReference _productss =
  FirebaseFirestore.instance.collection('OmKrishnaMonthlyFee');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _studentNameController.text = documentSnapshot['Student Name'];
      _classController.text = documentSnapshot['Class'];
      _streetNameController.text = documentSnapshot['Street Name'];
      _houseNoController.text = documentSnapshot['House No'];
      _fatherController.text = documentSnapshot['Father'];
      _motherController.text = documentSnapshot['Mother'];
      _fatherCellController.text = documentSnapshot['Father Cell'];
      _motherCellController.text = documentSnapshot['Mother Cell'];
      _jun2021FeeController.text = documentSnapshot['June 2021'];
      _jul2021FeeController.text = documentSnapshot['July 2021'];
      _aug2021FeeController.text = documentSnapshot['Aug 2021'];
      _sep2021FeeController.text = documentSnapshot['Sep 2021'];
      _oct2021FeeController.text = documentSnapshot['Oct 2021'];
      _nov2021FeeController.text = documentSnapshot['Nov 2021'];
      _dec2021FeeController.text = documentSnapshot['Dec 2021'];
      _jan2022FeeController.text = documentSnapshot['Jan 2022'];
      _feb2022FeeController.text = documentSnapshot['Feb 2022'];
      _mar2022FeeController.text = documentSnapshot['Mar 2022'];
      _apr2022FeeController.text = documentSnapshot['Apr 2022'];
      _may2022FeeController.text = documentSnapshot['May 2022'];

    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _studentNameController,
                      decoration: InputDecoration(labelText: 'Student Name'),
                    ),
                    TextField(
                     // keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _classController,
                      decoration: InputDecoration(
                        labelText: 'Class',
                      ),
                    ),
                    TextField(
                   //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _streetNameController,
                      decoration: InputDecoration(
                        labelText: 'Street Name',
                      ),
                    ),
                    TextField(
                      controller: _houseNoController,
                      decoration: InputDecoration(labelText: 'House Number'),
                    ),
                    TextField(
                      // keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _fatherController,
                      decoration: InputDecoration(
                        labelText: 'Father Name',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _motherController,
                      decoration: InputDecoration(
                        labelText: 'Mother Name',
                      ),
                    ),
                    TextField(
                      controller: _fatherCellController,
                      decoration: InputDecoration(labelText: 'Father Cell Number'),
                    ),
                    TextField(
                      // keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _motherCellController,
                      decoration: InputDecoration(
                        labelText: 'Mother Cell Number',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _jun2021FeeController,
                      decoration: InputDecoration(
                        labelText: 'Jun 2021 Fee',
                      ),
                    ),
                    TextField(
                      controller: _jul2021FeeController,
                      decoration: InputDecoration(labelText: 'Jul 2021 Fee'),
                    ),
                    TextField(
                      // keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _aug2021FeeController,
                      decoration: InputDecoration(
                        labelText: 'Aug 2021 Fee',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _sep2021FeeController,
                      decoration: InputDecoration(
                        labelText: 'Sep 2021 Fee',
                      ),
                    ),
                    TextField(
                      controller: _oct2021FeeController,
                      decoration: InputDecoration(labelText: 'Oct 2021 Fee'),
                    ),
                    TextField(
                      // keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _nov2021FeeController,
                      decoration: InputDecoration(
                        labelText: 'Nov 2021 Fee',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _dec2021FeeController,
                      decoration: InputDecoration(
                        labelText: 'Dec 2021 Fee',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _jan2022FeeController,
                      decoration: InputDecoration(
                        labelText: 'Jan 2022 Fee',
                      ),
                    ),
                    TextField(
                      controller: _feb2022FeeController,
                      decoration: InputDecoration(labelText: 'Feb 2022 Fee'),
                    ),
                    TextField(
                      // keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _mar2022FeeController,
                      decoration: InputDecoration(
                        labelText: 'Mar 2022 Fee',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _apr2022FeeController,
                      decoration: InputDecoration(
                        labelText: 'Apr 2022 Fee',
                      ),
                    ),
                    TextField(
                      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _may2022FeeController,
                      decoration: InputDecoration(
                        labelText: 'May 2022 Fee',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text(action == 'create' ? 'Create' : 'Update'),
                      onPressed: () async {
                        final String? name = _studentNameController.text;
                        final String? studentClass = _classController.text;
                        final String? street = _streetNameController.text;
                        final String? houseNo = _houseNoController.text;
                        final String? father = _fatherController.text;
                        final String? mother = _motherController.text;
                        final String? fatherCell = _fatherCellController.text;
                        final String? motherCell = _motherCellController.text;
                        final String? jun2021Fee = _jun2021FeeController.text;
                        final String? jul2021Fee = _jul2021FeeController.text;
                        final String? aug2021Fee = _aug2021FeeController.text;
                        final String? sep2021Fee = _sep2021FeeController.text;
                        final String? oct2021Fee = _oct2021FeeController.text;
                        final String? nov2021Fee = _nov2021FeeController.text;
                        final String? dec2021Fee = _dec2021FeeController.text;
                        final String? jan2022Fee = _jan2022FeeController.text;
                        final String? feb2022Fee = _feb2022FeeController.text;
                        final String? mar2022Fee = _mar2022FeeController.text;
                        final String? apr2022Fee = _apr2022FeeController.text;
                        final String? may2022Fee = _may2022FeeController.text;


                         if (name != null && studentClass != null) {
                          if (action == 'create') {
                            // Persist a new product to Firestore
                            await _productss.add({
                              "Student Name": name,
                              "Class": studentClass,
                              "Street Name": street,
                              "House No": houseNo,
                              "Father": father,
                              "Mother": mother,
                              "Father Cell": fatherCell,
                              "Mother Cell": motherCell,
                              "June 2021": jun2021Fee,
                              "July 2021": jul2021Fee,
                              "Aug 2021": aug2021Fee,
                              "Sep 2021": sep2021Fee,
                              "Oct 2021": oct2021Fee,
                              "Nov 2021": nov2021Fee,
                              "Dec 2021": dec2021Fee,
                              "Jan 2022": jan2022Fee,
                              "Feb 2022": feb2022Fee,
                              "Mar 2022": mar2022Fee,
                              "Apr 2022": apr2022Fee,
                              "May 2022": may2022Fee,
                            });
                          }

                          if (action == 'update') {
                            // Update the product
                            await _productss
                                .doc(documentSnapshot!.id)
                                .update({
                              "Student Name": name,
                              "Class": studentClass,
                              "Street Name": street,
                              "House No": houseNo,
                              "Father": father,
                              "Mother": mother,
                              "Father Cell": fatherCell,
                              "Mother Cell": motherCell,
                              "June 2021": jun2021Fee,
                              "July 2021": jul2021Fee,
                              "Aug 2021": aug2021Fee,
                              "Sep 2021": sep2021Fee,
                              "Oct 2021": oct2021Fee,
                              "Nov 2021": nov2021Fee,
                              "Dec 2021": dec2021Fee,
                              "Jan 2022": jan2022Fee,
                              "Feb 2022": feb2022Fee,
                              "Mar 2022": mar2022Fee,
                              "Apr 2022": apr2022Fee,
                              "May 2022": may2022Fee});
                          }

                          // Clear the text fields
                          _studentNameController.text = '';
                          _classController.text = '';
                          _streetNameController.text = '';
                          _houseNoController.text = '';
                          _fatherController.text = '';
                          _motherController.text = '';
                          _fatherCellController.text = '';
                          _motherCellController.text = '';
                          _jun2021FeeController.text = '';
                          _jul2021FeeController.text = '';
                          _aug2021FeeController.text = '';
                          _sep2021FeeController.text = '';
                          _oct2021FeeController.text = '';
                          _nov2021FeeController.text = '';
                          _dec2021FeeController.text = '';
                          _jan2022FeeController.text = '';
                          _feb2022FeeController.text = '';
                          _mar2022FeeController.text = '';
                          _apr2022FeeController.text = '';
                          _may2022FeeController.text = '';


                          // Hide the bottom sheet
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
/*
  void _delete(String productId, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Please Confirm'),
            content: Text('Are you sure to remove the data'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    _deleteProduct(productId);
                    setState(() {
                      _isShown = false;
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }  */

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment Records Page'),
          automaticallyImplyLeading: true,
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: StreamBuilder(
          stream: _productss.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['Student Name']),
                      subtitle: Text(documentSnapshot['Class']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Press this button to edit a single product
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot)),
                            // This icon button is used to delete a single product
                            GestureDetector(
                              onLongPress: () {
                                _deleteProduct(documentSnapshot.id);
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createOrUpdate(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}