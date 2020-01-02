import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';
import 'package:flutter_shop/model/CategoryGoodsList.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[RightCategoryNav(), CategoryGoodsList()],
            )
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryListModel> list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
          itemCount: list.length,
        ));
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = index == listIndex;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
//      默认给第一个数据
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
//  List list = ['名酒', '宝丰', '北京二锅头', '舍得', '茅台', '五粮液', '散白', '桑落'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      decoration:
          BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Provide<ChildCategory>(builder: (context, child, childCategory) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return _rightInkWell(childCategory.childCategoryList[index]);
          },
          itemCount: childCategory.childCategoryList.length,
          scrollDirection: Axis.horizontal,
        );
      }),
    );
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List<CategoryListData> list = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(960),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _listWidget(index);
        },
        itemCount: list.length,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGoodsList();
  }

  void getGoodsList() async {
    var data = {'categoryId': '2c9f6c946cd22d7b016cd732f0f6002f', 'categorySubId': '', 'page': '1'};
    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      setState(() {
        list = goodsList.data;
      });
    });
  }

  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${list[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '价格：￥${list[index].oriPrice}',
            style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }

  Widget _listWidget(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration:
            BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 0.5, color: Colors.black26))),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[_goodsName(index), _goodsPrice(index)],
            )
          ],
        ),
      ),
    );
  }
}
