import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/plots_repository/plots_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusCubit extends Cubit<List<Plot>> {
  StatusCubit(this._plotsRepo) : super([]);
  final PlotsRepository _plotsRepo;

  Future<void> filterByCategory({
    num? minAcreage,
    num? maxAcreage,
    int? minPrice,
    int? maxPrice,
    String? appointment,
    String? divisibility,
    String? status,
    String? userType,
    String? userId,
  }) async {
    final items = await _plotsRepo.getPlots(userType: userType, userId: userId);

    List<Plot> filteredPlots = items.where((plot) {
      final matchesAcreage = (minAcreage == null || plot.acreage! >= minAcreage) && (maxAcreage == null || plot.acreage! <= maxAcreage);
      final matchesPrice = (minPrice == null || plot.price! >= minPrice) && (maxPrice == null || plot.price! <= maxPrice);
      final matchesAppointment =
          appointment == null || (plot.appointment != null && plot.appointment!.trim().toLowerCase() == appointment.trim().toLowerCase());
      final matchesDivisibility =
          divisibility == null || (plot.divisibility != null && plot.divisibility!.trim().toLowerCase() == divisibility.trim().toLowerCase());
      final matchesStatus = status == null || (plot.status != null && plot.status!.trim().toLowerCase() == status.trim().toLowerCase());
      return matchesAcreage && matchesPrice && matchesAppointment && matchesDivisibility && matchesStatus;
    }).toList();

    emit(filteredPlots);
  }

  Future<void> reset(
    String? userType,
    String? userId,
  ) async {
    final plots = await _plotsRepo.getPlots(userType: userType, userId: userId);
    emit(plots);
  }
}
