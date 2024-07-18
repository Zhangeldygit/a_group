import 'package:a_group/components/custom_button.dart';
import 'package:a_group/plots/views/create_plot/create_plot_textfield.dart';
import 'package:a_group/plots/views/current_facility/current_facility_widgets/status_modal.dart';
import 'package:a_group/status/views/status_screen_widgets/appointment_modal.dart';
import 'package:a_group/status/views/status_screen_widgets/divisibility_modal.dart';
import 'package:flutter/material.dart';

class FilterPlotsScreen extends StatefulWidget {
  const FilterPlotsScreen({super.key});

  @override
  State<FilterPlotsScreen> createState() => _FilterPlotsScreenState();
}

class _FilterPlotsScreenState extends State<FilterPlotsScreen> {
  final TextEditingController minAcreageController = TextEditingController();
  final TextEditingController maxAcreageController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  String? appointment;
  String? divisibility;
  String? status;
  @override
  void dispose() {
    super.dispose();
    minAcreageController.dispose();
    maxAcreageController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.white)),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CreatePlotTextField(
                          controller: minAcreageController,
                          hintText: 'Площадь, соток от',
                          keyboardType: TextInputType.number,
                          enabled: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CreatePlotTextField(
                          controller: maxAcreageController,
                          hintText: 'Площадь, соток до',
                          keyboardType: TextInputType.number,
                          enabled: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CreatePlotTextField(
                          controller: minPriceController,
                          hintText: 'Цена от',
                          keyboardType: TextInputType.number,
                          enabled: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CreatePlotTextField(
                          controller: maxPriceController,
                          hintText: 'Цена до',
                          keyboardType: TextInputType.number,
                          enabled: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      final result = await showModalBottomSheet(context: context, builder: (context) => AppointmentModal());
                      setState(() {
                        if (result != null) {
                          appointment = result;
                        }
                      });
                    },
                    child: Card(
                      color: const Color(0xFF191919),
                      child: ListTile(
                        title: Text(appointment ?? 'Назначение', style: TextStyle(color: Colors.white, fontSize: 16)),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await showModalBottomSheet(context: context, builder: (context) => DivisibilityModal());
                      setState(() {
                        if (result != null) {
                          divisibility = result;
                        }
                      });
                    },
                    child: Card(
                      color: const Color(0xFF191919),
                      child: ListTile(
                        title: Text(divisibility ?? 'Делимость', style: TextStyle(color: Colors.white, fontSize: 16)),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await showModalBottomSheet(context: context, builder: (context) => StatusModal());
                      setState(() {
                        if (result != null) {
                          status = result;
                        }
                      });
                    },
                    child: Card(
                      color: const Color(0xFF191919),
                      child: ListTile(
                        title: Text(status ?? 'Статус', style: TextStyle(color: Colors.white, fontSize: 16)),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: CustomButton(
                title: 'Применить',
                onPressed: () {
                  Navigator.pop(context, [
                    minAcreageController.text.isNotEmpty ? num.tryParse(minAcreageController.text) : null,
                    maxAcreageController.text.isNotEmpty ? num.tryParse(maxAcreageController.text) : null,
                    minPriceController.text.isNotEmpty ? int.tryParse(minPriceController.text) : null,
                    maxPriceController.text.isNotEmpty ? int.tryParse(maxPriceController.text) : null,
                    appointment,
                    divisibility,
                    status,
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
