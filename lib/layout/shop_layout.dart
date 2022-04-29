import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/bloc/cubit/states.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/component.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              )
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items:const  [
              BottomNavigationBarItem(icon:Icon(Icons.home), label: "Home"),
               BottomNavigationBarItem(
                  icon:  Icon(Icons.apps), label:"categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outlined), label:"Favourites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ],
          ),
        );
      },
    );
  }
}
