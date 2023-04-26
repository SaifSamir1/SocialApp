

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/compnants/constant.dart';
import 'package:social_app_3/modules/social_app/social-register_screen/cubit/states.dart';

import '../../../../models/user_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void userRegister({
    required String name,
    required String userEmail,
    required String password,
    required String phone,
    bool? isEmailVerified,

})async
  {
    emit(SocialRegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
    ).then((value) {
      //دي علشان تخرج معلومات ال user

      CreateUsers(
        name: name,
        phone: phone,
        userEmail: userEmail,
        userId: value.user!.uid,
        isEmailVerified: isEmailVerified ?? false
      );
      userId2 = value.user!.uid;
    }).catchError((error){

      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }



  void CreateUsers({
    required String name,
    required String userEmail,
    required String phone,
    required String userId,
    required bool isEmailVerified,
})
  {

    SocialUserModel model = SocialUserModel(
      name: name,
      email: userEmail,
      phone: phone,
      userId: userId,
      bio:'Write your bio .... ' ,
      cover: 'https://www.drodd.com/images14/white7.jpg',
      image:'https://th.bing.com/th/id/OIP.uF0qJ_YJu51rNAsvMii1lAHaHa?pid=ImgDet&rs=1' ,
      isEmailVerified: false,//عملناه كدا لانه لسه بيبدا
    );
    FirebaseFirestore.instance
        .collection('users') //كدا عملت ال collection
        .doc(userId) //كدا عملت ال docment
        .set(model.toMap()).then((value) {

          emit(SocialCreateUserSuccessState(userId));
    }).catchError((error){

      print(error.toString());
      emit(SocialCreateUserErrorState());
    }); //وهنا هبعت البيانات اللي هيتم تخزينها هناك بس هروح اعمل ليها model احسن
  }



  void ChangePasswordVisiability()
  {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow ? Icons.visibility_outlined:Icons.visibility_off_outlined ;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}