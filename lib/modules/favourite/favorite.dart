import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/bloc/cubit/states.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/shared/constant.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state){
        return Center(
          child: ListView.separated(itemBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildFavourite(ShopCubit.get(context).favoritesModel!.data!.data[index],context),
          )
    , separatorBuilder: (context,index)=>const Divider(height: 2,color: Colors.grey,),
     itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length),
        );

      },
        listener: (context,state){});
  }
  Widget buildFavourite(FavoritesData model,context){
    return SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                      model.product!.image!),
                  height: 120,
                  width: 120,
                ),
                if (model.product!.discount != 0)
                  Container(
                    padding:const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 9.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
          const  SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(
                        fontSize: 16.0,
                        height: 1.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product!.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (1 != 0)
                        Text(
                           model.product!.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                             ShopCubit.get(context).changeFavourites(model.product!.id!);
                            
                          },
                          icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:ShopCubit.get(context).favourites[model.product!.id]! ? defaultColor: Colors.grey,
                              child:const Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              )))
                    ],
                  ),
                ]))
          ],
        ));
  }
}
