part of '../check_right_widget.dart';

class _CheckButton extends StatelessWidget {
  const _CheckButton({required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicWidth(.08),
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: BorderConstants.borderAllSmall),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: CustomFontStyle.buttonTextStyle
              .copyWith(color: context.colorScheme.tertiary, fontSize: 16),
        ),
      ),
    );
  }
}

class _CheckLeftTextWidget extends StatelessWidget {
  const _CheckLeftTextWidget({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomFontStyle.titlesTextStyle
          .copyWith(color: context.colorScheme.tertiary, fontWeight: FontWeight.bold),
    );
  }
}

class _CheckRightText extends StatelessWidget {
  const _CheckRightText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomFontStyle.titlesTextStyle
          .copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }
}
