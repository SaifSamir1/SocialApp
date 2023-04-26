



abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates
{
  final String UserId2;

  SocialLoginSuccessState(this.UserId2);
}

class SocialLoginErrorState extends SocialLoginStates{
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialChangeVisibilityPasswordState extends SocialLoginStates{}
