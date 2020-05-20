import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hotnews/bimbi/components/b_appbar.dart';
import 'package:hotnews/bimbi/components/b_bottombar.dart';
import 'package:hotnews/bimbi/components/b_container_bimby.dart';
import 'package:hotnews/bimbi/components/b_customer_listview_item.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/bimbi/models/b_customersBloc.dart';
import 'package:hotnews/bimbi/models/b_customersRepo.dart';

import '../../main.dart';

class bCustomerList extends StatefulWidget {
  bCustomerList({Key key}) : super(key: key);

  @override
  _bCustomerListState createState() => _bCustomerListState();
}

class _bCustomerListState extends State<bCustomerList>
    with SingleTickerProviderStateMixin {
  Box<Customer> customersToWorkBox;
  TabController _tabController;
  bool _firstTimeLoad = true;

  _bCustomerListState() {
    customersToWorkBox = Hive.box(CustomerToWorkBox);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);

    // bloc.fetchArticles();
  }

  void _handleTabSelection() async {
    if (!_tabController.indexIsChanging) {
      final bloc = CustomersRepo.of(context).bloc;
      bloc.changeCategory(_tabController.index);
    } else
      print("Tab is switching..from active to inactive");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomersBloc bloc = CustomersRepo.of(context).bloc;
    if (_firstTimeLoad) {
      _firstTimeLoad = false;
      bloc.fetchCustomers();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
                height: 26,
                child: Image(
                  image: AssetImage('assets/bimby.png'),
                )),
            Expanded(
              child: Container(),
            ),
            Text("Clienti",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(),
            ),
            Text("",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(width: 12),
            Text("",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: StreamBuilder<AppScreen>(
            stream: bloc.actualScreen,
            builder: (context, AsyncSnapshot<AppScreen> snapshot) {
              return Container(
                height:40,
                child: TabBar(
                  indicatorColor:  Colors.green[700],
                  isScrollable: false,
                  labelColor: Colors.green[700],
                  tabs: categories,
                  controller: _tabController,
                ),
              );
            },
          ),
        ),
      ),
      body: StreamBuilder<CustomersBlocState>(
          initialData: bloc.getCurrentState(),
          stream: bloc.customersStream,
          builder: _buildList),
      bottomNavigationBar: BbottomBar(),
    );
  }

  Widget _buildList(
      BuildContext context, AsyncSnapshot<CustomersBlocState> snapshot) {
    if (snapshot.data.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return TabBarView(
      controller: _tabController,

      /// TODO: spiegare perchè senza <Widget> non funziona un cazzo
      children: categories.map<Widget>((Tab tab) {
        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: ListView.builder(
              itemCount: snapshot.data.customerMap[tab.text.toLowerCase()] ==
                      null
                  ? 0
                  : snapshot.data.customerMap[tab.text.toLowerCase()].length,
              itemBuilder: (context, position) => CustomerItem(
                  snapshot.data.customerMap[tab.text.toLowerCase()][position]),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget topBar(AppScreen appScreen) {
    switch (appScreen) {
      case AppScreen.favorites:
        return Container();
      case AppScreen.main:
      default:
        return TabBar(
          isScrollable: true,
          labelColor: Colors.white,
          tabs: categories,
          controller: _tabController,
        );
    }
  }

  get categories => CategoriesEnum.values
      .map((e) => Tab(text: categoryName(e).toUpperCase()))
      .toList();
}

//Text("",style:  TextStyle(fontFamily: 'Bimby', fontSize: 30),)

// Container(
//         decoration: BoxDecoration(color: Colors.grey[200]),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             child: Row(children: <Widget>[
//               Text("Totale: " + "290"),
//               Expanded(child: Text("")),
//               Text(
//                 " ",
//                 style: TextStyle(fontSize: 20, color: Colors.grey),
//               ),
//               Text(
//                 " ",
//                 style: TextStyle(fontSize: 20, color: Colors.grey),
//               ),
//               Text(
//                 "",
//                 style: TextStyle(fontSize: 20, color: Colors.grey),
//               ),
//             ]),
//           ),
//         ),
//       ),
