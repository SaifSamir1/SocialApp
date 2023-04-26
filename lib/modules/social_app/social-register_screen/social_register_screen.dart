


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../compnants/combanants.dart';
import '../../../layout/social_app/social_home.dart';
import '../../../network/shared_preferences.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
            {
              CacheHelper.saveData(
                  key:'userId',
                  value: state.userId2,
              ).then((value)
              {
                // علشان ميحصاش error عند الخروج من البرنامج والدخول مره اخري

                navigateAndFinish(context, SocialHomeScreen());
              });
            }
          if(state is SocialRegisterErrorState)
            {
              showToast(text:state.error , state: ToastStates.ERROR);
            }
        },
        builder: (context,state)
        {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                            style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('Register now to communicate with your friends',
                              style: Theme.of(context).textTheme.headline5?.copyWith(
                                color: Colors.grey,
                              )
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DefultTextForm(
                            controoler: nameController,
                            keyboardtype: TextInputType.name,
                            labelText: Text('Name'),
                            prefixicon: Icon(Icons.person),
                            valedate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefultTextForm(
                            controoler: emailController ,
                            keyboardtype:TextInputType.emailAddress ,
                            labelText: Text('email'),
                            prefixicon: Icon(Icons.email_outlined),
                            valedate: ( value){
                              if(value!.isEmpty)
                              {
                                return 'email must not be empety';
                              }
                              else return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefultTextForm(
                            suffixIcon: Icon(SocialRegisterCubit.get(context).suffix),
                            suffixPressed: ()
                            {
                              SocialRegisterCubit.get(context).ChangePasswordVisiability();
                            },
                            controoler: passwordController,
                            keyboardtype:TextInputType.visiblePassword ,
                            labelText: Text('password'),
                            obscuretext: SocialRegisterCubit.get(context).isPasswordShow,
                            onfieldsubmitted: (value)
                            {

                            },
                            prefixicon: Icon(Icons.lock),
                            valedate: ( value){
                              if(value!.isEmpty)
                              {
                                return 'password must not be empety';
                              }
                              else return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefultTextForm(
                            controoler: phoneController,
                            keyboardtype: TextInputType.phone,
                            labelText: Text('ENTER YOUR PHONE'),
                            prefixicon: Icon(Icons.numbers),
                            valedate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Phone must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                            builder: (context) => defultButton(
                              onPressedFunction: ()
                              {
                                //لو validate اي في كلام في الخانات الفاضيه اعمل اللي
                                // بين الاقواس لو مفيش اطلع اعمل اللي كان جاهز فوق
                                if(formKey.currentState!.validate())
                                    {
                                      SocialRegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          userEmail: emailController.text,
                                          password:passwordController.text,
                                          phone: phoneController.text,
                                      );
                                    }
                              },
                              hight: 50,
                              isUpperCase: true,
                              text: 'register',
                              backGroundColor: Colors.black26,),
                            fallback:(context) => Center(child: CircularProgressIndicator()),
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
