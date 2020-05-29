
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesBloc.dart';
import 'package:hotnews/bimbi/models/b_customersBloc.dart';
import 'package:hotnews/screens/animations.dart';
import 'package:hotnews/screens/bimbi/bimbi.dart';
import 'package:hotnews/screens/map/firstmap.dart';
import 'bimbi/models/b_customersRepo.dart';
import 'bimbi/screens/b_customer_detail.dart';
import 'bimbi/screens/b_customerlist.dart';
import 'bimbi/screens/b_home.dart';
import 'bimbi/screens/b_maps.dart';
import 'common/theme.dart';
import 'screens/home.dart';
import 'screens/bimbi/mockup.dart';
import 'bimbi/models/b_customer.dart';




const String NewsBox = "NewsBox";
const String CustomerToWorkBox = "CustBox";
void main() async{

  /// Hive initializing
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(CustomerAdapter());

  await Hive.openBox<Article>(NewsBox);
  await Hive.openBox<Customer>(CustomerToWorkBox);

  
  /// GMaps initializing
  GoogleMap.init('AIzaSyDrIYsRnH2sDGDuedlv_Sy2J1rxmo6SWTk');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bloc = CustomersBloc();
  
  @override
  Widget build(BuildContext context) {
    //  Using MultiProvider is convenient when providing multiple objects.
    return CustomersRepo(
      bloc: bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HotNews',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => bHome(),
          ///'/': (context) => bCustomerList(),
          
        },
      ),
    );
  }
}
