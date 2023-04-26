


import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/compnants/constant.dart';
import 'package:social_app_3/modules/social_app/social_login_screen/social_cubit/social_login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);



  void userLogin(
  {
 required String userEmail,
 required String userPassword
})
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
    ).then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
      userId2 = value.user!.uid;
    }).catchError((error){

      emit(SocialLoginErrorState(
        error.toString()
      ));
    });
  }

  IconData SocialVisibilityIcon = Icons.visibility_outlined;
  bool SocialObscureText = true;

  void SocialChangeVisibilityPassword()
  {
    SocialObscureText =!  SocialObscureText;

    SocialVisibilityIcon = SocialObscureText ?  Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChangeVisibilityPasswordState());
  }




}