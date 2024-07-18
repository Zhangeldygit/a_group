import 'dart:io';
import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/views/create_plot/address_search_screen.dart';
import 'package:a_group/plots/views/create_plot/create_plot_map_dialog_widget.dart';
import 'package:a_group/plots/views/create_plot/create_plot_textfield.dart';
import 'package:a_group/plots/views/current_facility/current_facility_widgets/status_modal.dart';
import 'package:a_group/status/views/status_screen_widgets/appointment_modal.dart';
import 'package:a_group/status/views/status_screen_widgets/divisibility_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class EditModal extends StatefulWidget {
  const EditModal({super.key, required this.plot});
  final Plot plot;

  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController acreageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<File> selectedImages = [];
  Point selectedAddressPoint = const Point(latitude: 0, longitude: 0);
  SearchItemToponymMetadata? selectedToponym;
  Point? point;
  String appointment = 'Назначение';
  String divisibility = 'Делимость';
  String status = 'Статуc';
  bool? isEdit;

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
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        isEdit = true;
                        Navigator.pop(context, isEdit);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CreatePlotTextField(
                        controller: addressController,
                        hintText: 'Адрес',
                        keyboardType: TextInputType.text,
                        enabled: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () async {
                          final query = addressController.text;

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
                ),
                const SizedBox(height: 15),
                CreatePlotTextField(
                  controller: acreageController,
                  hintText: 'Площадь, соток',
                  keyboardType: TextInputType.number,
                  enabled: true,
                ),
                const SizedBox(height: 15),
                CreatePlotTextField(
                  controller: priceController,
                  hintText: 'Цена',
                  keyboardType: TextInputType.number,
                  enabled: true,
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
                      title: Text(appointment, style: TextStyle(color: Colors.white, fontSize: 16)),
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
                      title: Text(divisibility, style: TextStyle(color: Colors.white, fontSize: 16)),
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
                      title: Text(status, style: TextStyle(color: Colors.white, fontSize: 16)),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ),
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
                              final pickedFile = await picker.pickMultipleMedia(
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
                              child: selectedImages[index].path.endsWith('.mp4')
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.video_collection, color: Colors.white),
                                    )
                                  : Image.file(
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
                                'https://static-maps.yandex.ru/1.x/?l=map&pt=${point?.longitude ?? 76.889709},${point?.latitude ?? 43.238949},pm2dgm&z=8&size=425,232&l=map,sat',
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
                isEdit = true;
                context.read<GetPlotsBloc>().add(
                      EditPlot(
                        plot: Plot(
                          acreage: acreageController.text.isNotEmpty ? num.tryParse(acreageController.text) : widget.plot.acreage,
                          description: descriptionController.text.isNotEmpty ? descriptionController.text : widget.plot.description,
                          district: addressController.text.isNotEmpty ? addressController.text : widget.plot.district,
                          id: widget.plot.id,
                          images: selectedImages.isNotEmpty ? selectedImages : null,
                          location: selectedToponym != null
                              ? GeoPoint(selectedToponym?.balloonPoint.latitude ?? 0, selectedToponym?.balloonPoint.longitude ?? 0)
                              : point != null
                                  ? GeoPoint(point?.latitude ?? 0, point?.longitude ?? 0)
                                  : widget.plot.location,
                          name: addressController.text.isNotEmpty ? addressController.text : widget.plot.name,
                          price: priceController.text.isNotEmpty ? int.tryParse(priceController.text) : widget.plot.price,
                          status: status != 'Статус' ? status : widget.plot.status,
                          myUser: myUser?.toEntity(),
                          appointment: appointment != 'Назначение' ? appointment : widget.plot.appointment,
                          divisibility: divisibility != 'Делимость' ? divisibility : widget.plot.divisibility,
                        ),
                      ),
                    );
                Navigator.pop(context, isEdit);
                Navigator.pop(context, isEdit);
              },
            ),
          ),
        ],
      ),
    );
  }
}
