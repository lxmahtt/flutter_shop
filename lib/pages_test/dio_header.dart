import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/http_headers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求远程数据'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _jike();
              },
              child: Text('请求数据'),
            ),
            Text(showText)
          ],
        ),
      ),
    );
  }

  void _jike() {
    print('开始请求数据');
    getHttp().then((value) {
      setState(() {
        showText = value['data'].toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response =
      await dio.get('https://time.geekbang.org/serv/v1/column/label_skus');
      print(response);
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
