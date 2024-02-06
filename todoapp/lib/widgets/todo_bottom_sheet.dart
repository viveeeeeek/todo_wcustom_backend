import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/todo.dart';

enum TodoSheetMode { create, update, delete }

class CustomBottomSheet extends StatelessWidget {
  final String? todoId;
  final TodoSheetMode mode;

  const CustomBottomSheet({Key? key, this.todoId, required this.mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 45,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              mode == TodoSheetMode.create ? 'Add Todo' : 'Update Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                child: FilledButton.tonal(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      if (mode == TodoSheetMode.create) {
                        // Logic for creating a new todo
                        Provider.of<TodoProvider>(context, listen: false)
                            .addData({
                          "title": titleController.text,
                          "description": descriptionController.text,
                        });
                      } else if (mode == TodoSheetMode.update &&
                          todoId != null) {
                        // Logic for updating an existing todo
                        Provider.of<TodoProvider>(context, listen: false)
                            .updateData({
                          "_id": todoId!,
                          "title": titleController.text,
                          "description": descriptionController.text,
                        });
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
