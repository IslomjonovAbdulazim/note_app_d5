import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    final db = await SharedPreferences.getInstance();
    notes = db.getStringList("notes") ?? [];
    setState(() {});
  }

  void save() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
