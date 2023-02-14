import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/success.dart';
import 'package:login_app/user_info.dart';

// ignore: camel_case_types
class addUser extends StatefulWidget {
  const addUser({Key? key}) : super(key: key);

  @override
  State<addUser> createState() => _AddUserState();
}

class _AddUserState extends State<addUser> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  //final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, labelText: 'User Name'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: genderController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, labelText: 'Gender'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, labelText: 'Age'),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     controller: dateController,
            //     decoration: const InputDecoration(labelText: 'Select Date '),
            //     onTap: () async {
            //       DateTime? pickeddate = await showDatePicker(
            //           context: context,
            //           initialDate: DateTime.now(),
            //           firstDate: DateTime(1900),
            //           lastDate: DateTime(2030));
            //       if (pickeddate != Null) {
            //         setState(() {
            //           dateController.text =
            //               DateFormat('yyyy-MM-dd').format(pickeddate!);
            //         });
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  final user = User(
                    name: userController.text,
                    gender: genderController.text,
                    age: int.parse(ageController.text),
                    // birthday: DateTime.parse(dateController.text)
                    //final Name1 = userController.text;
                  );
                  createUser(user);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Done()));
                },
                child: const Text('Create'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInformation())),
                child: const Text('Show Data'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('userDiana').doc();
    user.id = docUser.id;
    final json = user.tojson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String name;
  final String gender;
  final int age;
  // final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.gender,
    required this.age,
    //required this.birthday
  });
  Map<String, dynamic> tojson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'age': age,
        //'birthday': birthday
      };
}
