import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/firebase_plots_repository.dart';
import 'package:a_group/plots/views/create_plot/create_plot_widget.dart';
import 'package:a_group/plots/views/facility_card.dart';
import 'package:a_group/plots/views/map_facilities_screen.dart';
import 'package:a_group/plots/views/user_plots_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PlotsScreen extends StatefulWidget {
  const PlotsScreen({super.key});

  @override
  State<PlotsScreen> createState() => _PlotsScreenState();
}

class _PlotsScreenState extends State<PlotsScreen> {
  MyUser? myUser;
  void loadBox() async {
    await Hive.openBox('plots_${myUser?.userId}');
  }

  @override
  void initState() {
    context.read<AuthenticationBloc>().userRepository.user.first.then((value) {
      setState(() {
        myUser = value;
      });

      if (myUser?.userType == 'customer') {
        context.read<GetPlotsBloc>().add(GetUsers());
      }
    });
    loadBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        if (myUser?.userType == 'seller') {
          return Future.delayed(
              const Duration(seconds: 1), () => context.read<GetPlotsBloc>().add(GetPlots(userType: myUser?.userType, userId: myUser?.userId)));
        } else {
          context.read<AuthenticationBloc>().userRepository.user.first.then((value) {
            setState(() {
              myUser = value;
            });
          });
          return Future.delayed(const Duration(seconds: 1), () => context.read<GetPlotsBloc>().add(GetUsers()));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: BlocBuilder<GetPlotsBloc, GetPlotsState>(
          builder: (context, state) {
            if (myUser?.userType == 'seller' && state is GetPlotsSuccess) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      myUser?.userType == 'seller'
                          ? GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => GetPlotsBloc(FirebasePlotsRepo()),
                                    child: CreatePlotWidget(userName: myUser?.name ?? ''),
                                  ),
                                ),
                              ).then((value) {
                                context.read<GetPlotsBloc>().add(GetPlots(userType: myUser?.userType, userId: myUser?.userId));
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF006EFF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.add, color: Colors.white),
                                    const SizedBox(width: 5),
                                    Text('Добавить', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            )
                          : const Offstage(),
                      GestureDetector(
                        onTap: () => showBottomSheet(context: context, builder: (context) => MapFacilitiesScreen(plots: state.plots)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF006EFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.location_on_outlined, color: Colors.white),
                              const SizedBox(width: 5),
                              Text('На карте', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // number of items in each row
                        mainAxisSpacing: 18.0, // spacing between rows
                        crossAxisSpacing: 18.0,
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.plots.length,
                      cacheExtent: 1500.0,
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      itemBuilder: (_, index) {
                        return FacilityCard(plot: state.plots[index], user: myUser);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is GetUsersSuccess) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Список менеджеров\nпо участкам', style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (_, index) {
                        final phone = MaskTextInputFormatter(
                            mask: '+# (###) ###-##-##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy,
                            initialText: state.users[index].phone);
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    GetPlotsBloc(FirebasePlotsRepo())..add(GetPlots(userId: state.users[index].userId, userType: state.users[index].userType)),
                                child: UserPlotsScreen(user: state.users[index], currentUser: myUser),
                              ),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF191919),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person_2_outlined)),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.users[index].name,
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          state.users[index].email,
                                          style: const TextStyle(color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          myUser?.hasActiveCart ?? false ? phone.getMaskedText() : '',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Участки',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
