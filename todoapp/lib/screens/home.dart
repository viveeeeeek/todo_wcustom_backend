import 'package:flutter/material.dart';
import 'package:todoapp/providers/todo.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widgets/todo_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoProvider _todoProvider;

  @override
  void initState() {
    super.initState();
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    _todoProvider.fetchData(); // Fetch todos initially
  }

  Future<void> _refreshData() async {
    await _todoProvider.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const CustomBottomSheet(mode: TodoSheetMode.create);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("TODO Lists"),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: _todoProvider.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Consumer<TodoProvider>(
                builder: (context, todoModel, _) => ListView.builder(
                  itemCount: todoModel.todoData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return CustomBottomSheet(
                              mode: TodoSheetMode.update,
                              todoId: todoModel.todoData[index]['_id'],
                            );
                          },
                        );
                      },
                      onLongPress: () {
                        Provider.of<TodoProvider>(context, listen: false)
                            .deleteData(todoModel.todoData[index]['_id']);
                      },
                      title: Text(todoModel.todoData[index]['title']),
                      subtitle: Text(todoModel.todoData[index]['description']),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
