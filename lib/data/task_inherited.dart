import 'package:flutter/material.dart';
import 'package:primeiro_projeto_flutter/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Tasks> taskList = [
    Tasks('Flutter', 'assets/images/flutter.png', 3),
    Tasks('React Native', 'assets/images/react.jpg', 3),
    Tasks('Python', 'assets/images/python.jpg', 3),
    Tasks('GitHub', 'assets/images/git.jpg', 1),
    Tasks('Figma', 'assets/images/figma.jpg', 1,),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Tasks(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
