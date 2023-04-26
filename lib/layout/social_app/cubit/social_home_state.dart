




abstract class SocialHomeStates {}

class SocialHomeInitialState extends SocialHomeStates{}

class SocialHomeChangeBottomNavState extends SocialHomeStates{}



class SocialHomeGetUserLoadingState extends SocialHomeStates{}

class SocialHomeGetUserSuccessState extends SocialHomeStates{}

class SocialHomeGetUserErrorState extends SocialHomeStates
{
  final String error;

  SocialHomeGetUserErrorState(this.error);
}

class SocialHomeAddNewPostState extends SocialHomeStates{}



class SocialHomeProfileImagePickedSuccessState extends SocialHomeStates{}

class SocialHomeProfileImagePickedErrorState extends SocialHomeStates{}

class SocialHomeCoverImagePickedSuccessState extends SocialHomeStates{}

class SocialHomeCoverImagePickedErrorState extends SocialHomeStates{}



class SocialHomeUpLoadProfileImageLoadingState extends SocialHomeStates{}

class SocialHomeUpLoadProfileImageSuccessState extends SocialHomeStates{}

class SocialHomeUpLoadProfileImageErrorState extends SocialHomeStates{}



class SocialHomeUpLoadCoverImageLoadingState extends SocialHomeStates{}

class SocialHomeUpLoadCoverImageSuccessState extends SocialHomeStates{}

class SocialHomeUpLoadCoverImageErrorState extends SocialHomeStates{}



class SocialHomeUpDateUserDataSuccessState extends SocialHomeStates{}

class SocialHomeUpDateUserDataErrorState extends SocialHomeStates{}

class SocialHomeUpDateUserDataLoadingState extends SocialHomeStates{}




class SocialHomeCreatePostLoadingState extends SocialHomeStates{}

class SocialHomeCreatePostSuccessState extends SocialHomeStates{}

class SocialHomeCreatePostErrorState extends SocialHomeStates{}


class SocialHomeCreateCommentLoadingState extends SocialHomeStates{}

class SocialHomeCreateCommentSuccessState extends SocialHomeStates{}

class SocialHomeCreateCommentErrorState extends SocialHomeStates{}




class SocialHomePostImagePickedSuccessState extends SocialHomeStates{}

class SocialHomePostImagePickedErrorState extends SocialHomeStates{}

class SocialHomeRemovePostImageSuccessState extends SocialHomeStates{}





class SocialHomeGetPostLoadingState extends SocialHomeStates{}

class SocialHomeGetPostSuccessState extends SocialHomeStates{}

class SocialHomeGetPostLikeSuccessState extends SocialHomeStates{}

class SocialHomeGetPostErrorState extends SocialHomeStates
{
  final String error;

  SocialHomeGetPostErrorState(this.error);
}



class SocialHomeGetCommentLoadingState extends SocialHomeStates{}

class SocialHomeGetCommentSuccessState extends SocialHomeStates{}

class SocialHomeGetCommentErrorState extends SocialHomeStates
{
  final String error;

  SocialHomeGetCommentErrorState(this.error);
}




class SocialHomeLikePostSuccessState extends SocialHomeStates{}

class SocialHomeLikePostErrorState extends SocialHomeStates{}



class SocialHomeCommentPostSuccessState extends SocialHomeStates{}

class SocialHomeCommentPostErrorState extends SocialHomeStates{}



class SocialHomeUpDatePostDataErrorState extends SocialHomeStates{}

class SocialHomeUpDatePostDataSuccessState extends SocialHomeStates{}

class SocialHomeUpDatePostDataLoadingState extends SocialHomeStates{}



class SocialHomeGetAllUserLoadingState extends SocialHomeStates{}

class SocialHomeGetAllUserSuccessState extends SocialHomeStates{}

class SocialHomeGetAllUserErrorState extends SocialHomeStates
{
  final String error;

  SocialHomeGetAllUserErrorState(this.error);
}



class SocialHomeSendMessageSuccessState extends SocialHomeStates{}

class SocialHomeSendMessageErrorState extends SocialHomeStates{}

class SocialHomeGetMessagesSuccessState extends SocialHomeStates{}

class SocialHomeGetMessagesImageSuccessState extends SocialHomeStates{}






class SocialHomeMessageImagePickedSuccessState extends SocialHomeStates{}

class SocialHomeMessageImagePickedErrorState extends SocialHomeStates{}



class SocialHomeUpLoadMessageImageLoadingState extends SocialHomeStates{}

class SocialHomeUpLoadMessageImageSuccessState extends SocialHomeStates{}

class SocialHomeUpLoadMessageImageErrorState extends SocialHomeStates{}




class SocialHomeSendImageSuccessState extends SocialHomeStates{}

class SocialHomeSendImageErrorState extends SocialHomeStates{}

class SocialHomeGetImagesSuccessState extends SocialHomeStates{}

