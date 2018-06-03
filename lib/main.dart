import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: new MaterialApp(
        title: 'ScopedModelDemo',
        home: TodoHome('Scoped Model Demo'),
      ),
    );
  }
}

class TodoHome extends StatelessWidget {
  final String title;
  TodoHome(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
      ),
      body: Center(
        child:ScopedModelDescendant<MainModel>(
          builder: (context,child,model) => new ListView.builder(
            itemCount: model.taskLength,
            itemBuilder: (context,index)  {
              return new InkWell(
                onTap: (){
                      model.handleTask(index);
                },
                child: new ListTile(
                  trailing: new IconButton(
                    color: Colors.green,
                    icon: model.task[index].isDone ?  new Icon(Icons.check) : new Icon(Icons.check_box_outline_blank),
                    onPressed: (){
                      model.handleTask(index);
                    }
                  ),
                  title: new Text(model.task[index].name,style: new TextStyle(
                    decoration: model.task[index].isDone ? new TextDecoration.combine(<TextDecoration>[TextDecoration.lineThrough]): null
                  )),
                ),
              );
            }
          ),
        )
      ),
      floatingActionButton: ScopedModelDescendant<MainModel>(
        builder: (context,child,model,) => FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            openAddItemDialogue(context);
          },
        )),
    );
  }
}

openAddItemDialogue(BuildContext context) {
  showDialog(context: context, builder: (context) => new AddItemDialog());
}

class AddItemDialog extends StatefulWidget {
  @override
  AddItemDialogState createState() {
    return new AddItemDialogState();
  }
}

class AddItemDialogState extends State<AddItemDialog> {
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: controller,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Task name', hintText: 'eg. Buy Red Apples'),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          }),
        ScopedModelDescendant<MainModel>(
          builder: (context, child, model) => new FlatButton(
            child: const Text('ADD'),
            onPressed: () {
              model.addTask(new Task(controller.text, false));
              Navigator.pop(context);
          }))
      ],
    );
  }
}
