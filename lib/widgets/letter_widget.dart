import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_scale_hover/utils/constants.dart';
import 'package:flutter_text_scale_hover/utils/text_styles.dart';

class LetterWidget extends StatefulWidget {
  const LetterWidget({
    Key? key,
    required this.letter,
    this.animate = false,
    this.dragDetails,
  }) : super(key: key);

  final String letter;
  final Offset? dragDetails;
  final bool animate;

  @override
  State<LetterWidget> createState() => _LetterWidgetState();
}

class _LetterWidgetState extends State<LetterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> scaleAnimation;

  late Animation<Offset> translateAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: AppConstants.animationDuration));

    scaleAnimation = Tween(begin: 1.0, end: 1.42).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    translateAnimation =
        Tween(begin: const Offset(0, 0), end: const Offset(0, -.55)).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      animationController.forward();
      HapticFeedback.vibrate();
    } else {
      animationController.reverse();
    }

    return SizedBox(
      width: AppConstants.letterWidgetWidth,
      child: SlideTransition(
        position: translateAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: AnimatedDefaultTextStyle(
            curve: Curves.easeInOut,
            textAlign: TextAlign.center,
            style: textStyle,
            duration:
                const Duration(milliseconds: AppConstants.animationDuration),
            child: Text(
              widget.letter,
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get textStyle =>
      widget.animate ? animatedTextStyle : defaultTextStyle;

  TextStyle get animatedTextStyle => TextStyles.mainTextStyle.apply(
        fontWeightDelta: 12,
        color: Colors.orangeAccent,
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(0, 8),
            blurRadius: 16.0,
            color: Colors.orangeAccent.withOpacity(.12),
          ),
        ],
      );

  TextStyle get defaultTextStyle => TextStyles.mainTextStyle.apply(
        fontWeightDelta: 12,
        color: Colors.white,
      );
}
