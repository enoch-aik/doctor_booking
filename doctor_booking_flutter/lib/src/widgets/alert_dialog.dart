import 'dart:io';

import 'package:doctor_booking_flutter/lib.dart';

Future showMessageAlertDialog(context,
    {required text, onTap, isDismissible, String? actionText}) {
  final bool isAndroid = Platform.isAndroid;
  return showDialog(
    barrierDismissible: isDismissible ?? true,
    context: context,
    builder: (context) => AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 0,
      content: KText(text, textAlign: TextAlign.center, fontSize: 16.sp),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
          child: SizedBox(
            height: 50.h,
            width: double.maxFinite,
            child: isAndroid
                ? FilledButton(
                    onPressed: onTap ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: KText(actionText ?? 'Got it'),
                  )
                : TextButton(
                    onPressed: onTap ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: KText(actionText ?? 'Got it'),
                  ),
          ),
        )
      ],
    ),
  );
}
