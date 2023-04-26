import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/compnants/combanants.dart';

import '../../modules/social_app/new_posts/new_posts.dart';
import 'cubit/social_home_cubit.dart';
import 'cubit/social_home_state.dart';

class SocialHomeScreen extends StatelessWidget {
  const SocialHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {
        if (state is SocialHomeAddNewPostState) {
          NavigateTo(context, NewPostsScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialHomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '${cubit.tittels[cubit.currentIndex]}',
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            ],
            elevation: 0.0,
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangeIndexNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervised_user_circle,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
