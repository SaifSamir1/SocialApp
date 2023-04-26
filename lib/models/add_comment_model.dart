


// دا موديل هبعت علشان اروح اضيف البوست الجديد ف طبعا هبعت معاه الاسم
// وال userId علشان يتحقق مني ويضيف علي طول بعدها


//وكمان هبعت تاريخ التنزيل بتاع البوست و
// هبعت الكلام اللي عايز اضيفه ف البوست وايضا الصوره لو وجدت

class SocialCreateCommentModel
{
  String? name;
  String? userId;
  String? image;
  String? dateTime;
  String? comment;

  SocialCreateCommentModel({
    this.name,
    this.userId,
    this.image,
    this.dateTime,
    this.comment,
  });

  SocialCreateCommentModel.fromjson(Map<String,dynamic> json)
  {
    name =json['name'] ;
    userId =json['userId'];
    image =json['image'];
    dateTime =json['dateTime'];
    comment =json['comment'];
  }
  //دي كأنها متغير ماسك فيها البيانات اللي هستخدمها
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'userId':userId,
      'image':image,
      'dateTime':dateTime,
      'comment':comment,
    };
  }
}