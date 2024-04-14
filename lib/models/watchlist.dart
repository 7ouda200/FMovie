class WatchListModel {
  String id;
  String title;
  String description;
  String dateTime;
  String imgUrl;
  bool isDone;

  WatchListModel(
      {
        this.id='',
        required this.title,
        required this.description,
        required this.dateTime,
        required this.imgUrl,
         required this.isDone});

  factory WatchListModel.fromJson(Map<String, dynamic> json) {
    return WatchListModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: json['dateTime'],
      imgUrl: json['imgUrl'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dateTime': dateTime,
    'imgUrl': imgUrl,
    'isDone': isDone,
  };
}
