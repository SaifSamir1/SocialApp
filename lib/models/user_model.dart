



class SocialUserModel
{
    String? name;
    String? email;
    String? phone;
    String? userId;
    String? image;
    String? cover;
    String? bio;
    bool? isEmailVerified;

  SocialUserModel({
     this.name,
     this.email,
     this.phone,
     this.userId,
     this.image,
     this.cover,
     this.bio,
     this.isEmailVerified
  });

  SocialUserModel.fromjson(Map<String,dynamic> json)
  {
    name =json['name'] ;
    email =json['email'];
    phone =json['phone'];
    userId =json['userId'];
    image =json['image'];
    cover =json['cover'];
    bio =json['bio'];
    isEmailVerified =json['isEmailVerified'];
  }
 //دي كأنها متغير ماسك فيها البيانات اللي هستخدمها
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email' : email,
      'phone':phone,
      'userId':userId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}