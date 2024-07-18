import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/views/facility_card.dart';
import 'package:a_group/plots/views/map_facilities_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPlotsScreen extends StatefulWidget {
  const UserPlotsScreen({super.key, required this.user, this.currentUser});
  final MyUser? user;
  final MyUser? currentUser;

  @override
  State<UserPlotsScreen> createState() => _UserPlotsScreenState();
}

class _UserPlotsScreenState extends State<UserPlotsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFF0D0D0D),
      body: BlocBuilder<GetPlotsBloc, GetPlotsState>(
        builder: (context, state) {
          if (state is GetPlotsSuccess) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => showBottomSheet(
                        context: context,
                        builder: (context) => MapFacilitiesScreen(plots: state.plots),
                        enableDrag: false,
                      ),
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
                      return FacilityCard(plot: state.plots[index], user: widget.currentUser);
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
    );
  }
}
