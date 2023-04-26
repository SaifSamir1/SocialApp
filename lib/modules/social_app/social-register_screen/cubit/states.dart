

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}




class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates
{}

class SocialRegisterErrorState extends SocialRegisterStates
{
  final String error;

  SocialRegisterErrorState(this.error);
}




class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {}




class SocialCreateUserSuccessState extends SocialRegisterStates
{

  final String userId2;

  SocialCreateUserSuccessState(this.userId2);
}

class SocialCreateUserErrorState extends SocialRegisterStates
{}
