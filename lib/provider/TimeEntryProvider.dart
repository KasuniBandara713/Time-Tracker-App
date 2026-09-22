
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';


import '../models/Project.dart';
import '../models/Task.dart';
import '../models/TimeEntry.dart';


 
 class TimeEntryProvider with ChangeNotifier{
    final LocalStorage storage;

    TimeEntryProvider({
        required this.storage
 });
    List<TimeEntry>_eid =[];
    List<Project>_pid =[];
    List<Task>_tid =[];

    List<TimeEntry> get timeentry => _eid;
    List<Project> get project => _pid;
    List<Task> get task => _tid;

    void addProject(Project project) {
         _pid.add(project);
         saveData();
        notifyListeners();
}
void deleteProject(String pid) {
  _pid.removeWhere(
    (project) => project.pid == pid,
  );

  saveData();
  notifyListeners();
}

  
    void addTask(Task task){
        _tid.add(task);
        saveData();
        notifyListeners();
    }
     void deleteTask(String tid) {
        _tid.removeWhere((task) => task.tid == tid);
        saveData(); 
        notifyListeners();
     }
     void addTimeEntry(TimeEntry timeentry){
        _eid.add(timeentry);
        saveData();
        notifyListeners();
     }
     
     void deleteTimeEntry(String eid) {
     _eid.removeWhere((entry) => entry.eid == eid);
     saveData();
    notifyListeners();
}

void saveData()  {
  
   storage.setItem(
    'timeentry',
    jsonEncode(_eid.map((entry) => entry.toJson()).toList()),
  );
    storage.setItem(
        'task',
       jsonEncode(_tid.map((entry) => entry.toJson()).toList()),
    );
    storage.setItem(
        'project',
          jsonEncode(_pid.map((entry) => entry.toJson()).toList()),
    );
}

void loadData(){
    final timeEntryData = storage.getItem('timeentry');
  final taskData = storage.getItem('task');
  final projectData = storage.getItem('project');

  if (timeEntryData != null) {
    
    final data = jsonDecode(timeEntryData) ;
    _eid = (data as List)
        .map((item) =>
         TimeEntry.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  if (taskData != null) {
    final data = jsonDecode(taskData);
    _tid = (data as List)
        .map((item) => Task.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  if (projectData != null) {
    final data = jsonDecode(projectData);
    _pid = (data as List)
        .map((item) => Project.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

         notifyListeners();
}

 }
