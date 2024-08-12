import 'package:closet_control/features/calendar/outfit_card.dart';
import 'package:closet_control/features/calendar/outfit_model.dart';
import 'package:closet_control/providers/outfit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    List<Outfit> allOutfits = context.read<OutfitProvider>().allOutfits;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: Column(
            children: [
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(3000, 1, 1),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay.toLocal();
                      _focusedDay = focusedDay.toLocal();
                    });
                  }
                },
              ),
              // Text(_focusedDay.toString()),
              // Text(allOutfits.indexWhere(
              //             (outfit) => outfit.dateTime == _focusedDay) !=
              //         -1
              //     ? allOutfits[allOutfits.indexWhere(
              //             (outfit) => outfit.dateTime == _focusedDay)]
              //         .toString()
              //     : 'Fehler'),
              // Text(allOutfits.isNotEmpty
              //     ? allOutfits[0].dateTime.toString()
              //     : 'Fehler'),
              SizedBox(
                height: 20.h,
              ),
              //TODO es wird immer nur die gleiche OutfitCard angezeigt
              Builder(builder: (context) {
                if (allOutfits.indexWhere(
                        (outfit) => outfit.dateTime == _focusedDay) !=
                    -1) {
                  return OutfitCard(
                      outfit: allOutfits[allOutfits.indexWhere(
                          (outfit) => outfit.dateTime == _focusedDay)]);
                } else {
                  return const Text('');
                }
              }),
              Text(allOutfits.length.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
