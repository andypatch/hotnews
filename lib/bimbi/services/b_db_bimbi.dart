import 'package:hive/hive.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/main.dart';

class DbBimbi {
  Box<Customer> customersToWork = Hive.box(CustomerToWorkBox);

  void addCustomer(Customer customer) => customersToWork.put(customer.id, customer);

  List<Customer> getCustomers() => customersToWork.values.toList();

  watch() => customersToWork.watch();
}
