import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎你来到这里';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: '美女类型',
                      helperText: '请输入你喜欢的类型'),
                  autofocus: false,
                ),
                RaisedButton(
                  onPressed: () {
                    _chooseAction();
                  },
                  child: Text('选择完毕'),
                ),
                Text(
                  showText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseAction() {
    print('开始选择你喜欢的类型。。。');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('标题不能为空'),
          ));
    } else {
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          print(value);
          showText = value['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var data = {'name': typeText};
      response = await Dio().get(
          'http://easymock.fe.corp.anjuke.com/mock/5d89df6b13bd80637dfed161/example/query',
          queryParameters: data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
