enum Category { all, accessories, clothing, home, }

class Article {

  final String author;
  final String title;  
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

   Article({
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
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content
      };  
}


