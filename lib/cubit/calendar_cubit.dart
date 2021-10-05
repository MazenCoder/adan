import 'package:adan/repository/calendar_repository.dart';
import 'package:adan/database/app_database.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final CalendarRepository calendarRepository;
  CalendarCubit({this.calendarRepository}) : super(CalendarInitial());

  Future<void> getSalah(DateTime dateTime) async {
    try {
      emit(CalendarLoading());
      final calendar = await calendarRepository.fetchCalendar(dateTime);
      emit(CalendarLoaded(calendar));
    } on NetworkException {
      emit(CalendarError("error_calendar".tr));
    }
  }
}
