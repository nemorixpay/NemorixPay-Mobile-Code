import 'package:flutter/material.dart';

class CustomTwoButtons extends StatelessWidget {
  final String textButton1;
  final Color? backgroundColorButton1;
  final Function()? onFunctionButton1;
  final String textButton2;
  final Color? backgroundColorButton2;
  final Function()? onFunctionButton2;
  final double height;
  final Color? textColor1;
  final Color? textColor2;

  const CustomTwoButtons({
    super.key,
    required this.textButton1,
    required this.onFunctionButton1,
    required this.textButton2,
    required this.onFunctionButton2,
    this.height = 1,
    this.backgroundColorButton1,
    this.backgroundColorButton2,
    this.textColor1,
    this.textColor2,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.4;
    final sizeH = 55 * height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: size,
          height: sizeH,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  backgroundColorButton1 ?? Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onFunctionButton1,
            child: Text(
              textButton1,
              style: TextStyle(
                color:
                    textColor2 ?? Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: size,
          height: sizeH,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  backgroundColorButton2 ?? Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onFunctionButton2,
            child: Text(
              textButton2,
              style: TextStyle(color: textColor2 ?? Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
