// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app_3/layout/social_app/cubit/social_home_cubit.dart';
// import 'package:social_app_3/layout/social_app/cubit/social_home_state.dart';
//
// import '../../../compnants/combanants.dart';
//
// class CommentScreen extends StatelessWidget {
//
//   var commentController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialHomeCubit,SocialHomeStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         return  Scaffold(
//           appBar: defaultAppBar(
//               context: context,
//               title: 'comment',
//               actions: [
//                 TextButton(
//                   onPressed:()
//                   {
//                     SocialHomeCubit
//                         .get(context)
//                         .commentPost(SocialHomeCubit
//                         .get(context).postsId[index],commentController.text);
//                   },
//                   child: const Text('add a comment'),
//                 ),
//               ]
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   if(state is SocialHomeCreatePostLoadingState)
//                     const LinearProgressIndicator(),
//                   if(state is SocialHomeCreatePostLoadingState)
//                     const SizedBox(height: 5,),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             '${SocialHomeCubit.get(context).model.image}'),
//                         radius: 18,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: TextFormField(
//                           controller: commentController,
//                           maxLines: 5,
//                           decoration: const InputDecoration(
//                             hintText: 'Write a comment ....',
//                             //كدا علشان اشيل الخط الظاهر تحت ف الكتابه
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   if(SocialHomeCubit.get(context).postImage != null)
//                     Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Container(
//                             width: double.infinity,
//                             height: 300,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(4)),
//                               image: DecorationImage(
//                                 image: FileImage(SocialHomeCubit.get(context).postImage!) as ImageProvider,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: AlignmentDirectional.topEnd,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: CircleAvatar(
//                               radius: 18,
//                               backgroundColor: Colors.white,
//                               child: IconButton(
//                                   onPressed: () {
//                                     SocialHomeCubit.get(context).removePostImage();
//                                   },
//                                   icon: Icon(
//                                     Icons.close,
//                                     color: Colors.blue,
//                                     size: 20,
//                                   )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                             onPressed: ()
//                             {
//                               SocialHomeCubit.get(context).getPostImage();
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Icon(Icons.camera_alt_outlined),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text('add photo'),
//                               ],
//                             )),
//                       ),
//                       Expanded(
//                         child: TextButton(onPressed: ()
//                         {}, child: const Text('# tags')),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
