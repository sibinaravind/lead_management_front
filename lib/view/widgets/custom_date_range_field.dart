import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/widgets/custom_action_button.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/style/colors/colors.dart';

class CustomDateRangeField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final void Function(DateTime start, [DateTime? end])? onSelected;

  const CustomDateRangeField({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.onSelected,
  });

  @override
  State<CustomDateRangeField> createState() => _CustomDateRangeFieldState();
}

class _CustomDateRangeFieldState extends State<CustomDateRangeField> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDay = DateTime.now();

  void _openCalendarDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Select Date Range"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 350,
                height: 350,
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.now(),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, _startDate) || isSameDay(day, _endDate),
                  rangeStartDay: _startDate,
                  rangeEndDay: _endDate,
                  rangeSelectionMode: RangeSelectionMode.toggledOn,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      if (_startDate != null &&
                          _endDate == null &&
                          selectedDay.isAfter(_startDate!)) {
                        _endDate = selectedDay;
                      } else {
                        _startDate = selectedDay;
                        _endDate = null;
                      }

                      // Update text
                      if (_startDate != null && _endDate != null) {
                        widget.controller.text =
                            "${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}";
                        widget.onSelected?.call(_startDate!, _endDate);
                      } else if (_startDate != null && _endDate == null) {
                        widget.controller.text = _formatDate(_startDate!);
                        widget.onSelected?.call(_startDate!);
                      }
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    rangeHighlightColor:
                        AppColors.primaryColor.withOpacity(0.2),
                    rangeStartDecoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    rangeEndDecoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
              );
            },
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomActionButton(
                    text: 'Cancel',
                    icon: Icons.close,
                    onPressed: () => Navigator.pop(context),
                    isFilled: false,
                    textColor: Colors.blue.shade600,
                    borderColor: Colors.blue.shade100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomActionButton(
                    text: 'Done',
                    icon: Icons.check,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    isFilled: true,
                    gradient: AppColors.orangeGradient,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.textColor,
      ),
      decoration: InputDecoration(
        hintText: widget.label,
        suffixIcon: const Icon(Icons.calendar_today),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
      validator: widget.isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
      onTap: _openCalendarDialog,
    );
  }
}
