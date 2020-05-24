import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/components/b_appbar.dart';
import 'package:hotnews/bimbi/components/b_appbarcust.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/bimbi/models/b_customersBloc.dart';
import 'package:hotnews/bimbi/models/b_customersRepo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hotnews/bimbi/components/b_customer_anag_tab.dart';

enum CustomerTabsEnum { anagrafica, ordini }

class CustomerDetail extends StatefulWidget {
  final Customer customerSelected;

  CustomerDetail(this.customerSelected);

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
      //bloc.changeCategory(_tabController.index);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Scheda Cliente",
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
                height: 40,
                child: TabBar(
                  indicatorColor: Colors.green[700],
                  isScrollable: false,
                  labelColor: Colors.green[700],
                  tabs: customerTabsList,
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
          builder: _buildPage),
    );
  }

  Widget _buildPage(
      BuildContext context, AsyncSnapshot<CustomersBlocState> snapshot) {
    if (snapshot.data.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return TabBarView(
      controller: _tabController,
      children: customerTabsList.map<Widget>((Tab tab) {
        return customerAnagTab(widget.customerSelected);
      }).toList(),
    );
  }

  get customerTabsList => CustomerTabsEnum.values
      .map((e) => Tab(text: TabName(e).toUpperCase()))
      .toList();

  String TabName(CustomerTabsEnum category) =>
      category.toString().split('.').last;
}
