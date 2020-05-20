import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/bimbi/services/b_api.dart';
import 'package:hotnews/bimbi/services/b_db_bimbi.dart';


import '../../main.dart';


enum AppScreen { main, favorites }

enum CategoriesEnum {
  lista,
  dalavorare
}

// interessante
String categoryName(CategoriesEnum category) =>
    category
        .toString()
        .split('.')
        .last;


class CustomersBloc {
  
  CustomersBlocState _currentState;
  
  final DbBimbi _dbRepository = DbBimbi();
  final Map<String, List<Customer>> _customerMap = Map();
  final Map<String, List<Customer>> _customerMapSafeCopy = Map();

  CategoriesEnum _actualCategory = CategoriesEnum.lista;
  AppScreen _actualScreen = AppScreen.main;

  StreamSubscription<Customer> _fetchArticlesSub;

  final _customersController = StreamController<CustomersBlocState>.broadcast();
  final _screenController = StreamController<CategoriesEnum>.broadcast();
  final _actualScreenController = StreamController<AppScreen>.broadcast();

  Stream<CategoriesEnum> get actualCategory => _screenController.stream;
  Stream<AppScreen> get actualScreen => _actualScreenController.stream;
  Stream<CustomersBlocState> get customersStream => _customersController.stream;

  void changeScreen(int index) {
    _currentState.bottomIndex = index;
    _actualScreen = AppScreen.values[index];
    _actualScreenController.sink.add(_actualScreen);
    _manageArticles();
  }

  void _manageArticles(){
    if (AppScreen.favorites == _actualScreen) {
          _currentState.customerMap[categoryName(_actualCategory)] = _dbRepository.getCustomers();
          _currentState.loading = false;
          _customersController.add(_currentState);      
    }
    else {
      fetchCustomers();
    }      
  }

  void changeCategory (int index){
    _actualCategory = CategoriesEnum.values[index];
    //_articles.sink.add(null); //Clear news
    _screenController.sink.add(_actualCategory);
    fetchCustomers(); 
  }

  CustomersBloc(){
    _currentState = CustomersBlocState.empty();
    _dbRepository.watch().forEach((element){
      print ("Update" + element.toString());
    });
  }
  /// current state getter
  CustomersBlocState getCurrentState() {
    return _currentState;
  }
 

  String categoryName(CategoriesEnum category) =>
    category
        .toString()
        .split('.')
        .last;

  void fetchCustomers() {
    _fetchArticlesSub?.cancel();
    _currentState.loading = true;
    _customersController.add(_currentState);

    BApi().fetchCustomers(categoryName(_actualCategory))
        .asStream()
        .listen((dynamic result) {
          if (result is List<Customer>) {
            _currentState.customerMap[categoryName(_actualCategory)] = result;
          }
          _currentState.loading = false;
          _customersController.add(_currentState);
          _customerMap.addAll(_currentState.customerMap);
    });
  }

  void favouritesChange(){
    _customersController.add(_currentState);
  }

  void startSearch() {
    _customerMapSafeCopy.clear();
    _customerMapSafeCopy.addAll(_customerMap);    
  }

  void stopSearch() {
    _customerMap.clear();
    _customerMap.addAll(_customerMapSafeCopy);    
    _currentState.customerMap.clear();
    _currentState.customerMap.addAll(_customerMap);
    _customersController.add(_currentState);
  }  
  


  dispose(){
    _screenController?.close();
    _actualScreenController?.close();
    _customersController?.close();
  }

  void cleanFav() {
    Box<Customer> favoriteBox;
    favoriteBox = Hive.box(NewsBox);
    favoriteBox.clear();
     _customersController.add(_currentState);
  }

}
class CustomersBlocState {
  int bottomIndex=0;
  bool loading;
  Map<String, List<Customer>> customerMap = Map();

  CustomersBlocState(this.loading, this.customerMap);

  CustomersBlocState.empty() {
    loading = false;
    customerMap = Map();
  }  
  
}

