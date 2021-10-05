import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:adan/widgets/salah_time_section.dart';
import 'package:adan/cubit/calendar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'error_app.dart';



class CalendarWeeks extends StatelessWidget {
  const CalendarWeeks({Key key}) : super(key: key);

  getDayOfWeekAr(String code) {
    switch(code) {
      case 'fr':
        return Constants.dayOfWeekFr;
      default:
        return Constants.dayOfWeekAr;
    }
  }

  getMonthAr(String code) {
    switch(code) {
      case 'fr':
        return Constants.monthFr;
      default:
        return Constants.monthAr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Get.locale.languageCode;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CalendarWeek(
                  // weekendsIndexes: [1, 2],
                  dayOfWeek: getDayOfWeekAr(locale),
                  month: getMonthAr(locale),
                  controller: CalendarWeekController(),
                  height: 120,
                  showMonth: true,
                  minDate: DateTime.now().add(
                    Duration(days: -365),
                  ),
                  maxDate: DateTime.now().add(
                    Duration(days: 365),
                  ),
                  onDatePressed: (DateTime datetime) {
                    context.read<CalendarCubit>().getSalah(datetime);
                  },
                  decorations: [
                    DecorationItem(
                      decorationAlignment: FractionalOffset.bottomRight,
                      date: DateTime.now(),
                      decoration: Icon(
                        Icons.today,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SalahTimeSection(list: list),
            BlocConsumer<CalendarCubit, CalendarState>(
              listener: (context, state) {
                if (state is CalendarError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CalendarInitial) {
                  return FutureBuilder(
                    future: Future.value(DateTime.now()),
                    builder: (context, snapshot) {
                      switch(snapshot.connectionState) {
                        case ConnectionState.waiting: return Center(
                          child: CircularProgressIndicator(),
                        );
                        default:
                          context.read<CalendarCubit>().getSalah(snapshot.data);
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    },
                  );
                } else if (state is CalendarLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CalendarLoaded) {
                  return SalahTimeSection(list: state.salah, fromHome: false);
                } else if (state is CalendarError){
                  return ErrorApp(state.message);
                } else return
                  ErrorApp();
              },
            ),
          ],
        ),
      ),
    );
  }
}