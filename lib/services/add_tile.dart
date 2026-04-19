import 'package:flutter/material.dart';

class AddTile extends StatelessWidget {

  final VoidCallback onTap;

  const AddTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const ValueKey("add_ingredient"),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.add),
        title: const Text('Toevoegen'),
        onTap: onTap,
      ),
    );
  }
}