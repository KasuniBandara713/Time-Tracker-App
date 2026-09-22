class TimeEntry{
    final String eid;
    final String pid;
    final String tid;
    final double tottime;
    final DateTime date;
    final String note;

    TimeEntry({
        required this.eid,
        required this.pid,
        required this.tid,
        required this.tottime,
        required this.date,
        required this.note,
    });

    Map<String,dynamic>toJson(){
        return{
            'Entry ID':eid,
            'Project ID':pid,
            'Task ID':tid,
            'Total Time':tottime,
            'Date':date.toIso8601String(),
            'Note':note,
        };
    }
    factory TimeEntry.fromJson(Map<String,dynamic>json){
        return TimeEntry(
            eid:json['Entry ID'],
            pid:json['Project ID'],
            tid:json['Task ID'],
            tottime:json['Total Time'],
            date:DateTime.parse(json['Date']),
            note:json['Note'],
        );
    }
}