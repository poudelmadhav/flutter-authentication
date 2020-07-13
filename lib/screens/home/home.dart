import 'package:flutter/material.dart';
import 'package:madhav_auth/screens/home/brew_list.dart';
import 'package:madhav_auth/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madhav_auth/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Madhav Auth'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
