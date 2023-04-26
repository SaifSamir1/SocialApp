import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';
import 'package:social_app_3/models/add_post_model.dart';

import '../../../compnants/constant.dart';
import '../../../models/user_model.dart';
import '../../../network/shared_preferences.dart';
import '../../../style/colors.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userModel = SocialHomeCubit.get(context).model;
    var postModel = SocialHomeCubit.get(context).posts;



    var commentController = TextEditingController();

    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          //يعني لو ال list اللي فيها posts فيها
          // حاجها اعرضها لكن غير كدا خليها تحمل كدا وخلاص
          condition:
          SocialHomeCubit.get(context).posts.length > 0 && userModel != null,
          builder: (context) =>
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
              children: [
                Card(
                  elevation: 10, //تعطي ظل تحت الصوره
                  clipBehavior: Clip.antiAliasWithSaveLayer, //تعمل حواف للصوره
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image.network(
                        'https://img.freepik.com/free-photo/cheerful-positive-young-european-woman-with-dark-hair-broad-shining-smile-points-with-thumb-aside_273609-18325.jpg?w=1060&t=st=1670970354~exp=1670970954~hmac=57d63eb89f5b9cf4330fd7e184727109a5b8d0e9d235b670ec03d5ac07da4ce4',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Communication with your friends',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                       return BuildPostItem(
                          context,
                          postModel[index]
                          , userModel,
                          index,
                          commentController
                       );},
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: postModel.length,
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget BuildPostItem(
        context, SocialCreatePostModel post, SocialUserModel model1,index,commentController) =>
    Card(
      elevation: 10, //تعطي ظل تحت الصوره
      clipBehavior: Clip.antiAliasWithSaveLayer, //تعمل حواف للصوره
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${post.image}'),
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
                            '${post.name}',
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
                        '${post.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.3,
                            ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 1,
                color: Colors.grey[300],
                width: double.infinity,
              ),
            ),
            Text('${post.text}'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 10),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        color: Colors.white,
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          padding:
                              EdgeInsets.zero, //لتصغير المساحه المحيطه بالكلمه
                          minWidth: 1, //لتصغير المساحه المحيطه بالكلمه
                          child: Text(
                            '#software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          child: Text(
                            '#flutter',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (post.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${post.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialHomeCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 20,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'comments',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap:() {

                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 1,
                color: Colors.grey[300],
                width: double.infinity,
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${post.image}'),
                  radius: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller:   commentController,
                    decoration:  InputDecoration(
                      hintText: 'Write a comment ....',
                      //كدا علشان اشيل الخط الظاهر تحت ف الكتابه
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      final now = DateTime.now();
                      SocialHomeCubit
                          .get(context)
                          .commentPost(
                          postId: SocialHomeCubit
                          .get(context).postsId[index],
                          comment: commentController.text,
                          dateTime: now.toString(),
                      );
                      commentController.clear();
                    }
                    ,
                  icon:Icon(Icons.send_sharp,color: Colors.blue,) ,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    SocialHomeCubit
                        .get(context)
                        .likePost(SocialHomeCubit
                        .get(context).postsId[index]);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
