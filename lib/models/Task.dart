class Task{
    String tname;
    final String tid;
    final String pid;

    Task({
        required this.tname,
        required this.tid,
        required this.pid,
    });

     Map<String,dynamic>toJson(){
        return{
            'Taskname':tname,
            'Taskid':tid,
            'projectid':pid,
        };
    }
    factory Task.fromJson(Map<String,dynamic>json){
        return Task(
            tname:json['Taskname'],
            tid:json['Taskid'],
            pid:json['projectid'],
        );
    }
}