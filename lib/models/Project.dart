class Project{
    String name;
    final String pid;

    Project({
        required this.name,
        required this.pid,
    });
    Map<String,dynamic>toJson(){
        return{
            'name':name,
            'projectid':pid,
        };
    }
    factory Project.fromJson(Map<String,dynamic>json){
        return Project(
            name:json['name'],
            pid:json['projectid']
        );
    }
}