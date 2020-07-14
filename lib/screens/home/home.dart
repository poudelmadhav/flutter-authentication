import 'package:flutter/material.dart';
import 'package:madhav_auth/models/brew.dart';
import 'package:madhav_auth/screens/home/brew_list.dart';
import 'package:madhav_auth/screens/home/settings_form.dart';
import 'package:madhav_auth/services/auth.dart';
import 'package:madhav_auth/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
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
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                'settings',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
