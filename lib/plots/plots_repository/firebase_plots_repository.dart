import 'dart:developer';
import 'dart:io';

import 'package:a_group/auth/auth_repository/entities/user_entity.dart';
import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/plots_repository/entities/plot_entity.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/plots_repository/plots_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePlotsRepo implements PlotsRepository {
  final plotCollection = FirebaseFirestore.instance.collection('plots');
  final sellersCollection = FirebaseFirestore.instance.collection('sellers');

  @override
  Future<List<Plot>> getPlots({String? userType, String? userId}) async {
    try {
      if (userType != null && userType != 'customer' && userId != null) {
        final plots = plotCollection
            .where('user.userId', isEqualTo: userId)
            .get()
            .then((value) => value.docs.map((e) => Plot.fromEntity(PlotEntity.fromDocument(e.data(), id: e.id))).toList());

        return plots;
      } else {
        return plotCollection.get().then((value) => value.docs.map((e) => Plot.fromEntity(PlotEntity.fromDocument(e.data(), id: e.id))).toList());
      }
    } catch (e) {
      log("zannnn get plotsss ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> createPlot(Plot plot) async {
    List<String> downloadUrls = await uploadImages(plot.images!);
    // if (plot.images != null) {
    //   downloadUrls = ;
    // }
    try {
      await plotCollection.add(
        Plot(
          acreage: plot.acreage,
          description: plot.description,
          district: plot.district,
          id: plotCollection.doc().id,
          images: downloadUrls,
          location: plot.location,
          name: plot.name,
          price: plot.price,
          status: plot.status,
          myUser: plot.myUser,
          appointment: plot.appointment,
          divisibility: plot.divisibility,
        ).toEntity().toDocument(),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUser>> getUsers() {
    try {
      return sellersCollection
          .where('user_type', isEqualTo: 'seller')
          .get()
          .then((value) => value.docs.map((e) => MyUser.fromEntity(MyUserEntity.fromDocument(e.data()))).toList());
    } catch (e) {
      log("zannnn get plotsss ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> editPlot(Plot plot) async {
    List<String> downloadUrls = [];
    if (plot.images != null && plot.images!.isNotEmpty) {
      downloadUrls = await uploadImages(plot.images!);
    }

    try {
      return await plotCollection.doc(plot.id).update(
            Plot(
              acreage: plot.acreage,
              description: plot.description,
              district: plot.district,
              id: plot.id,
              images: downloadUrls,
              location: plot.location,
              name: plot.name,
              price: plot.price,
              status: plot.status,
              myUser: plot.myUser,
              appointment: plot.appointment,
              divisibility: plot.divisibility,
            ).toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

Future<List<String>> uploadImages(List<dynamic> images) async {
  List<String> downloadUrls = [];

  try {
    // Upload each image to Firebase Storage
    for (File image in images) {
      FirebaseStorage storage = FirebaseStorage.instance;
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref;
      if (image.path.contains('.mp4')) {
        ref = storage.ref().child('images/$imageName.mp4');
      } else {
        ref = storage.ref().child('images/$imageName.jpg');
      }

      await ref.putFile(image);

      // Get the download URL for the uploaded image
      String downloadUrl = await ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    print('All images uploaded successfully');
    return downloadUrls;
  } catch (e) {
    print('Error uploading images: $e');
    return [];
  }
}
