import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;
          final horizontalPadding = isNarrow ? 10.0 : 14.0;

          return ListView(
            padding: EdgeInsets.all(horizontalPadding),
            children: [
              _CalendarHeader(isNarrow: isNarrow),
              const SizedBox(height: 12),
              _MonthlyPlannerCard(
                isNarrow: isNarrow,
                displayedYear: today.year,
                displayedMonth: today.month,
                today: today,
              ),
              const SizedBox(height: 12),
              _TodayScheduleCard(
                isNarrow: isNarrow,
                today: today,
                plans: _MonthlyPlannerCard.plansForDay(today.day),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
        Text(
          'Calendar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isNarrow ? 18 : 20,
              ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class _MonthlyPlannerCard extends StatelessWidget {
  const _MonthlyPlannerCard({
    required this.isNarrow,
    required this.displayedYear,
    required this.displayedMonth,
    required this.today,
  });

  final bool isNarrow;
  final int displayedYear;
  final int displayedMonth;
  final DateTime today;

  static const _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const _monthLabels = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static final Map<int, List<_PlanItem>> _plans = {
    1: [const _PlanItem('Hospital visit', Color(0xFFD6EAFE))],
    2: [const _PlanItem('Grocery', Color(0xFFE9E0FF))],
    3: [const _PlanItem('PT check', Color(0xFFFDE7C7))],
    4: [const _PlanItem('Family call', Color(0xFFDDF4E4))],
    5: [const _PlanItem('Project', Color(0xFFD6EAFE))],
    6: [const _PlanItem('Health check', Color(0xFFFDE7C7))],
    7: [
      const _PlanItem('Wedding prep', Color(0xFFF8D9E3)),
      const _PlanItem('Groceries', Color(0xFFD6EAFE)),
    ],
    11: [const _PlanItem('Clinic', Color(0xFFDDF4E4))],
    13: [const _PlanItem('Meeting', Color(0xFFE9E0FF))],
    17: [const _PlanItem('Online class', Color(0xFFD6EAFE))],
    19: [const _PlanItem('Kids pickup', Color(0xFFE9E0FF))],
    23: [const _PlanItem('Gym', Color(0xFFDDF4E4))],
    31: [const _PlanItem('Family day', Color(0xFFF8D9E3))],
  };

  static List<_PlanItem> plansForDay(int day) {
    return _plans[day] ?? const <_PlanItem>[];
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: isNarrow ? 14 : 16,
          fontWeight: FontWeight.w700,
        );

    return Container(
      padding: EdgeInsets.all(isNarrow ? 10 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.chevron_left_rounded, size: 20),
              Text('$displayedYear ${_monthLabels[displayedMonth - 1]}', style: titleStyle),
              const Icon(Icons.chevron_right_rounded, size: 20),
              const Spacer(),
              Container(
                width: isNarrow ? 22 : 24,
                height: isNarrow ? 22 : 24,
                decoration: const BoxDecoration(
                  color: AppTheme.textPrimary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${today.day}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: isNarrow ? 11 : 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _PlannerTable(
            isNarrow: isNarrow,
            displayedYear: displayedYear,
            displayedMonth: displayedMonth,
            today: today,
          ),
        ],
      ),
    );
  }
}

class _PlannerTable extends StatelessWidget {
  const _PlannerTable({
    required this.isNarrow,
    required this.displayedYear,
    required this.displayedMonth,
    required this.today,
  });

  final bool isNarrow;
  final int displayedYear;
  final int displayedMonth;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final firstWeekdayOffset = DateTime(displayedYear, displayedMonth, 1).weekday % 7;
    final daysInMonth = DateTime(displayedYear, displayedMonth + 1, 0).day;
    final todayDay = today.year == displayedYear && today.month == displayedMonth ? today.day : null;

    final rows = <TableRow>[];

    rows.add(
      TableRow(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFECECEC))),
        ),
        children: _MonthlyPlannerCard._days
            .map(
              (day) => Padding(
                padding: EdgeInsets.symmetric(vertical: isNarrow ? 6 : 8),
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: isNarrow ? 10 : 11,
                      color: AppTheme.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );

    var dayNumber = 1;
    for (var week = 0; week < 6; week++) {
      final cells = <Widget>[];
      for (var dayIndex = 0; dayIndex < 7; dayIndex++) {
        final cellIndex = week * 7 + dayIndex;
        final isEmpty = cellIndex < firstWeekdayOffset || dayNumber > daysInMonth;
        final day = isEmpty ? null : dayNumber;
        cells.add(
          _DayCell(
            day: day,
            isNarrow: isNarrow,
            isToday: day != null && day == todayDay,
          ),
        );
        if (!isEmpty) {
          dayNumber++;
        }
      }

      rows.add(
        TableRow(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1))),
          ),
          children: cells,
        ),
      );
    }

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: rows,
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day, required this.isNarrow, required this.isToday});

  final int? day;
  final bool isNarrow;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final plans = day == null ? const <_PlanItem>[] : (_MonthlyPlannerCard._plans[day] ?? const <_PlanItem>[]);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: isNarrow ? 58 : 68),
      child: Padding(
        padding: EdgeInsets.all(isNarrow ? 2 : 3),
        child: day == null
            ? const SizedBox.shrink()
            : Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 2 : 3,
                  vertical: isNarrow ? 2 : 3,
                ),
                decoration: isToday
                    ? BoxDecoration(
                        color: const Color(0xFFFFF2F2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFFFCACA)),
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isToday ? const Color(0xFFC94D4D) : AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: isNarrow ? 10 : 11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    ...plans.take(isNarrow ? 1 : 2).map((plan) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: EdgeInsets.symmetric(
                          horizontal: isNarrow ? 3 : 4,
                          vertical: isNarrow ? 1 : 2,
                        ),
                        decoration: BoxDecoration(
                          color: plan.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          plan.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isNarrow ? 8 : 9,
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
      ),
    );
  }
}

class _TodayScheduleCard extends StatelessWidget {
  const _TodayScheduleCard({
    required this.isNarrow,
    required this.today,
    required this.plans,
  });

  final bool isNarrow;
  final DateTime today;
  final List<_PlanItem> plans;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: isNarrow ? 14 : 16,
          fontWeight: FontWeight.w700,
        );

    return Container(
      padding: EdgeInsets.all(isNarrow ? 12 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Today, ${today.year}.${today.month}.${today.day}', style: titleStyle),
          const SizedBox(height: 10),
          if (plans.isEmpty)
            Text(
              'No schedule for today.',
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: isNarrow ? 12 : 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ...plans.map(
            (plan) => Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.symmetric(
                horizontal: isNarrow ? 10 : 12,
                vertical: isNarrow ? 8 : 9,
              ),
              decoration: BoxDecoration(
                color: plan.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                plan.title,
                style: TextStyle(
                  fontSize: isNarrow ? 12 : 13,
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanItem {
  const _PlanItem(this.title, this.color);

  final String title;
  final Color color;
}
