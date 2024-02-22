import 'package:flutter/material.dart';
import 'package:todo_app/constnants/color.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> foundTodos = [];
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    foundTodos = todosList;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tdBGColor,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30.0,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.png')),
          ),
        ]),
      ),
      body: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.5),
            child: Column(
              children: [
                Search(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All ToDos",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (ToDo todo in foundTodos)
                        ToDoItem(
                            todo: todo,
                            onTodoChange: handleTodoChange,
                            onTodoDelete: handleTodoDelete),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                    right: 20,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: "Add a new todo item",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                decoration: const BoxDecoration(),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addTodoItem(_todoController.text);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  void handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !(todo.isDone!);
    });
  }

  void handleTodoDelete(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void addTodoItem(String text) {
    setState(() {
      todosList
          .add(ToDo(id: DateTime.now().millisecond.toString(), todoText: text));
    });
    _todoController.clear();
  }

  void runFilter(String enteredText) {
    List<ToDo> results = [];
    if (enteredText.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(enteredText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTodos = results;
    });
  }

  Widget Search() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20.0,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: tdGray,
            )),
      ),
    );
  }
}
