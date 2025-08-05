import 'dart:typed_data';

class Local_Picture{
  int ?id;
  Uint8List ?image;
  String ?title;
  String ?description;
  DateTime ?date;

  Local_Picture({this.id,this.image,this.title,this.description,this.date});
  Local_Picture.fromMap(Map<String,dynamic>res){
    id=res["id"];
    image=res["image"];
    title=res["title"];
    description=res["description"];
    date = DateTime.parse(res["datetime"]);


  }
  Map<String,dynamic>toMap() {
    return {
      "image": image,
      "title": title,
      "description": description,
    };
  }

}