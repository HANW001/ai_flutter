import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

// String host = '10.0.2.2:8000';
String host = '127.0.0.1:8000';
String path = 'user/postImwebUser/';

class ImwebJoin extends StatefulWidget {
  const ImwebJoin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ImwebJoin> {
  final _formKey = GlobalKey<FormState>();
  final _mallController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiController = TextEditingController();
  final _secretKeyController = TextEditingController();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Collect user data
        final userData = {
          'mall': _mallController.text, // Update with a value for 'mall' field
          'id': _usernameController.text,
          'password': _passwordController.text,
          'api_key': _apiController.text,
          'secret_key': _secretKeyController.text,
        };

        var url = Uri.http(host, path);
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(userData),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('회원가입에 성공했습니다!')));

          // Navigate to a different screen
          context.go('/login');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('회원가입에 실패했습니다!')));
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('오류가 발생했습니다!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아임웹 회원가입'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  inputField(_mallController, '쇼핑몰명'),
                  const SizedBox(height: 16.0),
                  inputField(_usernameController, '아이디'),
                  const SizedBox(height: 16.0),
                  inputField(_passwordController, '비밀번호'),
                  const SizedBox(height: 16.0),
                  inputField(_apiController, 'API'),
                  const SizedBox(height: 16.0),
                  inputField(_secretKeyController, '시크릿 키'),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signup();
                      }
                    },
                    child: const Text('회원가입'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget inputField(
  TextEditingController controller,
  String labelText,
) {
  return TextFormField(
    key: UniqueKey(), // Ensure each instance has a unique key
    decoration: InputDecoration(
      labelText: labelText,
    ),
    controller: controller,
    // obscureText: true,
    validator: (value) {
      if (value!.isEmpty) {
        return '$labelText를 입력하세요.';
      }
      // Add any additional password validation rules here
      return null;
    },
  );
}
