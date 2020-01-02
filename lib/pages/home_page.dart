import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  void initState() {
    super.initState();
//    到底部上拉自动加载数据
//    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
//        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('百胜生活'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList = (data['data']['category'] as List).cast();
              String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList = (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              List<Map> floor3 = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(
                      swiperDateList: swiper,
                    ),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(
                      picture_address: floor1Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor1,
                    ),
                    FloorTitle(
                      picture_address: floor2Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor2,
                    ),
                    FloorTitle(
                      picture_address: floor3Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor3,
                    ),
                    _hotGoods(),
                  ],
                ),
                onLoad: () async {
                  var formData = {'page': page};
                  await request('homePageBelowConten', formData: formData).then((value) {
                    var data = json.decode(value.toString());
                    List<Map> newGoodList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodList);
                      page++;
                    });
                  });
                },
                onRefresh: () async {},
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
          future: request('homePageContent', formData: formData),
        ));
  }

  /*//  获取数据
  void _getHotGoods() {
    var formData = {'page': page};
    request('homePageBelowConten', formData: formData).then((value) {
      var data = json.decode(value.toString());
      List<Map> newGoodList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodList);
        page++;
      });
    });
  }*/

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((value) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(327),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  value['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  value['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${value['mallPrice']}'),
                    Text(
                      '￥${value['price']}',
                      style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[hotTitle, _wrapList()],
      ),
    );
  }

//  保持页面状态
  @override
  bool get wantKeepAlive => true;
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    print('设置的像素密度:${ScreenUtil.pixelRatio}');
//    print('设置的高:${ScreenUtil.screenHeight}');
//    print('设置的宽:${ScreenUtil.screenWidth}');

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDateList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//网格状的选择
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({this.navigatorList});

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //大概处理下数据
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
//        禁止滚动
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//广告条
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({this.adPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({this.leaderImage, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          _launchURL();
        },
        child: Image.network(leaderImage),
      ),
    );
  }

//  拨打电话
  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能访问';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }

//  标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration:
          BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

//  商品单独项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(360),
        width: ScreenUtil().setWidth(240),
        padding: EdgeInsets.all(8.0),
        decoration:
            BoxDecoration(color: Colors.white, border: Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

//  横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _item(index);
        },
        itemCount: recommendList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle({this.picture_address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({this.floorGoodsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[_goodsItem(floorGoodsList[1]), _goodsItem(floorGoodsList[2])],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[_goodsItem(floorGoodsList[3]), _goodsItem(floorGoodsList[4])],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
