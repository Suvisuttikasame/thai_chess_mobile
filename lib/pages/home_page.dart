import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo Game'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Row(
                children: [
                  Icon(Icons.games),
                  SizedBox(width: 16),
                  Text('Menu'),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.man),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.man),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.man),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.man),
              title: const Text('Profile'),
              onTap: () {},
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Logout'))
          ],
        ),
      ),
      body: Column(
        children: [
          Image.network(
            'https://picsum.photos/500',
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_circle_up),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Play'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Friendly match'),
          ),
        ],
      ),
    );
  }
}
