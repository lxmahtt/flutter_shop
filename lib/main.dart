import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';

import 'pages/index_page.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();
  var categoryGoodsListProvide = CategoryGoodsListProvide();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活',
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}
