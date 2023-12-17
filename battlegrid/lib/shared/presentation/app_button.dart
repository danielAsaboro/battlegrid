import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final bool outlined;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonColor,
    this.outlined = false,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: buttonHeight ?? 48.h,
        width: buttonWidth ?? double.infinity,
        child: outlined
            ? OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: textColor ?? Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  side: BorderSide(
                    width: 1.0,
                    color: borderColor ?? Colors.black,
                    style: BorderStyle.solid,
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Center(child: child),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: buttonColor ?? Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Center(child: child),
              ),
      ),
    );
  }
}
