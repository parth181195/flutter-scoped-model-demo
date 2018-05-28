import 'package:scoped_model/scoped_model.dart';

class Task {
  final String name;
  final bool isDone;
  Task(this.name, this.isDone);
}

class ToDoModel extends Model {
  List<Task> _toDoList = [];
  List get task => _toDoList;

  int get taskLength => _toDoList.length;

  void addTask(Task task){
    _toDoList.add(task);
    print(_toDoList);
    notifyListeners();
  }

  void deleteTask(int index){
    _toDoList.removeAt(index);
    print(_toDoList);
    notifyListeners();
  }
}

class MainModel extends Model with ToDoModel {

}
