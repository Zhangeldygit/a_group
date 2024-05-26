part of 'plots_bloc.dart';

sealed class GetPlotsEvent extends Equatable {
  const GetPlotsEvent();

  @override
  List<Object> get props => [];
}

class GetPlots extends GetPlotsEvent {
  final String? userType;
  final String? userId;

  const GetPlots({
    this.userType,
    this.userId,
  });
}

class CreatePlot extends GetPlotsEvent {
  final Plot plot;

  const CreatePlot({required this.plot});
}

class GetUsers extends GetPlotsEvent {}
