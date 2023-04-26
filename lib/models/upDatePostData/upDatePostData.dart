




// دا موديل هبعت علشان اروح اضيف البوست الجديد ف طبعا هبعت معاه الاسم
// وال userId علشان يتحقق مني ويضيف علي طول بعدها


//وكمان هبعت تاريخ التنزيل بتاع البوست و
// هبعت الكلام اللي عايز اضيفه ف البوست وايضا الصوره لو وجدت

class SocialUpdatePostModel
{
  String? name;
  String? image;

  SocialUpdatePostModel({
    this.name,
    this.image,
  });

  SocialUpdatePostModel.fromjson(Map<String,dynamic> json)
  {
    name =json['name'] ;
    image =json['image'];
  }
  //دي كأنها متغير ماسك فيها البيانات اللي هستخدمها
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'image':image,
    };
  }
}