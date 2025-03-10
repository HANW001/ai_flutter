import 'package:ai_frontend/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

class ImwebOrderPage extends StatefulWidget {
  const ImwebOrderPage({super.key});

  @override
  State<ImwebOrderPage> createState() => _ImwebOrderPageState();
}

class _ImwebOrderPageState extends State<ImwebOrderPage> {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<ImwebAuthState>(context, listen: false);
    final urlState = Provider.of<UrlState>(context, listen: false);
    final accessState = Provider.of<AccessState>(context, listen: false);

    Future<void> _oauth() async {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/imweb/getImweb/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'apikey': authState.apikey,
          // 'clientSecretkey': authState.clientSecretkey,
          'servicekey': authState.servicekey,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var data = (jsonResponse['access_token']);
        print(data);

        Provider.of<UrlState>(context, listen: false).updateUrlData((data));

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('데이터 전송에 성공했습니다!')));
      } else {
        // Handle login error (e.g., display an error message)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다!')));
      }
    }

    Future<void> _reviews() async {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/imweb/getImwebReviews/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'access_token': urlState.reUrl,
          // 'servicekey': authState.servicekey,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var data = (jsonResponse['access_token']);
        // Provider.of<AccessState>(context, listen: false).updateUrlData((data));

        // Use listen: false when not updating UI
        print('Current mall: ${data}');

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('데이터 전송에 성공했습니다!')));
      } else {
        // Handle login error (e.g., display an error message)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다!')));
      }
    }

    Future<void> _access() async {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/imweb/getProducts/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'access_token': urlState.reUrl,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var data = (jsonResponse['access_token']);
        Provider.of<AccessState>(context, listen: false).updateUrlData((data));

        // Use listen: false when not updating UI
        print('Current mall: ${accessState.access_token}');

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('데이터 전송에 성공했습니다!')));
      } else {
        // Handle login error (e.g., display an error message)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다!')));
      }
    }

    Future<void> _edit() async {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/imweb/editProducts/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'access_token': urlState.reUrl,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var data = (jsonResponse['access_token']);
        Provider.of<AccessState>(context, listen: false).updateUrlData((data));

        // Use listen: false when not updating UI
        print('Current mall: ${accessState.access_token}');

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('데이터 전송에 성공했습니다!')));
      } else {
        // Handle login error (e.g., display an error message)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다!')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('아임웹 데이터 불러오기'),
      ),
      body: Column(
        children: [
          reusableElevatedButton('oauth', _oauth),
          const SizedBox(height: 16.0),
          reusableElevatedButton('reviews', _reviews),
          const SizedBox(height: 16.0),
          reusableElevatedButton('product', _access),
          const SizedBox(height: 16.0),
          reusableElevatedButton('edit', _edit),
        ],
      ),
    );
  }
}

ElevatedButton reusableElevatedButton(String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(label),
  );
}

String extractCode(String url) {
  return Uri.parse(url).queryParameters['code']!;
}
