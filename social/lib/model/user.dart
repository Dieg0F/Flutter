import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uId;
  String name;
  String phoneNumber;
  String email;
  String photoUrl;
  String userFrom;

  User(
      {this.uId,
      this.name,
      this.phoneNumber,
      this.email,
      this.photoUrl,
      this.userFrom});

  factory User.fromFirebase(FirebaseUser firebaseUser) => User(
      uId: firebaseUser.providerId,
      name: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      email: firebaseUser.email,
      photoUrl: firebaseUser.photoUrl,
      userFrom: "Google");

  factory User.fromFacebook(Map<String, dynamic> facebookUser) => User(
      uId: facebookUser['id'],
      name: facebookUser['name'],
      phoneNumber: "",
      email: facebookUser['email'],
      photoUrl: facebookUser['picture']['data']['url'],
      userFrom: "Facebook");

  factory User.fromJson(Map<String, dynamic> serverUser) => User();
}
