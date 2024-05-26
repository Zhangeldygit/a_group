import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/status/bloc/status_bloc.dart';
import 'package:a_group/status/views/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final List<String> statuses = ['Все', 'Продано', 'Продается', 'Архив', 'Новые'];
  int selectedItem = 0;
  String selectedCategory = 'Все';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var s = 0; s < statuses.length; s++)
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        selectedItem = s;
                      });
                      await context.read<StatusCubit>().filterByCategory(statuses[selectedItem]);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: s == selectedItem ? const Color(0xFF006EFF) : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        statuses[s],
                        style: GoogleFonts.poppins(color: s != selectedItem ? const Color(0xFF858585) : Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
          ),

          // DropdownButtonFormField<String>(
          //   dropdownColor: const Color(0xFF0D0D0D),
          //   iconEnabledColor: Colors.white,
          //   iconDisabledColor: Colors.white,
          //   value: selectedCategory,
          //   onChanged: (value) async {
          //     setState(() {
          //       selectedCategory = value!;
          //     });
          //     await context.read<StatusCubit>().filterByCategory(selectedCategory);
          //     print(selectedCategory);
          //   },
          //   items: ['Все', ...statuses]
          //       .map<DropdownMenuItem<String>>(
          //         (category) => DropdownMenuItem<String>(
          //           value: category,
          //           child: Text(category, style: const TextStyle(color: Colors.white)),
          //         ),
          //       )
          //       .toList(),
          // ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () async {
          //           await context.read<StatusCubit>().filterByCategory('Все');
          //         },
          //         child: const Text('Все'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () async {
          //           await context.read<StatusCubit>().filterByCategory('Продано');
          //         },
          //         child: const Text('Продано'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () async {
          //           await context.read<StatusCubit>().filterByCategory('Продается');
          //         },
          //         child: const Text('Продается'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () async {
          //           await context.read<StatusCubit>().filterByCategory('Архив');
          //         },
          //         child: const Text('Архив'),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<StatusCubit, List<Plot>>(
              builder: (context, plots) {
                return ListView.builder(
                  itemCount: plots.isNotEmpty ? plots.length : 0, // Example item count
                  itemBuilder: (BuildContext context, int index) {
                    return StatusCard(
                      plot: plots[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
