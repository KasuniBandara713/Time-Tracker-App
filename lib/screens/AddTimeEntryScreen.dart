
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/TimeEntry.dart';
import '../provider/TimeEntryProvider.dart';

class AddTimeEntryScreen extends StatefulWidget{
const AddTimeEntryScreen(
    {super.key}
    );
    
@override 
State<AddTimeEntryScreen> createState() => _AddTimeEntryScreenState(); 

}
 class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> { 
    final TextEditingController pidController = TextEditingController(); 
    final TextEditingController tidController = TextEditingController(); 
    final TextEditingController dateController = TextEditingController(); 
    final TextEditingController tottimeController = TextEditingController(); 
    final TextEditingController noteController = TextEditingController(); 
    
    void saveTimeEntry() { 
        String pid = pidController.text; 
        String tid = tidController.text; 
        String date = dateController.text; 
        double? tottime = double.tryParse(tottimeController.text); 
        String note = noteController.text;

        if (pid.isEmpty  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Select project',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
            ),
        ),
            backgroundColor: Color.fromARGB(255, 2, 14, 82),
      ),
    );
    return;
  } 
  if (tid.isEmpty ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Select task',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
            ),
        ),
            backgroundColor: Color.fromARGB(255, 2, 14, 82),
      ),
    );
    return;
  }
  if(tottime == null) {
ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enter valid total time',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
            ),
        ),
            backgroundColor: Color.fromARGB(255, 2, 14, 82),
      ),
    );
    return;
  }
     DateTime? selectedDate = DateTime.tryParse(date);

  if (selectedDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enter valid date',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
            ),
        ),
            backgroundColor: Color.fromARGB(255, 2, 14, 82),
      ),
    );
    return;
  }

        TimeEntry entry =TimeEntry(
            eid: DateTime.now().millisecondsSinceEpoch.toString(),
            pid:pid,
            tid:tid,
            date:selectedDate,
            tottime:tottime,
            note:note,
        );
        Provider.of<TimeEntryProvider>(
            context,
            listen:false,
        ).addTimeEntry(entry);

        print('Project: $pid'); 
        print('Task: $tid'); 
        print('Date: $date'); 
        print('Total Time: $tottime');
         print('Note: $note'); 
         
         ScaffoldMessenger.of(context).showSnackBar( 
            const SnackBar( 
                content: Text
                ('Time entry saved!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 251, 251, 253),
                        
                    ),
                    textAlign: TextAlign.center,
                 ), 
                backgroundColor: Color.fromARGB(255, 2, 14, 82)
                 ),
                );
                 } 
 @override 
    void dispose() { 
        pidController.dispose();
         tidController.dispose();
          dateController.dispose(); 
          tottimeController.dispose(); 
          noteController.dispose(); 
          super.dispose(); 
          } 
@override 
Widget build(BuildContext context) { 
    return Scaffold( 
        appBar: AppBar( 
            title: const Text
            ('Add Time Entry',
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
        body: SingleChildScrollView( 
            padding: const EdgeInsets.all(16), 
            child: Column( 
                children: [ 
                  Consumer<TimeEntryProvider>(
  builder: (context, provider, child) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Project',
        labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Roboto',
            ),
        
        border: OutlineInputBorder(),
      ),
      initialValue: pidController.text.isEmpty
          ? null
          : pidController.text,
      items: provider.project.map((project) {
        return DropdownMenuItem<String>(
          value: project.pid,
          child: Text(project.name),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            pidController.text = value;
            tidController.clear(); // Reset task selection when project changes
          });
        }
      },
    );     
  },
),  
         const SizedBox
         (height: 16), 
         Consumer<TimeEntryProvider>(
  builder: (context, provider, child) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Task',
        labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Roboto',
            ),
        border: OutlineInputBorder(),
      ),
      initialValue: tidController.text.isEmpty
          ? null
          : tidController.text,
      items: provider.task.where((task) => task.pid == pidController.text).map((task) {
        return DropdownMenuItem<String>(
          value: task.tid,
          child: Text(task.tname),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            tidController.text = value;
            
          });
        }
      },
    );
  },
),
        const SizedBox(height: 16),
         TextField(
  controller: dateController,
  readOnly: true,
  decoration: const InputDecoration(
    labelText: 'Date',
    labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Roboto',
            ),
    hintText: 'Select date',
    border: OutlineInputBorder(),
    suffixIcon: Icon(Icons.calendar_today),
  ),
  onTap: () async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  },
),
         const SizedBox
         (height: 16), 
         TextField( 
            controller: tottimeController, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration( 
                labelText: 'Total Time (hours)',
                labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Roboto',
                ),
                hintText: 'Enter total hours', 
                border: OutlineInputBorder(),
            ),
        ), 
        const SizedBox(height: 16), 
        TextField( 
            controller: noteController, 
            maxLines: 3, 
            decoration: const InputDecoration(
                 labelText: 'Note', 
                 labelStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     color: Color.fromARGB(255, 0, 0, 0),
                     fontFamily: 'Roboto',
                 ),
                 hintText: 'Enter note', 
                 border: OutlineInputBorder(),
            ),
         ), 
         const SizedBox
         (height: 24), 
         SizedBox(
             width: double.infinity, 
             child: ElevatedButton( 
                onPressed: saveTimeEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 14, 82),
                ),
                 child: const Text(
                  'SAVE TIME ENTRY',
                 style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                 ),
                 ), 
                 ), 
                         ),
                                      ], 
             ), 
            ), 
         ); 
    }
 }