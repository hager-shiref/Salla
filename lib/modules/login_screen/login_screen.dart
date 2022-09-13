// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/localization/app_localization.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider<ShopLoginCubit>(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            // some times the error is in the postman so we need to handle it (when the status is false)
            if (state.loginModel.status!) {
              print(state.loginModel.message!);
              print(state.loginModel.data!.token);
              showToast(
                  txt: state.loginModel.message!, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', 
                      value: state.loginModel.data!.token)
                  .then((value) {
                //String? token =  state.loginModel.data!.token;
                token=state.loginModel.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              showToast(
                  txt: state.loginModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        "login".tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "login_detail".tr(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        onTap: (){},
                          label:"email_address".tr(context),
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return "warn_email".tr(context);
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          controller: emailController),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        onTap: (){},
                          label:"password".tr(context),
                          isPassword:
                              ShopLoginCubit.get(context).isPasswordShown,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validate: (value) {
                            if (value.isEmpty || value == null) {
                              return "warn_pass".tr(context);
                            }
                            return null;
                          },
                          prefix: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      state is! ShopLoginLoadingState
                          ? defaultTextButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text:"login".tr(context)
                      )
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("new_user".tr(context)),
                          InkWell(
                            onTap: () {
                              navigateTo(context, ShopRegisterScreen());
                            },
                            child: Text(
                              "register".tr(context),
                              style: TextStyle(color: defaultColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
