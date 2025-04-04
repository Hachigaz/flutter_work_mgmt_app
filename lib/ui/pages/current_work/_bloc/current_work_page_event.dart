part of "current_work_page_bloc.dart";

class CurrentWorkPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentWorkPageEventChangeWeekday extends CurrentWorkPageEvent {
  final DateTime selectedDate;

  CurrentWorkPageEventChangeWeekday({required this.selectedDate});

  @override
  List<Object?> get props => [...super.props, selectedDate];
}

class CurrentWorkPageEventChangeCalendar extends CurrentWorkPageEvent {
  final DateTime selectedDate;

  CurrentWorkPageEventChangeCalendar({required this.selectedDate});

  @override
  List<Object?> get props => [...super.props, selectedDate];
}
