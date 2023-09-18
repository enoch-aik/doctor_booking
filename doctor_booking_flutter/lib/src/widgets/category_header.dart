import 'package:doctor_booking_flutter/lib.dart';

class CategoryHeader extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String? actionText;
  final Widget? actionIcon;

  const CategoryHeader(
      {super.key,
      this.actionText,
      this.actionIcon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText(
          title,
        ),
        actionIcon ??
            TextButton(
              onPressed: onPressed,
              child: KText(
                actionText ?? 'See all',
                fontWeight: FontWeight.w500,
              ),
            ),
      ],
    );
  }
}
