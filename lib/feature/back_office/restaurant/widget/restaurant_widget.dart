part of '../view/restaurant_dialog_view.dart';

class _LeftInfoTitle extends StatelessWidget {
  const _LeftInfoTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CustomFontStyle.popupNotificationTextStyle.copyWith(
        color: context.colorScheme.tertiary,
      ),
    );
  }
}

class _BottomButtonWidget extends StatelessWidget {
  const _BottomButtonWidget({required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .08,
      constraints: const BoxConstraints(minWidth: 55, maxWidth: 75, minHeight: 25, maxHeight: 45),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: context.colorScheme.onSecondary,
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        border: Border.all(
          color: context.colorScheme.tertiary,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: CustomFontStyle.buttonTextStyle.copyWith(color: context.colorScheme.primary),
        ),
      ),
    );
  }
}

class _TitleWithDivider extends StatelessWidget {
  const _TitleWithDivider({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(title, style: CustomFontStyle.formsTextStyle),
          const SizedBox(width: 5),
          Expanded(
            child: Divider(
              color: context.colorScheme.surfaceTint,
              height: 20,
              thickness: 4,
            ),
          )
        ],
      ),
    );
  }
}
