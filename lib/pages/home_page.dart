import 'package:flutter/cupertino.dart';
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

  void save() async {
    String text = noteController.text.trim();
    if (text.isEmpty) return;
    notes.add(text);
    final db = await SharedPreferences.getInstance();
    await db.setStringList("notes", List<String>.from(notes));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        surfaceTintColor: Colors.yellow,
        title: Text("Notes"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: noteController,
                  autocorrect: false,
                  maxLines: null,
                  maxLength: 200,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  color: Colors.yellow,
                  onPressed: () {
                    save();
                    noteController.clear();
                  },
                  child: Center(child: Text("Save")),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    title: Text(notes[index]),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        notes.remove(notes[index]);
                        setState(() {});
                        final db = await SharedPreferences.getInstance();
                        await db.setStringList("notes", List<String>.from(notes));
                      },
                      child: Icon(CupertinoIcons.delete),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
