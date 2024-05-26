import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/plots_repository/plots_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusCubit extends Cubit<List<Plot>> {
  StatusCubit(this._plotsRepo) : super([]);
  final PlotsRepository _plotsRepo;

  Future<void> filterByCategory(String filter) async {
    final items = await _plotsRepo.getPlots();
    if (filter == 'Все') {
      emit(items);
    } else {
      emit(items.where((item) => item.status == filter).toList());
    }
  }
}
