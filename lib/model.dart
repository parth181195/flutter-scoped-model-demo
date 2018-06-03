import 'package:scoped_model/scoped_model.dart';

class Task {
  final String name;
  bool isDone;
  Task(this.name, this.isDone);
}

class ToDoModel extends Model {
  static List<Task> _toDoList = [];
  List get task => _toDoList;

  int get taskLength => _toDoList.length;

  void addTask(Task task){
    _toDoList.add(task);
    print(_toDoList);
    notifyListeners();
  }

  void handleTask(int index){
    if(_toDoList[index].isDone == true){
    _toDoList[index].isDone = false;
    _toDoList.insert(0, _toDoList.removeAt(index));
    notifyListeners();
    } else {
    _toDoList[index].isDone = true;
    _toDoList.add(_toDoList.removeAt(index));
    print(_toDoList);
    notifyListeners();
    }
  }
}

class MainModel extends Model with ToDoModel {

}
