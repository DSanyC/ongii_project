import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../shared/widgets/unified_page_header.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;
  final Map<String, int> _selectedDayByMonth = <String, int>{};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _displayedMonth = DateTime(now.year, now.month);
    _selectedDayByMonth[_monthKey(_displayedMonth.year, _displayedMonth.month)] =
        _selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;
          final horizontalPadding = isNarrow ? 10.0 : 14.0;

          return Column(
            children: [
              const UnifiedPageHeader(
                title: 'Ongii',
                actionIcon: Icons.notifications_none_rounded,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(horizontalPadding),
                  children: [
                    _MonthlyPlannerCard(
                      isNarrow: isNarrow,
                      displayedYear: _displayedMonth.year,
                      displayedMonth: _displayedMonth.month,
                      today: today,
                      selectedDay: _selectedDayByMonth[
                          _monthKey(_displayedMonth.year, _displayedMonth.month)],
                      onTapPreviousMonth: _moveToPreviousMonth,
                      onTapNextMonth: _moveToNextMonth,
                      onTapMonthLabel: _showMonthPickerDialog,
                      onTapTodayBadge: _jumpToToday,
                      onDayTap: (date) {
                        setState(() {
                          _selectedDate = date;
                          _selectedDayByMonth[_monthKey(date.year, date.month)] = date.day;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _SelectedScheduleCard(
                      isNarrow: isNarrow,
                      selectedDate: _selectedDate,
                      plans: _MonthlyPlannerCard.plansForDay(_selectedDate.day),
                      onPlanTap: _handlePlanTap,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _moveToPreviousMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1);
      _syncSelectedDateFromDisplayedMonth();
    });
  }

  void _moveToNextMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);
      _syncSelectedDateFromDisplayedMonth();
    });
  }

  String _monthKey(int year, int month) => '$year-$month';

  void _syncSelectedDateFromDisplayedMonth() {
    final savedDay =
        _selectedDayByMonth[_monthKey(_displayedMonth.year, _displayedMonth.month)];
    if (savedDay == null) {
      return;
    }

    _selectedDate = DateTime(_displayedMonth.year, _displayedMonth.month, savedDay);
  }

  Future<void> _showMonthPickerDialog() async {
    var dialogYear = _displayedMonth.year;
    final pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      setDialogState(() {
                        dialogYear--;
                      });
                    },
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('$dialogYear'),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      setDialogState(() {
                        dialogYear++;
                      });
                    },
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              content: SizedBox(
                width: 280,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _MonthlyPlannerCard.monthLabels.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.1,
                  ),
                  itemBuilder: (context, index) {
                    final month = index + 1;
                    final isCurrent =
                        _displayedMonth.year == dialogYear &&
                        _displayedMonth.month == month;
                    return OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(DateTime(dialogYear, month)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isCurrent ? const Color(0xFFFFF2F2) : null,
                        side: BorderSide(
                          color: isCurrent
                              ? const Color(0xFFE53935)
                              : const Color(0xFFD8D8D8),
                        ),
                      ),
                      child: Text(_MonthlyPlannerCard.monthLabels[index]),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _displayedMonth = DateTime(pickedDate.year, pickedDate.month);
      _syncSelectedDateFromDisplayedMonth();
    });
  }

  Future<void> _handlePlanTap(_PlanItem plan) async {
    if (plan.title != 'Clinic') {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clinic'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: 11:00 AM, Main Building 3F'),
              SizedBox(height: 8),
              Text('Department: Internal Medicine'),
              SizedBox(height: 8),
              Text('Doctor: Dr. Minji Kim'),
              SizedBox(height: 8),
              Text('Preparation: Bring medical card and recent prescriptions.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _jumpToToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    setState(() {
      _displayedMonth = DateTime(today.year, today.month);
      _selectedDate = today;
      _selectedDayByMonth[_monthKey(today.year, today.month)] = today.day;
    });
  }
}

class _MonthlyPlannerCard extends StatelessWidget {
  const _MonthlyPlannerCard({
    required this.isNarrow,
    required this.displayedYear,
    required this.displayedMonth,
    required this.today,
    required this.selectedDay,
    required this.onTapPreviousMonth,
    required this.onTapNextMonth,
    required this.onTapMonthLabel,
    required this.onTapTodayBadge,
    required this.onDayTap,
  });

  final bool isNarrow;
  final int displayedYear;
  final int displayedMonth;
  final DateTime today;
  final int? selectedDay;
  final VoidCallback onTapPreviousMonth;
  final VoidCallback onTapNextMonth;
  final VoidCallback onTapMonthLabel;
  final VoidCallback onTapTodayBadge;
  final ValueChanged<DateTime> onDayTap;

  static const _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const monthLabels = [
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
    1: [const _PlanItem('Hospital visit', '09:30', Color(0xFFD6EAFE))],
    2: [const _PlanItem('Grocery', '18:00', Color(0xFFE9E0FF))],
    3: [const _PlanItem('PT check', '08:40', Color(0xFFFDE7C7))],
    4: [const _PlanItem('Family call', '20:00', Color(0xFFDDF4E4))],
    5: [const _PlanItem('Project', '10:00', Color(0xFFD6EAFE))],
    6: [const _PlanItem('Health check', '14:10', Color(0xFFFDE7C7))],
    7: [
      const _PlanItem('Wedding prep', '11:00', Color(0xFFF8D9E3)),
      const _PlanItem('Groceries', '16:30', Color(0xFFD6EAFE)),
    ],
    11: [const _PlanItem('Clinic', '11:00', Color(0xFFDDF4E4))],
    13: [const _PlanItem('Meeting', '15:00', Color(0xFFE9E0FF))],
    17: [const _PlanItem('Online class', '19:30', Color(0xFFD6EAFE))],
    19: [const _PlanItem('Kids pickup', '17:40', Color(0xFFE9E0FF))],
    23: [const _PlanItem('Gym', '06:30', Color(0xFFDDF4E4))],
    31: [const _PlanItem('Family day', '12:00', Color(0xFFF8D9E3))],
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
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTapPreviousMonth,
                child: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.chevron_left_rounded, size: 20),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTapMonthLabel,
                child: SizedBox(
                  width: isNarrow ? 86 : 94,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$displayedYear ${monthLabels[displayedMonth - 1]}',
                          style: titleStyle,
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTapNextMonth,
                child: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.chevron_right_rounded, size: 20),
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: onTapTodayBadge,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isNarrow ? 8 : 10,
                    vertical: isNarrow ? 4 : 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA000),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Today ${monthLabels[today.month - 1]} ${today.day}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: isNarrow ? 10 : 11,
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
            selectedDay: selectedDay,
            onDayTap: onDayTap,
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
    required this.selectedDay,
    required this.onDayTap,
  });

  final bool isNarrow;
  final int displayedYear;
  final int displayedMonth;
  final DateTime today;
  final int? selectedDay;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    final firstWeekdayOffset =
        DateTime(displayedYear, displayedMonth, 1).weekday % 7;
    final daysInMonth = DateTime(displayedYear, displayedMonth + 1, 0).day;
    final todayDay =
        today.year == displayedYear && today.month == displayedMonth
        ? today.day
        : null;

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
        final isEmpty =
            cellIndex < firstWeekdayOffset || dayNumber > daysInMonth;
        final day = isEmpty ? null : dayNumber;
        cells.add(
          _DayCell(
            day: day,
            isNarrow: isNarrow,
            isToday: day != null && day == todayDay,
            isSelected: day != null && selectedDay != null && day == selectedDay,
            onTap: day == null
                ? null
                : () => onDayTap(DateTime(displayedYear, displayedMonth, day)),
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
  const _DayCell({
    required this.day,
    required this.isNarrow,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  final int? day;
  final bool isNarrow;
  final bool isToday;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final plans = day == null
        ? const <_PlanItem>[]
        : (_MonthlyPlannerCard._plans[day] ?? const <_PlanItem>[]);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: isNarrow ? 58 : 68),
      child: Padding(
        padding: EdgeInsets.all(isNarrow ? 2 : 3),
        child: day == null
            ? const SizedBox.shrink()
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isNarrow ? 2 : 3,
                      vertical: isNarrow ? 2 : 3,
                    ),
                    decoration: isSelected
                        ? BoxDecoration(
                            color: const Color(0xFFFFF2F2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFE53935),
                              width: 1.4,
                            ),
                          )
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (isToday)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isNarrow ? 3 : 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFA000),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isNarrow ? 7 : 8,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            Text(
                              '$day',
                              style: TextStyle(
                                color: isToday
                                    ? const Color(0xFFBF360C)
                                    : AppTheme.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: isNarrow ? 10 : 11,
                              ),
                            ),
                          ],
                        ),
                        if (isToday)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              width: 22,
                              height: 2,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFA000),
                                borderRadius: BorderRadius.circular(999),
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
              ),
      ),
    );
  }
}

class _SelectedScheduleCard extends StatelessWidget {
  const _SelectedScheduleCard({
    required this.isNarrow,
    required this.selectedDate,
    required this.plans,
    required this.onPlanTap,
  });

  final bool isNarrow;
  final DateTime selectedDate;
  final List<_PlanItem> plans;
  final ValueChanged<_PlanItem> onPlanTap;

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
          Row(
            children: [
              Text('Schedule', style: titleStyle),
              const Spacer(),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: titleStyle,
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (plans.isEmpty)
            Text(
              'No schedule for this date.',
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: isNarrow ? 12 : 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ...plans.map(
            (plan) => InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onPlanTap(plan),
              child: Container(
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        plan.title,
                        style: TextStyle(
                          fontSize: isNarrow ? 12 : 13,
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (plan.time != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        plan.time!,
                        style: TextStyle(
                          fontSize: isNarrow ? 11 : 12,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
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
  const _PlanItem(this.title, this.time, this.color);

  final String title;
  final String? time;
  final Color color;
}
