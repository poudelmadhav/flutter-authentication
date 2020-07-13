import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // get brews stream
  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}