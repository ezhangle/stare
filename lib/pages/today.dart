import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/properties.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/panel.dart';
import 'package:stare/widgets/utils.dart';

import '../widgets/list_picker.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.center,
                child: PhysicalModel(
                  color: Colors.transparent,
                  shadowColor: Colors.black.withOpacity(0.25),
                  elevation: defaultPadding,
                  child: SvgPicture.asset(
                    "assets/images/tear-calendar.svg",
                    width: 224,
                  ),
                ),
              ),
              const Positioned(
                top: defaultPadding * 2,
                left: defaultPadding,
                child: NavWheel(),
              ),
            ],
          ),
          Panel(
            children: <Widget>[
              _CalendarView(),
            ],
          ),
          const ColumnGap(),
        ],
      ),
    );
  }
}

class _CalendarView extends StatefulWidget {
  const _CalendarView({Key? key}) : super(key: key);

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  late final DateTime today;
  late final int year;

  late int month;
  late int firstWeekday;
  late int totalDaysInMonth;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    today = DateTime.now();
    selectedDate = today;
    year = today.year;
    month = today.month;

    _init();
  }

  void _init() {
    final DateTime thisMonthsFirstDate = DateTime.utc(year, month, 1);
    final DateTime nextMonthsFirstDate = DateTime.utc(year, month + 1, 1);

    firstWeekday = thisMonthsFirstDate.weekday;
    totalDaysInMonth =
        nextMonthsFirstDate.difference(thisMonthsFirstDate).inDays;

    debugPrint("First Weekday $firstWeekday\nTotal Days $totalDaysInMonth");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const ColumnGap(),
        Container(
          height: 32,
          alignment: Alignment.center,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const <double>[0, 0.25, 0.75, 1],
              colors: <Color>[
                Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).colorScheme.onPrimary.withOpacity(0),
                Theme.of(context).colorScheme.onPrimary.withOpacity(0),
                Theme.of(context).colorScheme.onPrimary,
              ],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListPicker(
                itemCount: months.length,
                width: constraints.maxWidth,
                itemBuilder: (index, focusedElementIndex) {
                  final bool focused = index == focusedElementIndex;
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      months[index],
                      textAlign: TextAlign.center,
                      style: focused
                          ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              )
                          : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const ColumnGap(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <DateLabel>[
            DateLabel("M"),
            DateLabel("T"),
            DateLabel("W"),
            DateLabel("T"),
            DateLabel("F"),
            DateLabel("S"),
            DateLabel("S"),
          ],
        ),
        const SmallColumnGap(),
        Align(
          alignment: Alignment.center,
          child: _DatesView(
            year: year,
            month: month,
            today: month == today.month ? today.day : -1,
            firstWeekday: firstWeekday,
            totalDaysInMonth: totalDaysInMonth,
            selectedDate: month == selectedDate.month ? selectedDate.day : -1,
            onTap: (int day) =>
                setState(() => selectedDate = DateTime.utc(year, month, day)),
          ),
        ),
        const ColumnGap(),
      ],
    );
  }
}

class _DatesView extends StatelessWidget {
  final int year;
  final int month;
  final int firstWeekday;
  final int totalDaysInMonth;
  final int today;
  final int selectedDate;
  final Function(int)? onTap;

  const _DatesView({
    Key? key,
    required this.year,
    required this.month,
    required this.onTap,
    required this.today,
    required this.firstWeekday,
    required this.selectedDate,
    required this.totalDaysInMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int dayCounter = 0;
    return SizedBox(
      width: 280, // 40 * 7
      height: 120, // 24 * 5
      child: Wrap(
        children: List<DateLabel>.generate(
          35,
          (index) {
            if (index < firstWeekday - 1 ||
                index >= (totalDaysInMonth + firstWeekday - 1)) {
              return const DateLabel("");
            } else {
              dayCounter += 1;
              final thisDay = dayCounter;
              return DateLabel(
                dayCounter.toString(),
                glow: dayCounter == today,
                bold: dayCounter == today || dayCounter == selectedDate,
                onTap: () {
                  return onTap?.call(thisDay);
                },
              );
            }
          },
          growable: false,
        ),
      ),
    );
  }
}

class DateLabel extends StatelessWidget {
  final String label;
  final bool glow;
  final bool bold;
  final Function()? onTap;

  const DateLabel(
    this.label, {
    Key? key,
    this.onTap,
    this.glow = false,
    this.bold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 24, // fontSize(12) * lineHeight(1.5) + spacing(6)
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: bold
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w200,
                  shadows: glow
                      ? <BoxShadow>[
                          BoxShadow(
                            offset: const Offset(0, 4),
                            color: Theme.of(context).colorScheme.primary,
                            blurRadius: defaultPadding * 1.5,
                          ),
                        ]
                      : null,
                  height: 2,
                ),
          ),
        ),
      );
}
