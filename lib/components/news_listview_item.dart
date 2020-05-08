import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:hotnews/screens/news_detail.dart';
import 'package:share/share.dart';

import '../main.dart';

class NewsItem extends StatefulWidget {
  final Article article;

  NewsItem(this.article, {Key key}) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  Box<Article> favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box(NewsBox);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetail(widget.article)));
              },
              child: widget.article.urlToImage != null
                  ? Image(image: NetworkImage(widget.article.urlToImage))
                  : Text('No Picture Available'),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(widget.article.title,
                      style: TextStyle(fontSize: 16, color: Colors.black45)),
                ),
                SizedBox(
                  width: 15,
                ),
                Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        final RenderBox box = context.findRenderObject();
                        Share.share(widget.article.url,
                            subject: 'News sharing',
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      },
                      child: Icon(Icons.share),
                    );
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    /// add or remove favourites from list
                    this.onFavoritePress(widget.article);
                  },
                  child: manageFavIcons(widget.article.id),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onFavoritePress(Article currentArticle) {
    if (favoriteBox.containsKey(currentArticle.id)) {
      favoriteBox.delete(currentArticle.id);
    }
    else{
      favoriteBox.put(currentArticle.id, currentArticle);
    }
    final bloc = ArticlesRepo.of(context).bloc;
    bloc.favouritesChange();

  }

  Widget manageFavIcons(String id) {
    if (favoriteBox.containsKey(id)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }
}
