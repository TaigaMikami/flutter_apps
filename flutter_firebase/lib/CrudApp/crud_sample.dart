import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class CrudSample extends StatefulWidget {

  @override
  CrudSampleState createState() {
    return new CrudSampleState();
  }
}

class CrudSampleState extends State<CrudSample> {
  String myText = null;
  StreamSubscription<DocumentSnapshot> subscription;

  final DocumentReference documentReference = Firestore.instance.document("myData/dummy");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    print('hoge');
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    print(googleSignInAccount);
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    print(gSA);

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken
    );
    print(credential);

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("User Name: ${user.displayName}");
    return user;
  }

  void _signOut() {
    _googleSignIn.signOut();
    print("User sign out");
  }

  void _add() {
    Map<String, String> data = <String, String> {
      "name": "Taiga Mikami",
      "desc": "Flutter Developer"
    };
    documentReference.setData(data).whenComplete((){
      print("Document Added");
    }).catchError((e) => print(e));
  }

  void _delete() {
    documentReference.delete().whenComplete((){
      print("Deleted Successfully");
    }).catchError((e) => print(e));
  }

  void _update() {
    Map<String, String> data = <String, String> {
      "name": "Taiga Mikami Updated",
      "desc": "Flutter Developer Updated"
    };
    documentReference.updateData(data).whenComplete((){
      print("Document Updated");
    }).catchError((e) => print(e));
  }

  void _fetch() {
    documentReference.get().then((datasnapshot){
      if(datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot){
      if(datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Firebase Demo"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: ()=> _signIn()
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e)),
              child: Text("Sign In"),
              color: Colors.green,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _signOut,
              child: Text("Sign out"),
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _add,
              child: Text("Add"),
              color: Colors.indigo,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _update,
              child: Text("Update"),
              color: Colors.lightBlue,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _delete,
              child: Text("Delete"),
              color: Colors.orange,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _fetch,
              child: Text("Fetch"),
              color: Colors.lime,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            myText == null ? new Container() : new Text(myText, style: new TextStyle(fontSize: 32.0),)
          ],
        ),
      )
    );
  }
}
