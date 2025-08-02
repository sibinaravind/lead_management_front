import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;

  const CustomShimmerWidget({
    super.key,
    this.height = 192,
    this.margin = const EdgeInsets.all(10),
    this.padding = const EdgeInsets.all(10),
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.blueNeutralColor,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        margin: margin,
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(37, 37, 37, 0.06),
              offset: Offset(0, 5),
              blurRadius: 4,
            )
          ],
          color: Colors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 238, 238, 238).withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
    );
  }
}
