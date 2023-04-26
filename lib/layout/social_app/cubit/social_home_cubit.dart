import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';
import 'package:social_app_3/models/message_model.dart';
import '../../../compnants/constant.dart';
import '../../../models/add_comment_model.dart';
import '../../../models/add_post_model.dart';
import '../../../models/upDatePostData/upDatePostData.dart';
import '../../../models/user_model.dart';
import '../../../modules/social_app/chats/chats_screen.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';
import '../../../modules/social_app/new_posts/new_posts.dart';
import '../../../modules/social_app/setting/setting_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialHomeCubit extends Cubit<SocialHomeStates> {
  SocialHomeCubit() : super(SocialHomeInitialState());

  static SocialHomeCubit get(context) => BlocProvider.of(context);

  //انا حطيت ال object<model
  // هنا علشان اقدر استخدمه ف اي مكان من خلال ال cubit >
  SocialUserModel model = SocialUserModel();

  SocialCreatePostModel postObject = SocialCreatePostModel();

  int currentIndex = 0;
  List bottomScreens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostsScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  List tittels = [
    'Home ',
    'Chats',
    'new post',
    'Users',
    'Setting',
  ];

  void ChangeIndexNav(int index) {
    if (index == 1) {
      getAllUser();
    }
    if (index == 0) {
      getPosts();
    }
    if (index == 2)
      emit(SocialHomeAddNewPostState());
    else {
      currentIndex = index;
      emit(SocialHomeChangeBottomNavState());
    }
  }

  void getUserData() {
    emit(SocialHomeGetUserLoadingState());
    //كدا انا بجيب البانات المتخزنه ف ال firebaseFireStore اللي عملتها
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId2)
        .get()
        .then((value) {
      print(value.data());
      model = SocialUserModel.fromjson(value.data() ?? {});
      emit(SocialHomeGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(SocialHomeGetUserErrorState(error.toString()));
    });
  }

//علشان اجيب صوره من المعرض

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    //الخطوه دي هي خطوة التقاط الصوره من المعرض
    var pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      // الملف ده اللي هيتم في تخزين الصوره اللي تم التقاطها
      profileImage = File(pickerFile.path);
      emit(SocialHomeProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialHomeProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future getCoverImage() async {
    //الخطوه دي هي خطوة التقاط الصوره من المعرض
    var pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      // الملف ده اللي هيتم في تخزين الصوره اللي تم التقاطها
      coverImage = File(pickerFile.path);
      emit(SocialHomeCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialHomeCoverImagePickedErrorState());
    }
  }

  void upLoadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialHomeUpLoadProfileImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      //انت كدا جبت ال URL للملف اللي تم رفعه فوق
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          //طبعا ال value دي شايله ال url الخاصه بالصوره اللي تم تحميلها
          image: value,
        );
        getUserData();
        updatePostData();
      }).catchError((error) {
        emit(SocialHomeUpLoadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialHomeUpLoadProfileImageErrorState());
    });
  }

  void upLoadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialHomeUpLoadCoverImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      //انت كدا جبت ال URL للملف اللي تم رفعه فوق
      value.ref.getDownloadURL().then((value) {
        emit(SocialHomeUpLoadCoverImageSuccessState());
        print(value);
        updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            //طبعا ال value دي شايله ال url الخاصه بالصوره اللي تم تحميلها
            cover: value);
        getUserData();
        updatePostData();
      }).catchError((error) {
        emit(SocialHomeUpLoadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialHomeUpLoadCoverImageErrorState());
    });
  }

  //دي المسؤله عن ادخال البيانات الجديده لل fields اللي بداخل ال doc(id)

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialHomeUpDateUserDataLoadingState());

    SocialUserModel newDateModel = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: model.email,
      // كدا احنا بنقوله ان لو حملة صوره جديده يبقي حطها لو محملتش حط القديمه
      cover: cover ?? model.cover,
      image: image ?? model.image,
      userId: model.userId,
      isEmailVerified: false, //عملناه كدا لانه لسه بيبدا
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.userId)
        .update(newDateModel.toMap())
        .then((value) {
      getUserData();
      updatePostData();
      emit(SocialHomeUpDateUserDataSuccessState());
    }).catchError((error) {
      emit(SocialHomeUpDateUserDataErrorState());
    });
  }

//دي علشان نجيب الصوره الخاصه بالبوست اللي هنعمله لو وجدت

  File? postImage;
  Future getPostImage() async {
    //الخطوه دي هي خطوة التقاط الصوره من المعرض
    var pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      // الملف ده اللي هيتم في تخزين الصوره اللي تم التقاطها
      postImage = File(pickerFile.path);
      emit(SocialHomePostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialHomePostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;

    emit(SocialHomeRemovePostImageSuccessState());
  }

  String postImage22 = '';

  void upLoadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialHomeCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      //انت كدا جبت ال URL للملف اللي تم رفعه فوق
      value.ref.getDownloadURL().then((value) {
        postImage22 = value;
        createNewPost(
          dateTime: dateTime,
          text: text,
          postImage: value, // كدا انت جبت ال url بتاع الصوره
          // اللي رفعتها وحطيتها ف ال post image
        );
      }).catchError((error) {
        emit(SocialHomeCreatePostErrorState());
      });
    }).catchError((error) {});
  }

  //دي المسؤله عن ادخال البيانات الجديده لل fields اللي بداخل ال doc(id)

  void createNewPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialHomeUpDateUserDataLoadingState());

    SocialCreatePostModel newPost = SocialCreatePostModel(
      name: model.name,
      image: model.image,
      userId: model.userId,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(newPost.toMap()) // هنا عملت add علشان اعمل اضافه اللي doc واحطه
        // تحته القيم اللي هبعتها
        .then((value) {
      emit(SocialHomeCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialHomeCreatePostErrorState());
    });
  }

  // طبعا انا هحط البيانات بتاعت البوستات دي بداخل ال list اللي
  // اسمها posts علشان كدا لما استدعيها هناك لازم اجيب كل index منها وحده
  List<SocialCreatePostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<TextEditingController> commentsControllerList = [];



  void getPosts() {
    emit(SocialHomeGetPostLoadingState());

    //دي علشان افضي ال posts لما ادخل عليها تاني

    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        //خلي بالك كدا كل element هو post مكون
        // من map فيها قيم المتغيرات اللي بعتها مع البوست

        //وكدا انا بملئ ال list اللي
        // هي posts بالعناصل الموجوده في ال collection وكمان الداتا
        // اللي موجوده في كل عنصل اللي هي علي شكل
        // mab وعملت fromJson لاني هستقبل الداتا دي من علي النت

        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(SocialCreatePostModel.fromjson(element.data()));
          postsId.add(element.id);
          emit(SocialHomeGetPostLikeSuccessState());
        }).catchError((error) {});

        // element.reference.collection('Comments').get().then((value) {
        //   comments.add(value.docs.length);
        //   postIdComment.add(element.id);
        //   for (var element in value.docs) {
        //     commentsData.add(SocialCreateCommentModel.fromjson(element.data()));
        //   }
        //   emit(SocialHomeGetCommentSuccessState());
        // }).catchError((error) {});
      });
      emit(SocialHomeGetPostSuccessState());
    }).catchError((error) {
      emit(SocialHomeGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId) //كدا علشان اوصل لل بوست المطلوب بال id بتاعه
        .collection('Likes') //كدا انا انشئت collection جديده جواه
        .doc(model.userId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialHomeLikePostSuccessState());
    }).catchError((error) {
      emit(SocialHomeLikePostErrorState());
    });
  }

  void commentPost({
    required String postId,
    required String comment,
    required String dateTime,
  }) {
    SocialCreateCommentModel newComment = SocialCreateCommentModel(
      name: model.name,
      image: model.image,
      userId: model.userId,
      dateTime: dateTime,
      comment: comment,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comments')
        .add(newComment.toMap())
        .then((value) {
      emit(SocialHomeCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialHomeCommentPostErrorState());
    });
  }




  // List<int> comments = [];
  // List<SocialCreateCommentModel> commentsData = [];
  // List<String> postIdComment=[];
  //
  // void getComments(postId) {
  //   emit(SocialHomeGetCommentLoadingState());
  //
  //   //دي علشان افضي ال posts لما ادخل عليها تاني
  //
  //   FirebaseFirestore.instance.collection('posts')
  //       .doc(postId).collection('Comments')
  //   .get().then((value)
  //   {
  //     value.docs.forEach((element) {
  //       commentsData.add(SocialCreateCommentModel.fromjson(element.data()));
  //     });
  //   }).catchError((error){
  //
  //   });
  // }

  List<SocialCreatePostModel> postData = [];
  List<String> postsIdUser = [];

  void updatePostData() {
    emit(SocialHomeUpDatePostDataLoadingState());

    SocialUpdatePostModel newPostModel = SocialUpdatePostModel(
      name: model.name,
      // كدا احنا بنقوله ان لو حملة صوره جديده يبقي حطها لو محملتش حط القديمه
      image: model.image,
    );

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        postsIdUser.add(element.id);
        postData.add(SocialCreatePostModel.fromjson(element.data()));
        for (int i = 0; i < postsId.length; i++) {
          if (postData[i].userId == userId2) {
            FirebaseFirestore.instance
                .collection('posts')
                .doc(postsIdUser[i])
                .update(newPostModel.toMap())
                .then((value) {})
                .catchError((error) {});
          }
        }
      });
      emit(SocialHomeUpDatePostDataSuccessState());
    }).catchError((error) {
      emit(SocialHomeUpDatePostDataErrorState());
    });
  }

  List<SocialUserModel> allUser = [];
  void getAllUser() {
    emit(SocialHomeGetAllUserLoadingState());

    if (allUser.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['userId'] != model.userId) {
            allUser.add(SocialUserModel.fromjson(element.data()));
          }
        });
        emit(SocialHomeGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialHomeGetAllUserErrorState(error.toString()));
      });
    }
  }

  File? messageImage;
  Future getMessageImage() async {
    //الخطوه دي هي خطوة التقاط الصوره من المعرض
    var pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      // الملف ده اللي هيتم في تخزين الصوره اللي تم التقاطها
      messageImage = File(pickerFile.path);
      emit(SocialHomeMessageImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialHomeMessageImagePickedErrorState());
    }
  }

  String messageImageUrl = '';

  void upLoadMessageImage({
    required String? receiverId,
    required String dateTime,
    required String text,
  }) {
    emit(SocialHomeUpLoadMessageImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      //انت كدا جبت ال URL للملف اللي تم رفعه فوق
      value.ref.getDownloadURL().then((value) {
        messageImageUrl = value;
        sendMessage(
            image: value, receiverId: receiverId!, dateTime: dateTime,
            text: text);
      }).catchError((error) {
        emit(SocialHomeUpLoadMessageImageErrorState());
      });
    }).catchError((error) {});
  }

  void sendMessage({
    required String? receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: model.userId,
      receiverId: receiverId,
      dateTime: dateTime,
      image: image ?? '',
    );

    //set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialHomeSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialHomeSendMessageErrorState());
    });

    //set receiver chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.userId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialHomeSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialHomeSendMessageErrorState());
    });
  }


  List<MessageModel> messages =[];

  void getMessages({
    required String receiverId,
  })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime') // علشان ارتب الداتا اللي جايه عندي
        .snapshots()
        .listen((event)//listen دي بقوله ابدا استمع للتغيرات اللي بتحصل فيك
    {
      // ال event ده هو ال messages اللي عندي
      messages =[];
      event.docs.forEach((element) {

        messages.add(MessageModel.fromjson(element.data()));
      });
      emit(SocialHomeGetMessagesSuccessState());
    });

  }





}
