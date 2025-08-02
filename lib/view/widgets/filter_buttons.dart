import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../utils/style/colors/colors.dart';

// ignore: must_be_immutable
class FilterButtons extends StatelessWidget {
  final String text;
  final String textIcon;
  final double fontSize;
  final Color? color;
  final int? count;
  final double? width;
  final double? height;
  void Function()? onTap;

  FilterButtons(
      {super.key,
      required this.text,
      this.textIcon = '',
      this.onTap,
      this.width = double.minPositive,
      this.height = 45,
      this.fontSize = 13,
      this.color = Colors.white,
      this.count});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        // width: width,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color, border: Border.all(color: AppColors.blueGrayColour)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Row(
            children: [
              Text(
                textIcon,
              ),
              CustomText(
                text: '  $text',
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 224, 223, 223)),
                child: Center(
                  child: CustomText(
                    text: count.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
