import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/facility_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Plot> favoriteItems = [];
  MyUser? myUser;

  void loadFavorites(MyUser? user) async {
    var box = await Hive.openBox('plots_${user?.userId}');
    favoriteItems = box.values.toList().cast<Plot>();
    setState(() {});
  }

  @override
  void initState() {
    context.read<AuthenticationBloc>().userRepository.user.first.then((value) {
      loadFavorites(value);
      var box = Hive.box('plots_${value?.userId}');
      favoriteItems = box.values.toList().cast<Plot>();
      print('${value?.name}');
      print('${favoriteItems}');

      setState(() {
        myUser = value;
      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 18.0, // spacing between rows
        crossAxisSpacing: 18.0,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: favoriteItems.length,
      cacheExtent: 1500.0,
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      itemBuilder: (_, index) {
        return FacilityCard(plot: favoriteItems[index], user: myUser);
      },
    );
  }
}
