import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_package/src/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'constants.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<Object> signInWithGoogle() async {
  try {
    Completer completer = Completer();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return Constants.canceledByUser;
    }

    Timer timer =
        Utils.requestTimeout(completer, Constants.connectionTimeout);

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    completer.complete(user);
    timer.cancel();
    return completer.future;
  } catch (e) {
    if (e == Constants.connectionTimeout) {
      return Constants.connectionTimeout;
    } else {
      return Constants.defaultGoogleError;
    }
  }
}

Future signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}