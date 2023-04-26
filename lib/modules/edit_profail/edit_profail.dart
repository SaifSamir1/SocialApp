import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/compnants/combanants.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialHomeCubit.get(context).model;
        var profileImage = SocialHomeCubit.get(context).profileImage;
        var coverImage = SocialHomeCubit.get(context).coverImage;

        nameController.text = userModel.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialHomeUpDateUserDataLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialHomeUpDateUserDataLoadingState)
                  SizedBox(height: 10),
                Container(
                  height: 190,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage('${userModel.cover}')
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      SocialHomeCubit.get(context)
                                          .getCoverImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.blue,
                                      size: 20,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${userModel.image}')
                                  : FileImage(profileImage) as ImageProvider,
                              radius: 60,
                            ),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    SocialHomeCubit.get(context)
                                        .getProfileImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (SocialHomeCubit.get(context).profileImage != null ||
                    SocialHomeCubit.get(context).coverImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (SocialHomeCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defultButton(
                                  text: 'UPLOAD PROfILE IMAGE',
                                  backGroundColor: Colors.black26,
                                  hight: 35,
                                  onPressedFunction: (){
                                    SocialHomeCubit.get(context).upLoadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                    );
                                    SocialHomeCubit.get(context).updatePostData();
                                  },
                                ),
                                if(state is SocialHomeUpLoadProfileImageLoadingState)
                                  SizedBox(
                                  height: 5,
                                ),
                                if(state is SocialHomeUpLoadProfileImageLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        if (SocialHomeCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defultButton(
                                  text: 'UPLOAD PROfILE COVER',
                                  backGroundColor: Colors.black26,
                                  hight: 35,
                                  onPressedFunction: (){
                                    SocialHomeCubit.get(context).upLoadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text
                                    );
                                    SocialHomeCubit.get(context).updatePostData();
                                  },
                                ),
                                if(state is SocialHomeUpLoadCoverImageLoadingState)
                                  SizedBox(height: 5,),
                                if(state is SocialHomeUpLoadCoverImageLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefultTextForm(
                    controoler: nameController,
                    labelText: Text('edit your name'),
                    keyboardtype: TextInputType.text,
                    prefixicon: Icon(Icons.supervised_user_circle),
                    valedate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      } else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefultTextForm(
                    controoler: bioController,
                    labelText: Text('edit your bio'),
                    keyboardtype: TextInputType.text,
                    prefixicon: Icon(Icons.info_outline),
                    valedate: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      } else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefultTextForm(
                    controoler: phoneController,
                    labelText: Text('edit your phone number'),
                    keyboardtype: TextInputType.text,
                    prefixicon: Icon(Icons.phone),
                    valedate: (value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      } else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('UPDATE'),
                        content: Text('Are You Sure To Update The Information'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                SocialHomeCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                                SocialHomeCubit.get(context).updatePostData();
                                Navigator.pop(context);
                              },
                              child: Text('UpDate')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(' No')),
                        ],
                      ),
                    );
                  },
                  child: Text('UPDATE'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
