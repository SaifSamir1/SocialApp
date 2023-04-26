import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_3/modules/social_app/social_login_screen/social_cubit/social_login_cubit.dart';
import 'package:social_app_3/modules/social_app/social_login_screen/social_cubit/social_login_states.dart';

import '../../../compnants/combanants.dart';
import '../../../layout/social_app/social_home.dart';
import '../../../network/shared_preferences.dart';
import '../social-register_screen/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }

          if(state is SocialLoginSuccessState)
            {
              CacheHelper.saveData(
                  key:'userId',
                  value: state.UserId2
              ).then((value)
              {
                // علشان ميحصاش error عند الخروج من البرنامج والدخول مره اخري

                navigateAndFinish(context, SocialHomeScreen());
              });
            }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Social APP',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'font1',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('login now to communicate with your friends',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'font1',
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefultTextForm(
                          onChange: (emailData) {
                            email = emailData;
                          },
                          controoler: emailController,
                          labelText: const Text(
                            'enter your email',
                          ),
                          keyboardtype: TextInputType.text,
                          prefixicon: const Icon(
                            Icons.email,
                          ),
                          valedate: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            } else
                              return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        DefultTextForm(
                          onChange: (passwordData) {
                            password = passwordData;
                          },
                          suffixIcon: Icon(SocialLoginCubit.get(context)
                              .SocialVisibilityIcon),
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .SocialChangeVisibilityPassword();
                          },
                          controoler: passwordController,
                          keyboardtype: TextInputType.visiblePassword,
                          labelText: const Text(
                            'enter your password',
                          ),
                          obscuretext:
                              SocialLoginCubit.get(context).SocialObscureText,
                          prefixicon: const Icon(
                            Icons.lock,
                          ),
                          valedate: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empety';
                            } else
                              return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is SocialLoginLoadingState,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          fallback: (context) => defultButton(
                              onPressedFunction: () {
                                if (formKey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
                                      userEmail: emailController.text,
                                      userPassword: passwordController.text,
                                  );
                                }
                              },
                              backGroundColor: Colors.blueGrey[300]!,
                              hight: 45,
                              text: 'login now'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ? ',
                            ),
                            TextButton(
                              onPressed: () {
                                NavigateTo(context, SocialRegisterScreen());
                              },
                              child: const Text('Register Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
