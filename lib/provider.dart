import 'package:flutter/material.dart';

class SiteState extends ChangeNotifier {
  String? site;

  // 생성자 (필요에 따라 생략 가능)
  SiteState({this.site});

  void updateUrlData(String data) {
    site = data;
    notifyListeners(); // UI 변경 알림
  }
}

class Cafe24AuthState extends ChangeNotifier {
  String? mall;

  String? id;

  String? clientId;
  String? clientSecretkey;
  String? servicekey;

  // 생성자 (필요에 따라 생략 가능)
  Cafe24AuthState(
      {this.mall, this.clientId, this.clientSecretkey, this.servicekey});

  void updateUserData(Map<String, dynamic> data) {
    mall = data['mall'];
    id = data['id'];
    clientId = data['client_id'];
    clientSecretkey = data['client_secretkey'];
    servicekey = data['servicekey'];

    notifyListeners(); // UI 변경 알림
  }
}

class ImwebAuthState extends ChangeNotifier {
  String? mall;
  String? id;
  String? apikey;
  String? servicekey;

  // 생성자 (필요에 따라 생략 가능)
  ImwebAuthState({this.mall, this.apikey, this.servicekey});

  void updateUserData(Map<String, dynamic> data) {
    mall = data['mall'];
    id = data['id'];
    apikey = data['api_key'];
    servicekey = data['secret_key'];

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
