
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference nameCollection = FirebaseFirestore.instance.collection('people');

  Future updateUserData(String name)async{
    return await nameCollection.doc(uid).set(
      {
        'member':name,
      }
    );
  }
}