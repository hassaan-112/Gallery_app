import 'dart:typed_data';

class Local_Picture{
  int ?id;
  Uint8List ?image;

  Local_Picture({this.id,this.image});
  Local_Picture.fromMap(Map<String,dynamic>res){
    id=res["id"];
    image=res["image"];
  }
  Map<String,dynamic>toMap() {
    return {
      "image": image
    };
  }

}