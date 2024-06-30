import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppDialog extends HookWidget {
  final String title;
  final bool enableLeftBtn;
  final bool enableRightBtn;
  final String? subtitle;
  final String? leftBtnTxt;
  final String? rightBtnTxt;
  final Function? actionLeftBtn;
  final Function? actionRightBtn;

  const AppDialog({
    Key? key,
    required this.title,
    required this.enableLeftBtn,
    required this.enableRightBtn,
    this.subtitle,
    this.leftBtnTxt,
    this.rightBtnTxt,
    this.actionLeftBtn,
    this.actionRightBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnimationController _controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      _controller.forward();
      return _controller.dispose;
    }, [_controller]);

    return FadeTransition(
      opacity: _controller.drive(CurveTween(curve: Curves.easeInOut)),
      child: AlertDialog(
        title: Text(title),
        content: Text(subtitle ?? ""),
        actions: [
          if (enableLeftBtn && leftBtnTxt != null && actionLeftBtn != null)
            TextButton(
              child: Text(leftBtnTxt!),
              onPressed: () {
                actionLeftBtn!();
              },
            ),
          if (enableRightBtn && rightBtnTxt != null && actionRightBtn != null)
            TextButton(
              child: Text(rightBtnTxt!),
              onPressed: () {
                actionRightBtn!();
              },
            ),
        ],
      ),
    );
  }
}
