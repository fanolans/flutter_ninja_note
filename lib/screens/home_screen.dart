import 'package:flutter/material.dart';
import 'package:note/providers/notes_provider.dart';
import 'package:note/screens/add_or_detail_screen.dart';
import 'package:provider/provider.dart';

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
        title: const Text('Ninja Note'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<NotesProvider>(context, listen: false).getAndSetNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.hasError.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return NotesGrid();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddOrDetailScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
