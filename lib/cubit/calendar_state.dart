part of 'calendar_cubit.dart';

abstract class CalendarState {
  const CalendarState();
}


class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

class CalendarLoading extends CalendarState {
  const CalendarLoading();
}

class CalendarLoaded extends CalendarState {
  final List<Salah> salah;
  const CalendarLoaded(this.salah);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CalendarLoaded && o.salah == salah;
  }

  @override
  int get hashCode => salah.hashCode;
}

class CalendarError extends CalendarState {
  final String message;
  const CalendarError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CalendarError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}