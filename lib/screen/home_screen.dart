import 'package:a14_sqflite/database/database_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student Database'),
      ),
      body: FutureBuilder<List<Map>>(
          future: DatabaseHelper().getAllStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map? student = snapshot.data![index];
                    return Card(
                      child: Column(
                        children: [
                          // Text(student['id'].toString()),
                          CircleAvatar(child: Text((index + 1).toString())),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Name'),
                            subtitle: Text(student['name']),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_city),
                            title: Text('Address'),
                            subtitle: Text(student['address']),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Phone'),
                            subtitle: Text(student['phone']),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text('Email'),
                            subtitle: Text(student['email']),
                          ),
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.data.toString());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          DatabaseHelper databaseHelper = DatabaseHelper();
          var result = await databaseHelper.insertStudent({
            'name': 'MyoMinLatt',
            'address': 'YGN',
            'phone': '091234567',
            'email': 'myo@gmail.com'
          });
          print(result);
        },
      ),
    );
  }
}