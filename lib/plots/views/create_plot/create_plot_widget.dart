import 'dart:io';

import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/create_plot/address_search_screen.dart';
import 'package:a_group/plots/views/create_plot/create_plot_map_dialog_widget.dart';
import 'package:a_group/plots/views/create_plot/create_plot_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreatePlotWidget extends StatefulWidget {
  const CreatePlotWidget({super.key, required this.userName});
  final String userName;

  @override
  State<CreatePlotWidget> createState() => _CreatePlotWidgetState();
}

class _CreatePlotWidgetState extends State<CreatePlotWidget> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController acreageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController appointmentController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<File> selectedImages = [];
  Point selectedAddressPoint = const Point(latitude: 0, longitude: 0);
  SearchItemToponymMetadata? selectedToponym;
  Point? point;

  MyUser? myUser;
  @override
  void initState() {
    context.read<AuthenticationBloc>().userRepository.user.first.then((value) {
      setState(() {
        myUser = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    descriptionController.dispose();
    acreageController.dispose();
    priceController.dispose();
    appointmentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CreatePlotTextField(
                        controller: addressController,
                        hintText: 'Адрес',
                        keyboardType: TextInputType.text,
                        enabled: true,
                        // prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFCFD7F6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () async {
                          final query = addressController.text;

                          print('Search query: $query');

                          final resultWithSession = await YandexSearch.searchByText(
                            searchText: query,
                            geometry: Geometry.fromBoundingBox(
                              const BoundingBox(
                                northEast: Point(latitude: 43.3000, longitude: 76.9800),
                                southWest: Point(latitude: 43.2000, longitude: 76.8300),
                              ),
                            ),
                            searchOptions: const SearchOptions(
                              searchType: SearchType.geo,
                              geometry: false,
                            ),
                          );

                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => AddressSearchScreen(result: resultWithSession.$2, session: resultWithSession.$1, query: query),
                            ),
                          ).then((value) {
                            selectedToponym = value;
                            addressController.text = selectedToponym?.address.formattedAddress ?? '';
                          });
                        },
                        child: const Text('Поиск', textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CreatePlotTextField(
                  controller: descriptionController,
                  hintText: 'Описание',
                  keyboardType: TextInputType.text,
                  enabled: true,
                  // prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFCFD7F6)),
                ),
                const SizedBox(height: 15),
                CreatePlotTextField(
                  controller: appointmentController,
                  hintText: 'Назначение',
                  keyboardType: TextInputType.text,
                  enabled: true,
                  // prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFCFD7F6)),
                ),
                const SizedBox(height: 15),
                CreatePlotTextField(
                  controller: acreageController,
                  hintText: 'Площадь, соток',
                  keyboardType: TextInputType.number,
                  enabled: true,
                  // prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFCFD7F6)),
                ),
                const SizedBox(height: 15),
                CreatePlotTextField(
                  controller: priceController,
                  hintText: 'Цена',
                  keyboardType: TextInputType.number,
                  enabled: true,
                  // prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFCFD7F6)),
                ),
                const SizedBox(height: 15),
                Text(
                  'Фотографии',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                const SizedBox(height: 10),
                selectedImages.isEmpty
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final pickedFile = await picker.pickMultiImage(
                                  imageQuality: 100, // To set quality of images
                                  maxHeight: 1000, // To set maxheight of images that you want in your app
                                  maxWidth: 1000); // To set maxheight of images that you want in your app
                              List<XFile> xfilePick = pickedFile;
                              for (var i = 0; i < xfilePick.length; i++) {
                                selectedImages.add(File(xfilePick[i].path));
                              }
                              setState(
                                () {},
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF5C5C5C)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(32),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.150,
                        height: MediaQuery.of(context).size.height * 0.150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                selectedImages[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  height: 232.0,
                  color: const Color(0xFF0D0D0D),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                        child: Text(
                          'На карте',
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final result = await showDialog(
                              useSafeArea: false,
                              context: context,
                              builder: (_) => const CreatePlotMapDialogWidget(),
                            );

                            setState(() {
                              point = result[0];
                              addressController.text = result[1];
                            });
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ColoredBox(
                              color: Colors.black.withOpacity(0.8),
                              child: Image.network(
                                'https://static-maps.yandex.ru/1.x/?l=map&pt=${point?.longitude ?? 0},${point?.latitude ?? 0},pm2dgm&z=17&size=425,232&l=map,sat',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                color: Colors.transparent,
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: CustomButton(
              title: 'Сохранить',
              onPressed: () {
                if (descriptionController.text.isNotEmpty &&
                    appointmentController.text.isNotEmpty &&
                    acreageController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  context.read<GetPlotsBloc>().add(
                        CreatePlot(
                          plot: Plot(
                            acreage: num.parse(acreageController.text),
                            description: descriptionController.text,
                            district: addressController.text,
                            // id: '',
                            images: selectedImages,
                            location: selectedToponym != null
                                ? GeoPoint(selectedToponym?.balloonPoint.latitude ?? 0, selectedToponym?.balloonPoint.longitude ?? 0)
                                : point != null
                                    ? GeoPoint(point?.latitude ?? 0, point?.longitude ?? 0)
                                    : const GeoPoint(0, 0),
                            name: addressController.text,
                            price: int.parse(priceController.text),
                            status: 'Новые',
                            userName: myUser?.name,
                            userId: myUser?.userId,
                          ),
                        ),
                      );
                  Navigator.pop(context);
                  // Future.delayed(
                  //   const Duration(seconds: 2),
                  //   () {
                  //     context.read<GetPlotsBloc>().add(const GetPlots());
                  //     Navigator.pop(context);
                  //   },
                  // );
                } else {
                  print("creat plot user $myUser");
                  context.read<GetPlotsBloc>().add(
                        CreatePlot(
                          plot: Plot(
                            acreage: num.parse('8'),
                            description: "descriptionController.text",
                            district: "addressController.text",
                            // id: '',
                            images: [],
                            location: const GeoPoint(5, 5),
                            name: "addressController.text",
                            price: int.parse('5'),
                            status: 'Новые',
                            userName: myUser?.name,
                            userId: myUser?.userId,
                          ),
                        ),
                      );
                  // context.read<GetPlotsBloc>().add(GetPlots(userType: myUser?.userType, userId: myUser?.userId));
                  Navigator.pop(context);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text('Заполните все поля'),
                  //   ),
                  // );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
