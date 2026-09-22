
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Task.dart';
import '../provider/TimeEntryProvider.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}
class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final TextEditingController tidController = TextEditingController();
  final TextEditingController tnameController = TextEditingController();
  final TextEditingController pidController = TextEditingController();
 

  @override
  void dispose() {
    tidController.dispose();
    tnameController.dispose();
    pidController.dispose();
    super.dispose();
  }
  void showAddTaskDialog() {
    final provider = Provider.of<TimeEntryProvider>(
      context, 
      listen: false
      );  
      final TextEditingController tnameController = TextEditingController();
      String? selectedProjectId;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: tnameController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  hintText: 'Enter task name',
                ),
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Project',
                  border: OutlineInputBorder(),
                ),
                items: provider.project.map((project) {
                  return DropdownMenuItem<String>(
                    value: project.pid,
                    child: Text(project.name),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedProjectId = value;
                },
              ),
              
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final taskName = tnameController.text.trim();
                
                if (taskName.isEmpty ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                       Text('Enter task name ')
                       ),
                  );
                  return;
                }
                if (selectedProjectId == null ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select a project'),
                    ),
                  );
                  return;
                }
               
                final taskId = DateTime.now().millisecondsSinceEpoch.toString();
                provider.addTask(
                  Task(
                    tid: taskId, 
                    tname: taskName,
                     pid: selectedProjectId!
                     ),
                     );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task "$taskName" added.')),
                );
                tnameController.clear();
                pidController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<TimeEntryProvider>   (
        context,
       
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tasks',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Roboto',
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 14, 82),  
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           
            const SizedBox(height: 16),
            Expanded(
              child: provider.task.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks added yet.',
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Roboto',
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.task.length,
                      itemBuilder: (context, index) {
                        final task = provider.task[index];      
                        return Card(
                          child: ListTile(
                            title: Text(task.tname),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                               // String deletedTask = task.tname;
                                provider.deleteTask(task.tid);
                              },
                            ),
                          ),
                        );
                      },
                  ),
            ),
          ],
        )
         ),
         floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 2, 14, 82),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            showAddTaskDialog();
          },
          child: const Icon(Icons.add), 
         )
);
    
}
}