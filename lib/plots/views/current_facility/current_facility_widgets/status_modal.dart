import 'package:flutter/material.dart';

class StatusModal extends StatefulWidget {
  const StatusModal({super.key});

  @override
  State<StatusModal> createState() => _StatusModalState();
}

class _StatusModalState extends State<StatusModal> {
  final List<String> statuses = ['Продается', 'Продано', 'Архив'];
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4, // Initial size as a fraction of the screen height
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
              for (var status = 0; status < statuses.length; status++)
                GestureDetector(
                  onTap: () {
                    print(statuses[status]);
                    Navigator.pop(context, statuses[status]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(statuses[status], style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
