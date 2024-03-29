import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/localization/app_localization.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/constant.dart';

class ShopRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

   ShopRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
             // print(state.loginModel!.message!);
             // print(state.loginModel!.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token =  state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                 const ShopLayout(),);
              });
            }
            else {
             // print(state.loginModel!.message!);
              showToast(
                txt: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("register".tr(context)),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("register".tr(context),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black)),
                        Text(
                          "register_now".tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                       const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "warn_name".tr(context);
                            }
                            return null;
                          },
                          label: "name".tr(context),
                          prefix: Icons.person,
                          onTap: null,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return  "warn_email".tr(context);
                            }
                            return null;
                          },
                          label:"email_address".tr(context),
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: (value) {},
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            label: "password".tr(context),
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "warn_pass".tr(context);
                            }
                            return null;
                          },
                          label: "phone".tr(context),
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        state is! ShopRegisterLoadingState
                            ? Center(
                              child: defaultTextButton(
                                  text: "register".tr(context),
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                      );
                                    }
                                  },
                                ),
                            )
                            : const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
