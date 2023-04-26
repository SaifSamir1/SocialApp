


import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';
import 'package:social_app_3/models/add_post_model.dart';

import '../../../style/colors.dart';

class CommentsScreen extends StatelessWidget {
  SocialCreatePostModel postModel;
  String postId;

  CommentsScreen(this.postModel,this.postId);
  @override
  Widget build(BuildContext context) {
   // var commentData =SocialHomeCubit.get(context).commentsData;

    return BlocConsumer<SocialHomeCubit,SocialHomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          itemBuilder: (context,index)=>Scaffold(
            appBar: AppBar(
              title: Text('Comments'),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${postModel.image}'),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${postModel.name}',
                                style: const TextStyle(height: 1.3),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: defaultColor,
                                size: 17,
                              )
                            ],
                          ),
                          Text(
                            '${postModel.dateTime}',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.3,
                            ),
                          ),
                          //Text('${commentData[].comment}')
                        ],
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
          separatorBuilder:(context,index) => SizedBox(height: 10,) ,
          itemCount: 5 ,
        );
      },
    );
  }
}
