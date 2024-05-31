import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  String? mall;
  String? id;
  String? clientId;
  String? clientSecretkey;
  String? servicekey;

  // 생성자 (필요에 따라 생략 가능)
  AuthState({this.mall, this.clientId, this.clientSecretkey, this.servicekey});

  void updateUserData(Map<String, dynamic> data) {
    mall = data['mall'];
    id = data['id'];
    clientId = data['client_id'];
    clientSecretkey = data['client_secretkey'];
    servicekey = data['servicekey'];

    notifyListeners(); // UI 변경 알림
  }
}

class UrlState extends ChangeNotifier {
  String? reUrl;

  // 생성자 (필요에 따라 생략 가능)
  UrlState({this.reUrl});

  void updateUrlData(String data) {
    reUrl = data;
    notifyListeners(); // UI 변경 알림
  }
}

class AccessState extends ChangeNotifier {
  String? access_token;

  // 생성자 (필요에 따라 생략 가능)
  AccessState({this.access_token});

  void updateUrlData(String data) {
    access_token = data;
    notifyListeners(); // UI 변경 알림
  }
}
