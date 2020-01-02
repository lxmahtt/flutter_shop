import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '';
  String categorySubId = '';

//  大类切换
  getChildCategory(List<BxMallSubDto> list, String categoryId) {
//    每次点击大类，都清空为0
    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);

    categoryId = categoryId;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String categorySubId) {
    childIndex = index;
    categorySubId = categorySubId;
    notifyListeners();
  }
}
