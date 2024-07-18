import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';

abstract class PlotsRepository {
  Future<List<Plot>> getPlots({String? userType, String? userId});
  Future<void> createPlot(Plot plot);

  Future<List<MyUser>> getUsers();
  Future<void> editPlot(Plot plot);
}
