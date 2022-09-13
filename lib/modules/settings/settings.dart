import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/bloc/cubit/states.dart';
import 'package:shop_app/localization/app_localization.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SettingsScreen extends StatelessWidget {
  final nameController=TextEditingController();
  final phoneController=TextEditingController();
  final emailController=TextEditingController();

 SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;
        var formKey=GlobalKey<FormState>();
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                   const LinearProgressIndicator(),
                   const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "warn_name".tr(context);
                        }
                        return null;
                      },
                      label: "name".tr(context),
                      prefix: Icons.person,
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "warn_email".tr(context);
                        }
                        return null;
                      },
                      label:  "email_address".tr(context),
                      prefix: Icons.email,
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "warn_phone".tr(context);
                        }
                        return null;
                      },
                      label:  "phone".tr(context),
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultTextButton(text:"update".tr(context),
                      function:(){
                      if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name:nameController.text.toString(),
                            email: emailController.text.toString(),
                            phone: phoneController.text.toString(),
                          );
                        }
                      },
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),

                    defaultTextButton(text: "logout".tr(context),
                      function:(){
                      signOut(context);
                    },
                    )
                  ],
                ),
              )
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator(),),

        );
      },
    );
  }
}