import 'package:flutter/material.dart';
import 'package:note/screens/add_or_detail_screen.dart';

import '../widgets/notes_grid_widget.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ninja Notes'),
      ),
      body: NotesGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddOrDetailScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
