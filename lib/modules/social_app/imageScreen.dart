import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';

import '../../models/user_model.dart';

class ImageScreen extends StatelessWidget {
  SocialUserModel userModel;

  ImageScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('IMAGE'),
          ),
          body: ConditionalBuilder(
            condition: SocialHomeCubit.get(context).messageImage != null,
            builder:(context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image: FileImage(SocialHomeCubit.get(context).messageImage!)
                          as ImageProvider,
                          fit: BoxFit.cover,
                        )),
                    width: double.infinity,
                    height: 500,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: ()
                        {
                          var dateTime=DateTime.now().toString();
                          SocialHomeCubit.get(context).upLoadMessageImage(
                              receiverId: userModel.userId,
                              dateTime: dateTime,
                              text: '',
                          );
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.send_sharp)),
                  )
                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
