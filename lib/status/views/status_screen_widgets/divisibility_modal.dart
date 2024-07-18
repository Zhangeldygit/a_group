import 'package:flutter/material.dart';

class DivisibilityModal extends StatefulWidget {
  const DivisibilityModal({super.key});

  @override
  State<DivisibilityModal> createState() => _DivisibilityModalState();
}

class _DivisibilityModalState extends State<DivisibilityModal> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.3, // Initial size as a fraction of the screen height
      minChildSize: 0.1, // Minimum size as a fraction of the screen height
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        width: double.infinity,
        color: const Color(0xFF191919),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, 'Делимый');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Делимый', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, 'Неделимый');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Неделимый', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
