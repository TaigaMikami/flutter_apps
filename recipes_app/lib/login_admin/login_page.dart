import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes_app/auth/auth.dart';
import 'package:recipes_app/model/user_model.dart';
import 'package:recipes_app/login_admin/menu_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignIn});

  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }
enum SelectSource { camara, galeria }

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  // We declare the variables
  String _email;
  String _password;
  String _name;
  String _telephone;
  String _itemCity;
  String _address;
  String _urlPhoto = '';
  String user;


  bool _obscureText = true;
  FormType _formType = FormType.login;
  List<DropdownMenuItem<String>> _cityItems; // list city from Firestore


  @override
  void initState() {
    super.initState();
    setState(() {
      _cityItems = getCityItems();
      _itemCity = _cityItems[0].value;
    });
  }

  getData() async {
    return await Firestore.instance.collection('city').getDocuments();
  }

  // Dropdown list from firestore
  List<DropdownMenuItem<String>> getCityItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCities;
    getData().then((data) {

      dataCities = data;
      dataCities.documents.forEach((obj) {
        print('${obj.documentID} ${obj['name']}');
        items.add(DropdownMenuItem(
          value: obj.documentID,
          child: Text(obj['name']),
        ));
      });
    }).catchError((error) => print('There is an error.....' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('- Select -'),
    ));

    return items;
  }


  bool _validarGuardar() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //we create a method validate and send
  void _validarSubmit() async {
    if (_validarGuardar()) {
      try {
        String userId = await widget.auth.signInEmailPassword(_email, _password);
        print('Current User : $userId ');// ok
        widget.onSignIn();
        HomePage(auth: widget.auth);  // return menu_page.dart
        Navigator.of(context).pop();
      } catch (e) {
        print('Error .... $e');
        AlertDialog alert = new AlertDialog(
          content: Text('Authentication failed'),
          title: Text('Error'),
          actions: <Widget>[],
        );
        showDialog(context: context, child: alert);
      }
    }
  }

  //Now create a method validate and register
  void _validarRegistrar() async {
    if (_validarGuardar()) {
      try{
        User user = User(//model/user_model.dart instance usuario
          name: _name,
          city: _itemCity,
          address: _address,
          email: _email,
          password: _password,
          telephone: _telephone,
          photo: _urlPhoto);
        String userId = await widget.auth.signUpEmailPassword(user);
        print('Current User : $userId');//ok
        widget.onSignIn();
        HomePage(auth: widget.auth);  //menu_page.dart
        Navigator.of(context).pop();
      }catch (e){
        print('Error .... $e');
        AlertDialog alert = new AlertDialog(
          content: Text('Registration Error'),
          title: Text('Error'),
          actions: <Widget>[],
        );
        showDialog(context: context, child: alert);
      }
    }
  }
  //method go register
  void _goRegister() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.register;
    });
  }

  //method go Login
  void _goLogin() {
    setState(() {
      formKey.currentState.reset();
      _formType = FormType.login;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                  .stretch, // adjust the widgets to lso extremes
                children: [
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Text(
                    'World Recipes \n My recipes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                ] +
                  buildInputs() +
                  buildSubmitButtons()),
            )))
      ),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [ //list or array
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            icon: Icon(FontAwesomeIcons.envelope),
          ),
          validator: (value) =>
          value.isEmpty ? 'The Email field is empty' : null,
          onSaved: (value) => _email = value.trim(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            icon: Icon(FontAwesomeIcons.key),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            )
          ),
          validator: (value) => value.isEmpty
            ? 'The password field must have \n at least 6 characters'
            : null,
          onSaved: (value) => _password = value.trim(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
      ];
    } else {
      return [
        Row(mainAxisAlignment: MainAxisAlignment.center,),
        Text('Register User', style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Name', icon: Icon(FontAwesomeIcons.user)),
          validator: (value) =>
          value.isEmpty ? 'The Name field is empty' : null,
          onSaved: (value) => _name = value.trim(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Cell phone',
            icon: Icon(FontAwesomeIcons.phone),
          ),
          validator: (value) =>
          value.isEmpty ? 'The telephone field is empty' : null,
          onSaved: (value) => _telephone = value.trim(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        DropdownButtonFormField(
          validator: (value) =>
          value == '0' ? 'You must select a city' : null,
          decoration: InputDecoration(
            labelText: 'City', icon: Icon(FontAwesomeIcons.city)),
          value: _itemCity,
          items: _cityItems,
          onChanged: (value) {
            setState(() {
              _itemCity = value;
            });
          }, //seleccionarCiudadItem,
          onSaved: (value) => _itemCity = value,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Address',
            icon: Icon(Icons.person_pin_circle),
          ),
          validator: (value) =>
          value.isEmpty ? 'The Address field is empty' : null,
          onSaved: (value) => _address = value.trim()),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            icon: Icon(FontAwesomeIcons.envelope),
          ),
          validator: (value) =>
          value.isEmpty ? 'The Email field is empty' : null,
          onSaved: (value) => _email = value.trim(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        TextFormField(
          obscureText: _obscureText,//password
          decoration: InputDecoration(
            labelText: 'Password',
            icon: Icon(FontAwesomeIcons.key),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            )),
          validator: (value) => value.isEmpty
            ? 'The password field must have \n at least 6 characters'
            : null,
          onSaved: (value) => _password = value.trim(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          onPressed: _validarSubmit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.white,
              )
            ],
          ),
          color: Colors.orangeAccent,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          elevation: 8.0,
        ),
        FlatButton(
          child: Text(
            'Create an account',//create new acount
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          onPressed: _goRegister,
        ),
      ];
    } else {
      return [
        RaisedButton(
          onPressed:  _validarRegistrar,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Register Account",//register new acount
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
              Icon(
                FontAwesomeIcons.plusCircle,
                color: Colors.white,
              )
            ],
          ),
          color: Colors.orangeAccent,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          elevation: 8.0,
        ),
        FlatButton(
          child: Text(
            'Do you already have an account?',
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          onPressed: _goLogin,
        )
      ];
    }
  }
}
