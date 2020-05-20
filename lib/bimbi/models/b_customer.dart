import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';

enum Category { all, accessories, clothing, home, }

@HiveType(typeId: 1)
class Customer extends HiveObject{
  // hive non vuole final
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String firstName;
  
  @HiveField(2)  
  String surName;  
  
  @HiveField(3)
  String address;
  
  @HiveField(4)
  String civic;
  
  @HiveField(5)
  String zipCode;
  
  @HiveField(6)
  String city;
  
  @HiveField(7)
  String phone;

  @HiveField(8)
  String email;  

   Customer({
     this.id,
     this.firstName,
     this.surName,
     this.address,
     this.civic,
     this.zipCode,
     this.city,
     this.phone,
     this.email
  });  

  factory Customer.fromJson(Map<String, dynamic> json) {
    return new Customer(
        id: json['id'],
        firstName: json['firstName'],
        surName: json['surName'],
        address: json['address'],
        civic: json['civic'],
        zipCode: json['zipCode'],
        city: json['city'],
        phone: json['phone'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'surName': surName,
        'address': address,
        'civic': civic,
        'zipCode': zipCode,
        'city': city,
        'phone': phone,
        'email': email
      };

  static String toMd5(String json) {
    return md5.convert(utf8.encode(json)).toString();
  }  
}

class CustomerAdapter extends TypeAdapter<Customer>{

  @override 
  Customer read(BinaryReader reader){
  return Customer()
        ..id = reader.read()
        ..firstName = reader.read()
        ..surName = reader.read()
        ..address = reader.read()
        ..civic = reader.read()
        ..zipCode = reader.read()
        ..city = reader.read()
        ..phone = reader.read()
        ..email = reader.read();
  }

  @override 
  int get typeId => 1;

  @override 
  void write(BinaryWriter writer, Customer obj) {
      writer.write(obj.id);
      writer.write(obj.firstName);
      writer.write(obj.surName);
      writer.write(obj.address);
      writer.write(obj.civic);
      writer.write(obj.zipCode);
      writer.write(obj.city);
      writer.write(obj.phone);
      writer.write(obj.email);
    }


}


