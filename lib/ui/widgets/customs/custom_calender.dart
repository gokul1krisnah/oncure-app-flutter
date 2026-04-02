import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: directives_ordering
import 'package:intl/intl.dart';

class CalenderCard extends StatefulWidget {
  final DateTime initialFocusedDay;
  final DateTime? initialSelectedDay;
  final ValueChanged<DateTime>? onDateSelected;

  const CalenderCard({
    super.key,
    // ignore: always_put_required_named_parameters_first
    required this.initialFocusedDay,
    this.initialSelectedDay,
    this.onDateSelected,
  });

  @override
  State<CalenderCard> createState() => _CalenderCardState();
}

class _CalenderCardState extends State<CalenderCard> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  late int _startYear;
  late int _endYear;

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialFocusedDay;
    _selectedDay = widget.initialSelectedDay;
    _startYear = _focusedDay.year - 85;
    _endYear = _focusedDay.year + 5;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  // 🔥 Toggle dropdown
  void _toggleYearDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createYearDropdown();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  // 🔥 Year dropdown UI (UPDATED)
  OverlayEntry _createYearDropdown() {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final years = List.generate(
      _endYear - _startYear + 1,
      (i) => _startYear + i,
    );

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 120, // 👈 better width
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 36),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: years.length,
                itemBuilder: (_, index) {
                  final year = years[index];
                  final isSelected = year == _focusedDay.year;

                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      setState(() {
                        _focusedDay = DateTime(
                          year,
                          _focusedDay.month,
                          1, // ✅ FIXED DATE ISSUE
                        );
                      });
                      _toggleYearDropdown();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ), // 👈 spacing
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ), // 👈 padding
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primary.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$year',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? primary
                              : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      children: [
        // 🔥 HEADER
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Text(
                DateFormat.MMMM().format(_focusedDay),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),

              // Year dropdown trigger
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: _toggleYearDropdown,
                  child: Row(
                    children: [
                      Text(
                        '${_focusedDay.year}',
                        style: theme.textTheme.titleMedium,
                      ),
                      Icon(Icons.keyboard_arrow_down, color: primary),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Previous month
              IconButton(
                icon: Icon(Icons.chevron_left, color: primary),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      1,
                    );
                  });
                },
              ),

              // Next month
              IconButton(
                icon: Icon(Icons.chevron_right, color: primary),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
        ),

        // 🔥 CALENDAR
        Expanded(
          child: TableCalendar(
            firstDay: DateTime(1900),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            headerVisible: false,

            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });

              widget.onDateSelected?.call(selected);
            },

            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,

              selectedDecoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
              ),

              selectedTextStyle: const TextStyle(color: Colors.white),

              todayDecoration: BoxDecoration(
                border: Border.all(color: primary),
                shape: BoxShape.circle,
              ),

              todayTextStyle: TextStyle(color: primary),
            ),
          ),
        ),
      ],
    );
  }
}
