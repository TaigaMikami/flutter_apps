import 'package:flutter/material.dart';
import 'Authentication.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({this.auth, this.onSignedIn});
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

   State<StatefulWidget> createState() {
      return _LoginRegisterState();
   }
}

enum FormType {
  login,
  register
}

class _LoginRegisterState extends State<LoginRegisterPage> {

  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  // Methods
  bool validateAndSave() {
    final form = formKey.currentState;

    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;

    }
  }

  void validateAndSubmit() async {
    if(validateAndSave()) {
      try {
        if(_formType == FormType.login) {
          String userId = await widget.auth.SignIn(_email, _password);
          print("login userId = " + userId);
        } else {
          String userId = await widget.auth.SignUp(_email, _password);
          print("Register userId = " + userId);
        }

        print('hoge');
        widget.onSignedIn();
      } catch(e) {
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  // Design
   @override
   Widget build(BuildContext context) {
     return new Scaffold(
        appBar: new AppBar(
           title: new Text('Blog App'),
        ),
       body: new Container(
         margin: EdgeInsets.all(15.0),
         child: new Form(
           key: formKey,
           child: new Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: createInputs() + createButtons(),
           )
         ),
       ),
     );
  }

  List<Widget> createInputs() {
     return [
       SizedBox(height: 10.0,),
       logo(),
       SizedBox(height: 20.0,),

       new TextFormField(
         decoration: new InputDecoration(labelText: 'Email'),

         validator: (value) {
           return value.isEmpty ? 'Email is required' : null;
         },

         onSaved: (value) {
           return _email = value;
         },
       ),

       SizedBox(height: 20.0,),

       new TextFormField(
         decoration: new InputDecoration(labelText: 'Password'),
         obscureText: true,

         validator: (value) {
           return value.isEmpty ? 'Password is required' : null;
         },

         onSaved: (value) {
           return _password = value;
         },
       ),

       SizedBox(height: 20.0,),
     ];
  }

  Widget logo() {
     return new Hero(
       tag: 'hero',
       child: new CircleAvatar(
         backgroundColor: Colors.transparent,
         radius: 110.0,
         child: Image.asset('assets/logo.jpeg'),
       )
     );
  }

   List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text("Login", style: TextStyle(fontSize:  20.0),),
          textColor: Colors.white,
          color: Colors.pink,
        ),
        new FlatButton(
          onPressed: moveToRegister,
          child: new Text("Not have an Account? Create Account?", style: TextStyle(fontSize: 14.0),),
          textColor: Colors.red,
        )
      ];
    } else {
      return [
        new RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text("Register", style: TextStyle(fontSize:  20.0),),
          textColor: Colors.white,
          color: Colors.pink,
        ),
        new FlatButton(
          onPressed: moveToLogin,
          child: new Text("Alreadh have an Account? Login", style: TextStyle(fontSize: 14.0),),
          textColor: Colors.red,
        )
      ];
    }
   }
}
