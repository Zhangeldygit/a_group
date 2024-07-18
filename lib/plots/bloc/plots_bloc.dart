import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:a_group/plots/plots_repository/plots_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plots_event.dart';
part 'plots_state.dart';

class GetPlotsBloc extends Bloc<GetPlotsEvent, GetPlotsState> {
  final PlotsRepository _plotsRepo;

  GetPlotsBloc(this._plotsRepo) : super(GetPlotsInitial()) {
    on<GetPlots>((event, emit) async {
      emit(GetPlotsLoading());
      try {
        List<Plot> plots = await _plotsRepo.getPlots(userType: event.userType, userId: event.userId);
        emit(GetPlotsSuccess(plots));
      } catch (e) {
        emit(GetPlotsFailure());
      }
    });

    on<CreatePlot>(
      (event, emit) async {
        emit(CreatePlotLoading());
        try {
          await _plotsRepo.createPlot(event.plot);
          emit(CreatePlotSuccess());
        } catch (e) {
          emit(CreatePlotFailure());
        }
      },
    );

    on<EditPlot>(
      (event, emit) async {
        emit(EditPlotLoading());
        try {
          await _plotsRepo.editPlot(event.plot);
          emit(EditPlotSuccess());
        } catch (e) {
          emit(EditPlotFailure());
        }
      },
    );

    on<GetUsers>((event, emit) async {
      emit(GetUsersLoading());
      try {
        List<MyUser> users = await _plotsRepo.getUsers();
        emit(GetUsersSuccess(users));
      } catch (e) {
        emit(GetUsersFailure());
      }
    });
  }
}
