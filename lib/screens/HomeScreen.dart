
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddTimeEntryScreen.dart';
import '../provider/TimeEntryProvider.dart';
import 'ProjectManagementScreen.dart';
import 'TaskManagementScreen.dart';
//import '../provider/TimeEntryProvider.dart';
import '../models/Project.dart';
import '../models/Task.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 2,

      child: Scaffold(

        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 2, 14, 82),
            iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 255, 255, 255),
            ),

          title: const Text(
            'Time Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'poppins',
            ),
          ),

          centerTitle: true,

          leading: Builder(
            builder: (context) {
              return IconButton(
                icon:const  Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),


          bottom: const TabBar(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 254, 254, 254),
              fontSize: 20,
              fontFamily: 'Roboto',
            ),

            tabs: [

              Tab(
                text: 'All Entries',
              ),

              Tab(
                text: 'Grouped by Projects',
              ),

            ],

          ),

        ),

        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 14, 82),
                ),
                child: Text(
                  'Time Tracker',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.work),
                title:  Text(
                  'Projects',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectManagementScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.task),
                title:  Text('Tasks',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaskManagementScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        body: TabBarView(

          children: [


            // All Entries

            Consumer<TimeEntryProvider>(

              builder: (context, provider, child) {


                if (provider.timeentry.isEmpty) {

                  return const Center(

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [
                        Icon(Icons.hourglass_empty, size: 80, color: Color.fromARGB(255, 0, 0, 0),),    

                        Text(
                          'No time entries yet!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        SizedBox(
                          height: 12,
                        ),


                        Text(
                          'Tap the + button to add your first entry.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),

                      ],

                    ),

                  );

                }



                return ListView.builder(

                  itemCount: provider.timeentry.length,


                  itemBuilder: (context, index) {


                    final entry =
                        provider.timeentry[index];

                        final project = provider.project.firstWhere(
                          (project) => project.pid == entry.pid,
                          orElse: () => Project(
                            pid: entry.pid, 
                            name: 'Project not found' ),
                        );
                        //print('Entry PID: ${entry.pid}');
                        //print('saved Project PID: ${
                           // provider.project.map((p) => p.pid).toList()}');
                        final task = provider.task.firstWhere(
                          (task) => task.tid == entry.tid,
                          orElse: () => Task(
                            tid: entry.tid, tname: entry.tid, pid: entry.pid),
                        );


                    return Card(

                      margin:
                          const EdgeInsets.all(10),


                      child: ListTile(


                        title: Text(
                          'Project : ${project.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),



                        subtitle: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,


                          children: [

                            Text(
                              'Task : ${task.tname}',
                            ),


                            Text(
                              'Total Time: ${entry.tottime} hours',
                            ),


                            Text(
                              'Date: ${DateFormat('yyyy-MM-dd').format(entry.date)}',
                            ),


                            Text(
                              'Note: ${entry.note}',
                            ),

                          ],

                        ),



                        trailing: IconButton(

                          icon: const Icon(
                            Icons.delete,
                          ),


                          onPressed: () {

                            provider.deleteTimeEntry(
                              entry.eid,
                            );

                          },

                        ),

                      ),

                    );

                  },

                );

              },

            ),





            // Grouped by Projects


            Consumer<TimeEntryProvider>(

              builder: (context, provider, child) {


                if (provider.timeentry.isEmpty) {

                  return const Center(

                    child: 
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon
                    (Icons.hourglass_empty,
                     size: 80, 
                     color: Color.fromARGB(255, 0, 0, 0),
                     ),
                     
                     
                    Text(
                      'No time entries  yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Add a time entry to see it grouped by project.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    )

                    ],
                    ),

                  );

                }
      


                return ListView(
                  children: provider.project.map((project) {
                    final projectEntries = provider.timeentry
                        .where((entry) => entry.pid == project.pid)
                        .toList();

                    if (projectEntries.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return ExpansionTile(
                      title: Text(
                        project.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      children: projectEntries.map((entry) {
                        final task = provider.task.firstWhere(
                          (task) => task.tid == entry.tid,
                          orElse: () => Task(
                            tid: entry.tid, tname: entry.tid, pid: entry.pid),
                        );

                        return ListTile(
                          title: Text('Task : ${task.tname}'),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('Total Time : ${entry.tottime} hours'),
                              Text('Date : ${DateFormat('yyyy-MM-dd').format(entry.date)}'),
                              Text('Note : ${entry.note}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              provider.deleteTimeEntry(entry.eid);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Time entry deleted.'),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                   );


              },

            ),


          ],

        ),





        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 2, 14, 82),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),

          onPressed: () {


            Navigator.push(

              context,

              MaterialPageRoute(

                builder: (context) =>
                    const AddTimeEntryScreen(),

              ),

            );


          },


          child: const Icon(
            Icons.add,
          ),

        ),


      ),

    );

  }

}