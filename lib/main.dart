import 'package:flutter/material.dart';
import 'package:note/providers/notes_provider.dart';
import 'package:note/screens/add_or_detail_screen.dart';
import 'package:note/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen(),
        routes: {
          AddOrDetailScreen.routeName: (ctx) => AddOrDetailScreen(),
        },
      ),
    );
  }
}
