import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';

import '../../../compnants/combanants.dart';

class NewPostsScreen extends StatelessWidget {

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit,SocialHomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                TextButton(
                  onPressed:()
                  {
                    final now = DateTime.now();
                    if(SocialHomeCubit.get(context).postImage == null)
                    {
                      SocialHomeCubit.get(context).createNewPost(
                          dateTime: now.toString(),
                          text: textController.text);
                    }
                    else{
                      SocialHomeCubit.get(context).upLoadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                  },
                  child: const Text('POST'),
                ),
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialHomeCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialHomeCreatePostLoadingState)
                    const SizedBox(height: 5,),
                    Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${SocialHomeCubit.get(context).model.image}'),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${SocialHomeCubit.get(context).model.name}',
                              style: const TextStyle(height: 1.3),
                            ),
                            Text(
                              'public',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.3,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: textController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'what in your mind ....',
                      //كدا علشان اشيل الخط الظاهر تحت ف الكتابه
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(SocialHomeCubit.get(context).postImage != null)
                    Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            image: DecorationImage(
                              image: FileImage(SocialHomeCubit.get(context).postImage!) as ImageProvider,
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
                                  SocialHomeCubit.get(context).removePostImage();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.blue,
                                  size: 20,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: ()
                            {
                              SocialHomeCubit.get(context).getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                 Icon(Icons.camera_alt_outlined),
                                 SizedBox(
                                  width: 5,
                                ),
                                Text('add photo'),
                              ],
                            )),
                      ),
                      Expanded(
                        child: TextButton(onPressed: ()
                        {}, child: const Text('# tags')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
