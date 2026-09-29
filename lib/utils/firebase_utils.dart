import 'package:cloud_firestore/cloud_firestore.dart';


import '../models/my_user.dart';

class FireBaseUtils {
  static CollectionReference<MyUser> getUsersCollections() {
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(

      fromFirestore: ((snapshot, options) =>
          MyUser.fromFireStore(snapshot.data()!)),

      toFirestore: (user, options) => user.toFireStore(),
    );
  }


  static Future<void> addUserInFireStore(MyUser myUser) {
    // todo:1-collection
    CollectionReference<MyUser> collectionRef = getUsersCollections();
    //todo:2-document
    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.id);
    //todo:3- add data

    return docRef.set(myUser);

    ///getUsersCollections().doc(myUser.id).set(myUser);


  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUser> querySnapshot = await getUsersCollections()
        .doc(uId).get();
    return querySnapshot.data();
  }

}