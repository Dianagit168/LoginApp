// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'adduser.dart';
import 'home_screen.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('userDiana').snapshots();

  String updateName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage())),
          icon: const Icon(
            Icons.home,
            size: 35,
          ),
        ),
        title: const Text("All User"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ReorderableListView.builder(
            itemBuilder: (BuildContext context, int index) {
              debugPrint(snapshot.data!.docs.length.toString());
              return Card(
                  color: Colors.grey[200],
                  key: ValueKey(snapshot.data!.docs[index].id),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.account_box),
                        ),
                        title: Text(
                            "${snapshot.data!.docs[index]['name']}".toString()),
                        subtitle: Text(
                            "${snapshot.data!.docs[index]['age']}  ${snapshot.data!.docs[index]['gender']}  ${snapshot.data!.docs[index]['id']}"),
                        //title: Text("${data['id']} ${data['name']} ${data['age']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: (() {
                                  showDialog(
                                      //barrierColor: Colors.black,
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Are you want to delete?',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: ElevatedButton(
                                                      onPressed: (() {
                                                        setState(() {
                                                          DeleteData(snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      }),
                                                      child: const Text('Yes')),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: ElevatedButton(
                                                      onPressed: (() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      child: const Text('No')),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                })),
                            IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: (() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: TextFormField(
                                            initialValue: snapshot
                                                .data!.docs[index]['name'],
                                            onFieldSubmitted: ((value) {
                                              setState(() {
                                                updateName = value;
                                                Navigator.of(context).pop();
                                              });
                                            }),
                                          ),
                                        );
                                      });
                                  UpdateData(snapshot.data!.docs[index].id,
                                      updateName);

                                  setState(() {});
                                })),
                          ],
                        )),
                  ));

              //     title: Text("${data['id']} ${data['name']} ${data['age']}"),
            },
            itemCount: snapshot.data!.docs.length,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                final items = snapshot.data!.docs.removeAt(oldIndex);
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                  snapshot.data!.docs.insert(newIndex, items);
                }
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const addUser())),
            icon: const Icon(Icons.add_circle_outline),
          )),
    );
  }

  DeleteData(id) async {
    await FirebaseFirestore.instance.collection('userDiana').doc(id).delete();
  }

  void UpdateData(id, Value) async {
    await FirebaseFirestore.instance
        .collection('userDiana')
        .doc(id)
        .update({'name': Value});
  }
}
