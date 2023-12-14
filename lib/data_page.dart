import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Database _database;
  List<Users> _data = [];
  @override
  void initState() {
    super.initState();
    DBHelper().initDatabase();
    _getDataFromTable();
  }

  Future<void> _getDataFromTable() async {
    final List<Map<String, dynamic>> result = await _database.query('my_table');
    setState(() {
      // Convert the list of maps into a list of Person objects
      _data = result.map((map) => Users.fromMap(map)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Flutter Demo'),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Username: ${_data[index].username}'),
            subtitle: Text('Password: ${_data[index].password}'
                'Phone: ${_data[index].phone}'
                'Email: ${_data[index].email}'
                'Address: ${_data[index].address}'),
          );
        },
      ),
    );
  }
}