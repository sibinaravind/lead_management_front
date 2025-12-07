import 'package:flutter/material.dart';

import '../../config/flavour_config.dart';
import '../../utils/style/colors/colors.dart';

showLoaderDialog(context) {
  showDialog<void>(
      // barrierColor: Colors.white,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: AppColors.primaryColor.withOpacity(0.2),
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.only(),
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              child: Image.asset(
                                FlavourConfig.appLogo(),
                                // color: Colors.t,
                                fit: BoxFit.contain,
                                height: 100,
                                width: 200,
                              ),
                            ),
                          ),
                        ],
                      )),
                  CircularProgressIndicator(
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        );
      });
}
