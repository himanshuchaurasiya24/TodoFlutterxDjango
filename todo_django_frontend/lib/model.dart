class Todo {
  int? id;
  String? title;
  String? desc;
  bool? isDone;
  String? date;

  Todo({this.id, this.title, this.desc, this.isDone, this.date});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    isDone = json['isDone'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['isDone'] = this.isDone;
    data['date'] = this.date;
    return data;
  }
}
