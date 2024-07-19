import 'dart:io';
import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/firebase_plots_repository.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/current_facility/current_facility_details/current_facility_details.dart';
import 'package:a_group/plots/views/current_facility/current_facility_widgets/current_facility_header.dart';
import 'package:a_group/plots/views/current_facility/current_facility_widgets/edit_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentFacilityScreen extends StatelessWidget {
  const CurrentFacilityScreen({super.key, required this.plot, this.user});
  final Plot plot;
  final MyUser? user;

  void _launchCaller(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

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
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CurrentFacilityHeader(plot: plot),
                CurrentFacilityDetails(plot: plot),
              ],
            ),
          ),
          user?.userType != 'seller'
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Написать',
                          onPressed: () {
                            openWhatsapp(context: context, text: '', number: plot.myUser?.phone ?? '');
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          title: 'Позвонить',
                          onPressed: () {
                            _launchCaller(plot.myUser?.phone ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    title: 'Редактировать',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => GetPlotsBloc(FirebasePlotsRepo()),
                            child: EditModal(plot: plot),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
