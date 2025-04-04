part of "current_work_page_bloc.dart";

class CurrentWorkPageState extends Equatable {
  final DateTime selectedDate;

  const CurrentWorkPageState({required this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];

  CurrentWorkPageState copyWith({DateTime? selectedDate}) {
    return CurrentWorkPageState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
