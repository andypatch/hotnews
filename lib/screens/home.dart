// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:hotnews/models/articlesRepo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new Center(
          child: Consumer<ArticlesRepo>(builder: (context, news, child) {
            return ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, position) => Text(
                      news.articles[position].title,
                    ));
          }),
        ),
      ),
    );
  }
}
