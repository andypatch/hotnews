
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesBloc.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:hotnews/screens/animations.dart';
import 'package:hotnews/screens/bimbi/bimbi.dart';
import 'package:hotnews/screens/map/firstmap.dart';
import 'bimbi/screens/b_customerlist.dart';
import 'bimbi/screens/b_home.dart';
import 'bimbi/screens/b_maps.dart';
import 'common/theme.dart';
import 'screens/home.dart';
import 'screens/bimbi/mockup.dart';




const String NewsBox = "NewsBox";
void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>(NewsBox);
  GoogleMap.init('AIzaSyDrIYsRnH2sDGDuedlv_Sy2J1rxmo6SWTk');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bloc = ArticlesBloc();
  
  @override
  Widget build(BuildContext context) {
    //  Using MultiProvider is convenient when providing multiple objects.
    return ArticlesRepo(
      bloc: bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HotNews',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          ///'/': (context) => MyHome(),
          '/': (context) => bCustomerList(),
        },
      ),
    );
  }
}
