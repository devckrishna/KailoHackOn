import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kailo/models/userModel.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithEmail(String email, String password) async {
  UserCredential user;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return user;
}

Future<UserCredential> loginUser(String email, String password) async {
  UserCredential user;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user = userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return user;
}

Future<bool> authenticateUser(UserCredential user) async {
  QuerySnapshot result = await firestore
      .collection("users")
      .where("email", isEqualTo: user.user.email)
      .get();

  final List<DocumentSnapshot> docs = result.docs;

  return docs.length == 0 ? true : false;
}

Future<void> addDataToDb(User currentUser) async {
  String username = currentUser.displayName;

  User0 user = User0(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoURL,
      username: username,
      posts: []);

  firestore.collection("users").doc(currentUser.uid).set(user.toMap(user));
}

Future<User> getCurrentUser() async {
  User currentUser;
  currentUser = auth.currentUser;
  return currentUser;
}

Future<User> signOutUser() async {
  final gooleSignIn = GoogleSignIn();
  User user = auth.currentUser;
  await FirebaseAuth.instance.signOut();

  return user;
}
