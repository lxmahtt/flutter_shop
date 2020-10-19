import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '';
  String categorySubId = '';
  int page = 1; //列表页
  String noMoreText = ''; //没有数据时，显示的文字

  //  大类切换
  getChildCategory(List<BxMallSubDto> list, String categoryId) {
    //    每次点击大类，都清空为0
    page = 1; //默认给1，
    noMoreText = '';
    childIndex = 0; //每次点击都要清0
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
    page = 1; //默认给1，
    noMoreText = '';
    childIndex = index;
    categorySubId = categorySubId;
    notifyListeners();
  }

  //增加page的方法
  addPage() {
    page++;
    //不用进行通知
  }

  //改变加载完成显示的文字
  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
