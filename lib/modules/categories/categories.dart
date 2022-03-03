import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/bloc/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
         return ShopCubit.get(context).categoriesModel != null
              ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCatItem(
                      ShopCubit.get(context)
                          .categoriesModel!
                          .data!
                          .data[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount:
                      ShopCubit.get(context).categoriesModel!.data!.data.length)
              : const CircularProgressIndicator();
        });
  }

  Widget buildCatItem(DataaModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
