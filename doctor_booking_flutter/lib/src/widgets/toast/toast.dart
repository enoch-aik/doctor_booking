import 'package:doctor_booking_flutter/core/service_exceptions/src/api_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class Toast {
  static const double _toastHeight = 70.0;
  static const Color _backgroundColor = Color.fromRGBO(247, 247, 247, 1);

  static void show(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(
      context,
      title ?? 'Success',
      msg ?? '',
      Icons.check_circle_outline,
      const Color(0xFF25D366),
      duration,
    );
  }

  static void success(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(
      context,
      title ?? 'Success',
      msg ?? '',
      Icons.check_circle_outline,
      const Color(0xFF25D366),
      duration,
    );
  }

  static void error(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(
      context,
      title ?? 'Error',
      msg ?? '',
      Icons.error_outline,
      const Color(0xFFEB0000),
      duration,
    );
  }

  static void formError(
    BuildContext context, {
    int duration = 5,
  }) {
    _showToast(
      context,
      "Error",
      "Fix highlighted errors",
      Icons.error_outline,
      const Color(0xFFEB0000),
      duration,
    );
  }

  static void apiError(
    ApiExceptions exception,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(
      context,
      title ?? 'Error',
      ApiExceptions.getErrorMessage(exception),
      Icons.error_outline,
      const Color(0xFFEB0000),
      duration,
    );
  }

  static void info(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(context, title ?? 'Info', msg ?? '', Icons.warning_outlined,
        const Color(0xFFF59300), duration);
  }

  static void _showToast(
    BuildContext context,
    String title,
    String body,
    IconData icon,
    Color iconColor,
    int seconds,
  ) {
    final overlayState = Overlay.of(context);
    final textTheme = Theme.of(context).textTheme;
    final duration = Duration(seconds: seconds);

    late AnimationController controller;
    late Animation<Offset> slideAnimation;

    // Initialize the animation controller
    controller = AnimationController(
      vsync: Overlay.of(context),
      duration: const Duration(milliseconds: 700),
    );

    // Initialize the slide animation
    slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Slide in from the top
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
       // key: toastKey,
        top: MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        child: Consumer(builder: (context, ref, child) {
          ColorScheme colorScheme = Theme.of(context).colorScheme;
          return SlideTransition(
            position: slideAnimation,
            child: GestureDetector(
              onTap: () {
                if (overlayEntry.mounted) {
                  controller.reverse().then((_) {
                    overlayEntry.remove();
                  });
                }
              },
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    // height: _toastHeight,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.secondaryContainer,
                          blurRadius: 10.0, // Soften the shaodw
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            icon,
                            color: iconColor,
                            size: 32.0,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: textTheme.labelMedium?.copyWith(
                                  color: iconColor,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(body, style: textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );

    overlayState.insert(overlayEntry);

    // Start the animation
    controller.forward();

    // Remove the toast after the specified duration
    Future.delayed(duration).then((_) {
      if (overlayEntry.mounted) {
        controller.reverse().then((_) {
          overlayEntry.remove();
        });
      }
    });
  }

/*static void _showToast(
    BuildContext context,
    String title,
    String body,
    IconData icon,
    Color iconColor,
    int seconds,
  ) {
    final overlayState = Overlay.of(context);
    final textTheme = Theme.of(context).textTheme;
    final duration = Duration(seconds: seconds);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            if (overlayEntry.mounted) {
              overlayEntry.remove();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
             // height: _toastHeight,
              color: _backgroundColor,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 32.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: textTheme.labelMedium?.copyWith(
                            color: iconColor,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(body, style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(duration).then((_) {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }*/
}
