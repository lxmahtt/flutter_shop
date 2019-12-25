import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';

//获取首页主题内容
Future request(url, formData) async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded;charset=UTF-8").toString();
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口返回${response.statusCode}');
    }
  } catch (e) {
    print(e.toString());
  }
}

//获取首页主题内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded;charset=UTF-8").toString();
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口返回${response.statusCode}');
    }
  } catch (e) {
    print(e.toString());
  }
}

//获取首页火爆专区
Future getHomePageBelowContent() async {
  try {
    print('开始获火爆专区...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded;charset=UTF-8").toString();
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口返回${response.statusCode}');
    }
  } catch (e) {
    print(e.toString());
  }
}
