import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/models/articlesRepo.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.xing.com/image/1_c_c_86148506c_16884660_1/maria-konstadopulu-foto.1024x1024.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  'Kostadsadasoludou',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Text(
                  'kosta@esticazzi.org',
                  style: TextStyle(color: Colors.white),
                ),                
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Clean Favourites News',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          onTap: () {
                articlesHolder.cleanPrefs();
          }
        ),        
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Exit',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          onTap: null,
        ),        
      ],
    ));
  }


}
