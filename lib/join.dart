import 'package:ai_frontend/component/cafe24/cafe24_join.dart';
import 'package:flutter/material.dart';

import 'component/imweb/imweb_join.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.coffee),
              ),
              Tab(
                icon: Icon(Icons.cloud),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Cafe24Join(),
            ),
            Center(
              child: ImwebJoin(),
            ),
          ],
        ),
      ),
    );
  }
}
