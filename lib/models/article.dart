import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';

enum Category { all, accessories, clothing, home, }
@HiveType(typeId: 0)
class Article extends HiveObject{
  // hive non vuole final
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String author;
  
  @HiveField(2)  
  String title;  
  
  @HiveField(3)
  String description;
  
  @HiveField(4)
  String url;
  
  @HiveField(5)
  String urlToImage;
  
  @HiveField(6)
  String publishedAt;
  
  @HiveField(7)
  String content;

  @HiveField(8)
  String source;  

   Article({
     this.id,
     this.source,
     this.author,
     this.title,
     this.description,
     this.url,
     this.urlToImage,
     this.publishedAt,
     this.content
  });  

  factory Article.fromJson(Map<String, dynamic> json) {
    return new Article(
        id: toMd5(json['url']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content
      };

  static String toMd5(String json) {
    return md5.convert(utf8.encode(json)).toString();
  }  
}

class ArticleAdapter extends TypeAdapter<Article>{

  @override 
  Article read(BinaryReader reader){
  return Article()
        ..id = reader.read()
        ..author = reader.read()
        ..title = reader.read()
        ..description = reader.read()
        ..url = reader.read()
        ..urlToImage = reader.read()
        ..publishedAt = reader.read()
        ..source = reader.read();
  }

  @override 
  int get typeId => 0;

  @override 
  void write(BinaryWriter writer, Article obj) {
      writer.write(obj.id);
      writer.write(obj.author);
      writer.write(obj.title);
      writer.write(obj.description);
      writer.write(obj.url);
      writer.write(obj.urlToImage);
      writer.write(obj.publishedAt);
      writer.write(obj.source);
    }


}


