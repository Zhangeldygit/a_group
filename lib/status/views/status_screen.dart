import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/firebase_plots_repository.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_screen.dart';
import 'package:a_group/status/bloc/status_bloc.dart';
import 'package:a_group/status/views/filter_plots_screen.dart';
import 'package:a_group/status/views/status_screen_widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  MyUser? user;
  bool isFilter = false;

  @override
  void initState() {
    context.read<AuthenticationBloc>().userRepository.user.first.then((value) {
      context.read<StatusCubit>().filterByCategory(userType: value?.userType, userId: value?.userId);
      setState(() {
        user = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          BlocBuilder<StatusCubit, List<Plot>>(
            builder: (context, plots) {
              return ListView.builder(
                itemCount: plots.length, // Example item count
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => GetPlotsBloc(FirebasePlotsRepo()),
                          child: CurrentFacilityScreen(plot: plots[index], user: user),
                        ),
                      ),
                    ),
                    child: StatusCard(
                      plot: plots[index],
                    ),
                  );
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.only(bottom: 10),
              child: CustomButton(
                title: 'Фильтр',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => StatusCubit(FirebasePlotsRepo()),
                        child: FilterPlotsScreen(),
                      ),
                    ),
                  ).then((value) {
                    if (value != null) {
                      for (final i in value) {
                        if (i != null) {
                          setState(() {
                            isFilter = true;
                          });
                        }
                      }
                      context.read<StatusCubit>().filterByCategory(
                            minAcreage: value[0],
                            maxAcreage: value[1],
                            minPrice: value[2],
                            maxPrice: value[3],
                            appointment: value[4],
                            divisibility: value[5],
                            status: value[6],
                            userType: user?.userType,
                            userId: user?.userId,
                          );
                    }
                  });
                },
              ),
            ),
          ),
          isFilter
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.only(bottom: 10),
                    child: CustomButton(
                      title: 'Сбросить',
                      onPressed: () {
                        setState(() {
                          isFilter = false;
                        });
                        context.read<StatusCubit>().reset(
                              user?.userType,
                              user?.userId,
                            );
                      },
                    ),
                  ),
                )
              : Offstage()
        ],
      ),
    );
  }
}
