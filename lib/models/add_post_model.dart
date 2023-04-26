




// دا موديل هبعت علشان اروح اضيف البوست الجديد ف طبعا هبعت معاه الاسم
// وال userId علشان يتحقق مني ويضيف علي طول بعدها


//وكمان هبعت تاريخ التنزيل بتاع البوست و
// هبعت الكلام اللي عايز اضيفه ف البوست وايضا الصوره لو وجدت

class SocialCreatePostModel
{
  String? name;
  String? userId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  SocialCreatePostModel({
    this.name,
    this.userId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  SocialCreatePostModel.fromjson(Map<String,dynamic> json)
  {
    name =json['name'] ;
    userId =json['userId'];
    image =json['image'];
    dateTime =json['dateTime'];
    text =json['text'];
    postImage =json['postImage'];
  }
  //دي كأنها متغير ماسك فيها البيانات اللي هستخدمها
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'userId':userId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}