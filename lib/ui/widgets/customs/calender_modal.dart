import 'package:flutter/material.dart';
import 'custom_calender.dart';

//CALENDAR MODAL

class CalendarModal {
  static Future<void> show({
    required BuildContext context,
    required DateTime focusedDay,
    required Function(DateTime) onDateSelected, DateTime? selectedDay,
  }) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SizedBox(
          height: 450,
          child: CalenderCard(
            initialFocusedDay: focusedDay,
            initialSelectedDay: selectedDay,
            onDateSelected: onDateSelected,
          ),
        ),
    );
}