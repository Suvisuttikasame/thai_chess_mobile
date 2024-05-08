import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/50'),
            ),
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Handle profile tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('High Scores'),
            onTap: () {
              // Handle high scores tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Friends'),
            onTap: () {
              // Handle friends tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle settings tap
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout tap
            },
          ),
        ],
      ),
    );
  }
}
