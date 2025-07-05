import 'package:flutter/material.dart';

showLoaderDialog(context) {
  showDialog<void>(
      // barrierColor: Colors.white,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return
            // SimpleDialog(
            //   backgroundColor: Colors.white,
            //   children: [
            //     Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            //             child:
            Stack(
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/images/loading_cat.gif",
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        );
        //         ),
        //       ],
        //     ),
        //   )
        // ],
        // );
      });
}
