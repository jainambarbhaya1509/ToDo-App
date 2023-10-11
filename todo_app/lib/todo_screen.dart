import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Map<String, dynamic>> todos = [
    {'title': "Flutter Workshop1", "isChecked": false},
    {'title': "Flutter Workshop2", "isChecked": false},
    {'title': "Flutter Workshop3", "isChecked": false}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ToDo(
            title: todos[index]['title'],
            isChecked: todos[index]['isChecked'],
            onTap: (value) {
              setState(() {
                todos[index]['isChecked'] = value;
              });
            },
            onDelete: () {
              setState(() {
                todos.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController titleController = TextEditingController();

          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            todos.add({
                              'title': titleController.text,
                              'isChecked': false
                            });
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ToDo Widget //

class ToDo extends StatelessWidget {
  const ToDo(
      {super.key,
      required this.title,
      required this.isChecked,
      required this.onTap,
      required this.onDelete});

  final String title;
  final bool isChecked;
  final ValueChanged onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: isChecked, onChanged: onTap),
            Text(title),
          ],
        ),
        IconButton(
          onPressed: () {
            onDelete();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
