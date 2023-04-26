import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/compnants/combanants.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';
import 'package:social_app_3/models/message_model.dart';
import 'package:social_app_3/models/user_model.dart';
import 'package:social_app_3/style/colors.dart';

import '../imageScreen.dart';

class ChatScreenDetails extends StatelessWidget {
  SocialUserModel userModel;

  ChatScreenDetails({required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialHomeCubit.get(context).getMessages(receiverId: userModel.userId!);
        return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
          listener: (context, state) {
            if(state is SocialHomeMessageImagePickedSuccessState)
              {
                NavigateTo(context, ImageScreen(userModel: userModel));
              }
          },
          builder: (context, state) {

            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // كدا انا ماسك ال message ف ايدي وطبعا اعرف
                              // اوصل للبيانات اللي جواها براحتي
                              var message =
                                  SocialHomeCubit.get(context).messages[index];
                              if (SocialHomeCubit.get(context).model.userId ==
                                  message.senderId) {
                                return buildMyMessage(message);
                              } else
                                return buildMessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount:
                                SocialHomeCubit.get(context).messages.length),
                        SizedBox(height: 15,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(.4),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextField(
                                    controller: messageController,
                                    onSubmitted: (data) {
                                      if (messageController.text != "") {
                                        SocialHomeCubit.get(context)
                                            .sendMessage(
                                                receiverId: userModel.userId,
                                                dateTime:
                                                    DateTime.now().toString(),
                                                text: messageController.text);
                                      }
                                      messageController.clear();
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ....',
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialHomeCubit.get(context)
                                      .getMessageImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: IconButton(
                                  onPressed: () {
                                    if (messageController.text != "") {
                                      SocialHomeCubit.get(context).sendMessage(
                                          receiverId: userModel.userId,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text);
                                    }
                                    messageController.clear();
                                  },
                                  icon: Icon(
                                    Icons.send_sharp,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  // if(SocialHomeCubit.get(context).messageImage != null)
  // Align(
  // alignment: AlignmentDirectional.centerStart,
  // child: Container(
  // decoration: BoxDecoration(
  // color: Colors.grey[300],
  // borderRadius: BorderRadius.only(
  // topRight: Radius.circular(10),
  // bottomRight: Radius.circular(10),
  // topLeft: Radius.circular(10)
  // ),
  // image: DecorationImage(
  // image: FileImage(SocialHomeCubit.get(context).messageImage!) as ImageProvider,
  //     fit: BoxFit.cover,
  // )
  // ),
  // width:200,
  // height:300,
  // ),
  // ),

  Widget buildMessage(MessageModel model) => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            if(model.image == '')
            Container(
              padding:
                  const EdgeInsets.only(left: 10, bottom: 25, top: 25, right: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Text('${model.text}'),
            ),
            if(model.image !='')
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image(image: NetworkImage(
                    '${model.image}',
                  )),
                ),
              ),
          ],
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            if(model.image == '')
              Container(
              padding:
                  const EdgeInsets.only(left: 10, bottom: 25, top: 25, right: 15),
              decoration: BoxDecoration(
                  color: defaultColor.withOpacity(.2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Text('${model.text}'),
            ),
            if(model.image !='')
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25))),
                child:SizedBox(
                  height: 300,
                  width: 300,
                  child: Image(image: NetworkImage(
                    '${model.image}',
                  )),
                ),
              ),
          ],
        ),
      );
}
