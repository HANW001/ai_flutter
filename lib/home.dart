import 'package:ai_frontend/component/imweb/imweb_order.dart';
import 'package:ai_frontend/component/tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/cafe24/cafe24_order.dart';
import 'provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _TabBarScreenState();
}

late final authState;

class _TabBarScreenState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    final site = Provider.of<SiteState>(context, listen: false);
    if (site == 'cafe24') {
      authState = Provider.of<Cafe24AuthState>(context, listen: false);
    } else {
      authState = Provider.of<ImwebAuthState>(context, listen: false);
    }
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final site = Provider.of<SiteState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(authState.mall.toString()),
      ),
      // body에 TabBarView을 bottomNavigationBar에 TabBar 위젯을 넣는다.
      body: IndexedStack(
        index: site == 'cafe24' ? 0 : 1, // Index based on site
        children: <Widget>[
          TabBarView(
            // TabBarView for cafe24
            children: <Widget>[
              Cafe24OrderPage(), // Tab 1
              TabPage(texts: authState.servicekey), // Tab 2
              TabPage(texts: authState.id), // Tab 3
            ],
            controller: tabController,
          ),
          TabBarView(
            // TabBarView for imweb
            children: <Widget>[
              ImwebOrderPage(), // Tab 1 (imweb-specific)
              TabPage(texts: authState.servicekey), // Tab 2
              TabPage(texts: authState.id), // Tab 3
            ],
            controller: tabController,
          ),
        ],
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
