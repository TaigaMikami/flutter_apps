import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipes_app/auth/auth.dart';
import 'package:recipes_app/login_admin/contentPage.dart';
import 'package:recipes_app/widgets/home_page.dart';

const PrimaryColor = const Color(0xFF19212B);

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String user = 'User';
  String userEmail = 'Email';
  String id;

  Content page = ContentPage();
  Widget contentPage = HomePageRecipes();

  void _signOut() async {
    try {
      widget.auth.signOut();
      widget.onSignedOut();
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.auth.infoUser().then((onValue) {
      user = onValue.displayName;
      userEmail = onValue.email;
      id = onValue.uid;
      print('ID $id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 30.0,
        child: Container(
          color: Color(0xFF19212B),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  maxRadius: 10.0,
                  backgroundImage: AssetImage('assets/images/cocina.jpg'),
                ),
                accountName: Text(
                  '$user',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  '$userEmail',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF262F3D),
                  image: DecorationImage(
                    alignment: Alignment(1.0, 0),
                    image: AssetImage(
                      'assets/images/misanplas.jpg',
                    ),
                    fit: BoxFit.scaleDown,
                  )
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  page.lista().then((value) {
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(Icons.home, color: Color(0xFF4FC3F7),),
                title: Text('Home', style: TextStyle(color: Colors.white),),
              ),
              Divider(height: 2.0, color: Colors.white,),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  page.myrecipe(id).then((value) {
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(FontAwesomeIcons.pizzaSlice, color: Color(0xFF4FC3F7),),
                title: Text('My Recipe', style: TextStyle(color: Color(0xFF4FC3F7)),),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  page.admin().then((value) {
                    print(value);
                    setState(() {
                      contentPage = value;
                    });
                  });
                },
                leading: Icon(Icons.contact_mail, color: Color(0xFF4FC3F7),),
                title: Text('Admin', style: TextStyle(color: Color(0xFF4FC3F7)),),
              ),
              Divider(height: 2.0, color: Colors.white,),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  _signOut();
                },
                leading: Icon(Icons.exit_to_app, color: Color(0xFF4FC3F7),),
                title: Text('Log Out', style: TextStyle(color: Colors.white),),
              ),
              Divider(height: 2.0, color: Colors.white,),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text('Menu Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.grid_on),
            tooltip: 'Grid',
            onPressed: () {

            },
          ),
        ],
      ),
      body: contentPage,
    );
  }
}

