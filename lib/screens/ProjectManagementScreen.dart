
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../models/Project.dart';
import '../provider/TimeEntryProvider.dart';


class ProjectManagementScreen extends StatefulWidget {
    
   const ProjectManagementScreen({super.key});

  @override
  State<ProjectManagementScreen> createState() =>
      _ProjectManagementScreenState();
}
class _ProjectManagementScreenState
    extends State<ProjectManagementScreen> {
  final TextEditingController pidController =TextEditingController();
   // List<String> pid = [];


  @override
  void dispose() {
    pidController.dispose();
    super.dispose();
  }
  void showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Project'),
          content: TextField(
            controller: pidController,
            decoration: const InputDecoration(
              labelText: 'Project Name',
              hintText: 'Enter project name',
            ),
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
                String projectName = pidController.text.trim();
                if (projectName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter project name  ')),
                  );
                  return;
                }
                final provider = Provider.of<TimeEntryProvider>(
                  context,
                 listen: false,
                 );

                 provider.addProject(
                    Project(
                        pid: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: projectName,
                    ),
                  );
                  Navigator.pop(context);
              },
              child: const Text('Save'),
                   
            ),
          ], 
        );
  },
    );
  }

         

@override
  Widget build (BuildContext context){
    
    return Scaffold(
        appBar:AppBar(
            title: Text('Project Management',
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
        body:Consumer<TimeEntryProvider>(
          builder:(context, provider, child) => Padding(
            padding:const EdgeInsets.all(16.0),
            child:Column(
                children:[
                    
                    
                    const SizedBox(height:16),

       
     const SizedBox(height: 24 ),
      Expanded(
        child:provider.project.isEmpty
          ? const Center(
              child: Text('No projects added yet.',
                  style: TextStyle(fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0), 
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  ),
                ),
            )
          : ListView.builder(
         itemCount: provider.project.length,
        itemBuilder: (context, index) {
            final project = provider.project[index];

          return Card(
            child: ListTile(
              title: Text(project.name),
              trailing : IconButton(
                icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 0, 0, 0),
                ),
                onPressed: () {
                  provider.deleteProject(project.pid);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Project "${project.name}" deleted.'),
                    ),
                  );
                },
              ),
             ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ),
     

  ),
   floatingActionButton: FloatingActionButton(
    backgroundColor: const Color.fromARGB(255, 2, 14, 82),
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            showAddProjectDialog();
          },
          child: const Icon(Icons.add), 
         ),
    );
}
}