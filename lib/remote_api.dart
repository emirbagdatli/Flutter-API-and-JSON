import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_http/model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({Key? key}) : super(key: key);

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<UserModel>> _getUserList() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      List<UserModel> _userList = [];

      if (response.statusCode == 200) {
        _userList =
            (response.data as List).map((e) => UserModel.fromMap(e)).toList();
        debugPrint(response.data.toString());
      }
      return _userList;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

  late final Future<List<UserModel>> _userList;
  @override
  void initState() {
    super.initState();
    _userList = _getUserList();
  }

  @override
  Widget build(BuildContext context) {
    _getUserList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Api with Dio'),
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
            future: _userList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userList = snapshot.data!;
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      var user = userList[index];
                      return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.username),
                          leading: CircleAvatar(
                            child: Text(user.id.toString()),
                          ));
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
