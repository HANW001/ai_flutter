// import 'dart:convert' as convert;
import 'dart:convert';

import 'package:ai_frontend/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // try {
      // var url = Uri.http('10.0.2.2:8000', '/user/login/');
      var url = Uri.http('127.0.0.1:8000', '/user/login/');
      var response = await http.post(
        url,
        body: {
          'id': _usernameController.text,
          'password': _passwordController.text
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var token =
            jsonResponse['token']; // Assuming your API returns a 'token'
        // print(token);

        // Store the token securely
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        var data = (jsonResponse['userData']);
        print(data);
        Provider.of<AuthState>(context, listen: false)
            .updateUserData((data[0]));
        final authState = Provider.of<AuthState>(context,
            listen: false); // Use listen: false when not updating UI
        print('Current mall: ${authState.id}');
        print('Current mall: ${authState.clientSecretkey}');
        // print(authState.mall)
        // Navigate to a protected route
        GoRouter.of(context).go('/home');
      } else {
        // Handle login error (e.g., display an error message)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그인에 실패했습니다!')));
      }
      // } catch (e) {
      //   // Handle network errors
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text('네트워크 오류!')));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        actions: [
          ElevatedButton(
            // icon: const Icon(Icons.save),
            onPressed: () =>
                GoRouter.of(context).push('/join'), // Use GoRouter.of(context)
            child: Text('Go to Join'),
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '아이디',
                  ),
                  controller: _usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '아이디를 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '비밀번호를 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
