part of 'plots_bloc.dart';

sealed class GetPlotsState extends Equatable {
  const GetPlotsState();

  @override
  List<Object> get props => [];
}

final class GetPlotsInitial extends GetPlotsState {}

final class GetPlotsFailure extends GetPlotsState {}

final class GetPlotsLoading extends GetPlotsState {}

final class GetPlotsSuccess extends GetPlotsState {
  final List<Plot> plots;

  const GetPlotsSuccess(this.plots);

  @override
  List<Object> get props => [plots];
}

//--------------------------------------------------------
final class CreatePlotLoading extends GetPlotsState {}

final class CreatePlotSuccess extends GetPlotsState {}

final class CreatePlotFailure extends GetPlotsState {}

// ------------------------------------------------------

final class EditPlotLoading extends GetPlotsState {}

final class EditPlotSuccess extends GetPlotsState {}

final class EditPlotFailure extends GetPlotsState {}

// ------------------------------------------------------
final class GetUsersLoading extends GetPlotsState {}

final class GetUsersSuccess extends GetPlotsState {
  final List<MyUser> users;

  const GetUsersSuccess(this.users);

  @override
  List<Object> get props => [users];
}

final class GetUsersFailure extends GetPlotsState {}
