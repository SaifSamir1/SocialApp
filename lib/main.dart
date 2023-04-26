import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app_3/compnants/constant.dart';
import 'package:social_app_3/layout/social_app/social_home.dart';
import 'package:social_app_3/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:social_app_3/style/them.dart';

import 'layout/social_app/cubit/social_home_cubit.dart';
import 'modules/social_app/social_login_screen/social_cubit/social_login_cubit.dart';
import 'nativeCode.dart';
import 'network/bloc_observar.dart';
import 'network/shared_preferences.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message ');
  print(message.data.toString());

  Fluttertoast.showToast(
    msg: 'on background message',
    backgroundColor: Colors.blue,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}


void main()async {


  WidgetsFlutterBinding.ensureInitialized(); //بتضمن ان اي حاجه موجوده هنا تتنفذ قبل runApp


  //دي علشان ابدا في تشغيل البرنامج مع ال firebase
  await Firebase.initializeApp();
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print('the notification is $fcmToken');


  // دي كدا بتجيبلي الرساله اللي جات من ال notification والمحتويات اللي جواها كمان انا وقافل الرنامج
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data.toString()}');

    Fluttertoast.showToast(
      msg: 'ON MESSAGE',
      backgroundColor: Colors.blue,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());

    Fluttertoast.showToast(
      msg: 'on message opened app',
      backgroundColor: Colors.blue,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );  });


  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();


  await CacheHelper.init();

  //userId2 = CacheHelper.gutData(key: 'userId') != null ?  CacheHelper.gutData(key: 'userId') : 'null';
  print(FirebaseAuth.instance.currentUser?.uid);

  Widget widget;

  userId2 = FirebaseAuth.instance.currentUser?.uid ?? 'null';

  if(userId2 == ''||userId2=='null')
    {
      widget = SocialLoginScreen();
    }
  else{
    widget = SocialHomeScreen();
  }




  runApp( MyApp(startPage: widget,));
}

class MyApp extends StatelessWidget {

  final Widget startPage;

  MyApp({required this.startPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> SocialLoginCubit()),
        BlocProvider(create: (context)=> SocialHomeCubit()..getUserData()..getPosts())
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner:false,
        home:NativeCodeScreen(),
      ));
  }
}

