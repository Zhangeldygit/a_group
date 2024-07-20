import 'dart:io';

import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/views/facility_card.dart';
import 'package:a_group/plots/views/map_facilities_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPlotsScreen extends StatefulWidget {
  const UserPlotsScreen({super.key, required this.user, this.currentUser});
  final MyUser? user;
  final MyUser? currentUser;

  @override
  State<UserPlotsScreen> createState() => _UserPlotsScreenState();
}

class _UserPlotsScreenState extends State<UserPlotsScreen> {
  void openWhatsapp({required BuildContext context, required String text, required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Whatsapp не установлен")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Whatsapp не установлен")));
      }
    }
  }

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
                      onTap: () {
                        print(widget.currentUser?.hasActiveCart);
                        if (widget.currentUser?.hasActiveCart ?? false) {
                          showBottomSheet(
                            context: context,
                            builder: (context) => MapFacilitiesScreen(plots: state.plots),
                            enableDrag: false,
                          );
                        } else {
                          showAdaptiveDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                content: Text(
                                  'Для дальнейшего просмотра нужно оплатить подписку',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      openWhatsapp(context: context, text: '', number: state.plots.first.myUser?.phone ?? '');
                                    },
                                    child: Text(
                                      'Узнать цену',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
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
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
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
