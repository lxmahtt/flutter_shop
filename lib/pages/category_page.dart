import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());

      CategoryBigListModel list = CategoryBigListModel.fromJson(data['data']);
      list.categoryBigList.forEach((item) {
        print(item.mallCategoryName);
      });
    });
  }
}
