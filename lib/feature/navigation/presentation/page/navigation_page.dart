import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 64,
            color: Colors.amber,
            child: Column(
              children: [
                IconButton(
                    onPressed: () => navigationShell.goBranch(0),
                    icon: Icon(Icons.home)),
                IconButton(
                    onPressed: () => navigationShell.goBranch(1),
                    icon: Icon(Icons.task)),
              ],
            ),
          ),
          Expanded(child: navigationShell)
        ],
      ),
    );
  }
}
