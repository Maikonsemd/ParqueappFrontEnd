import 'package:flutter/material.dart';
import 'package:sqlite/screen/CategoriesScreen.dart';
import 'package:sqlite/screen/HomeScreen.dart';
import 'package:sqlite/screen/OcorrenciasScreen.dart';

class DrawerNavegation extends StatefulWidget {
  @override
  _DrawerNavegationState createState() => _DrawerNavegationState();
}

class _DrawerNavegationState extends State<DrawerNavegation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/783088415608668160/qXitYIpC_400x400.jpg'),
                ),
                accountName: Text('Steve Lacerda'),
                accountEmail: Text('steve@gmail.com')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categorias'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Ocorrencias'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Ocorrencias())),
            ),
          ],
        ),
      ),
    );
  }
}
