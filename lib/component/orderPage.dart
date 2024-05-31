import 'package:ai_frontend/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    final urlState = Provider.of<UrlState>(context, listen: false);
    final accessState = Provider.of<AccessState>(context, listen: false);

    final _urlController = TextEditingController();

    Future<void> _oauth() async {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/order/getOauth/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'clientId': authState.clientId,
          // 'clientSecretkey': authState.clientSecretkey,
          // 'servicekey': authState.servicekey,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var data = (jsonResponse['reUrl']);

        Provider.of<UrlState>(context, listen: false).updateUrlData((data));

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
      var url = Uri.http('127.0.0.1:8000', '/order/getAccess/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'code': extractCode(_urlController.text),
          'clientId': authState.clientId,
          'clientSecretkey': authState.clientSecretkey,
          // 'servicekey': authState.servicekey,
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

    Future<void> _order() async {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/order/getOrder/');
      var response = await http.post(
        url,
        body: {
          'id': authState.id,
          'clientId': authState.clientId,
          'clientSecretkey': authState.clientSecretkey,
          'servicekey': authState.servicekey,
          'access_token': accessState.access_token,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var data = (jsonResponse);
        print(data);
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
        title: const Text('데이터 불러오기'),
      ),
      body: Column(
        children: [
          reusableElevatedButton('oauth', _oauth),
          const SizedBox(height: 16.0),
          ElevatedButton(
              onPressed: () async {
                final url = Uri.parse(urlState.reUrl.toString());

                await launchUrl(url);
              },
              child: const Text('token')),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'URL',
            ),
            controller: _urlController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'URL을 입력하세요.';
              }
              return null;
            },
          ),
          reusableElevatedButton('access', _access),
          reusableElevatedButton('order', _order),
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
