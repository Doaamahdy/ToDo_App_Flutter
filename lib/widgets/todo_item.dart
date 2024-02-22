import 'package:flutter/material.dart';
import 'package:todo_app/constnants/color.dart';

class ToDoItem extends StatelessWidget {
  final todo;
  final onTodoChange;
  final onTodoDelete;
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onTodoChange,
      required this.onTodoDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16.0,
              color: tdBlack,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.delete),
              onPressed: () {
                onTodoDelete(todo.id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
