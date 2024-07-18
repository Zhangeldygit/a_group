import 'package:flutter/material.dart';

class AppointmentModal extends StatefulWidget {
  const AppointmentModal({super.key});

  @override
  State<AppointmentModal> createState() => _AppointmentModalState();
}

class _AppointmentModalState extends State<AppointmentModal> {
  final List<String> appointments = ['ИЖС', 'КХ', 'ЛПХ', 'Коммерческое', 'МЖС', 'Дачное строительство', 'Иное назначение'];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8, // Initial size as a fraction of the screen height
      minChildSize: 0.3, // Minimum size as a fraction of the screen height
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        width: double.infinity,
        color: const Color(0xFF191919),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var appointment = 0; appointment < appointments.length; appointment++)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, appointments[appointment]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(appointments[appointment], style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
