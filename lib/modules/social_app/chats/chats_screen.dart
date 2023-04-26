import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/compnants/combanants.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';
import 'package:social_app_3/models/user_model.dart';
import 'package:social_app_3/modules/social_app/chat_screen_deitals/chat_screen_deitals.dart';


class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialHomeCubit.get(context).allUser.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => chatItemBuilder(SocialHomeCubit.get(context).allUser[index],context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.black26,
            ),
            itemCount: SocialHomeCubit.get(context).allUser.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget chatItemBuilder(SocialUserModel user,context) => InkWell(
      onTap: ()
      {
        NavigateTo(context, ChatScreenDetails(userModel: user));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  '${user.image}'),
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
                        '${user.name}',
                        style: TextStyle(height: 1.3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
