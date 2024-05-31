import 'package:ai_frontend/component/tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/orderPage.dart';
import 'provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(authState.mall.toString()),
      ),
      // body에 TabBarView을 bottomNavigationBar에 TabBar 위젯을 넣는다.
      body: TabBarView(
        children: <Widget>[
          OrderPage(), // Tab 1
          TabPage(texts: authState.clientId), // Tab 2
          TabPage(texts: authState.id), // Tab 3
        ],
        controller: tabController,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.looks_one, color: Colors.blue),
          ),
          Tab(
            icon: Icon(Icons.looks_two, color: Colors.blue),
          ),
          Tab(
            icon: Icon(Icons.looks_3, color: Colors.blue),
          )
        ],
        controller: tabController,
      ),
    );
  }
}
//   Widget _tabBar() {
//     return TabBar(
//       controller: tabController,
//       tabs: const [
//         Tab(icon: Icon(Icons.coffee, color: Colors.black)),
//         Tab(icon: Icon(Icons.local_pizza, color: Colors.black)),
//       ],
//     );
//   }
// }
