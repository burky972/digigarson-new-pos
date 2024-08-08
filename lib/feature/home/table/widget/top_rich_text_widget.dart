part of 'table_header_widget.dart';

class _TopRichTextWidget extends StatelessWidget {
  const _TopRichTextWidget({required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '$leftText:',
                style:
                    CustomFontStyle.titlesTextStyle.copyWith(color: context.colorScheme.tertiary)),
            TextSpan(
                text: ' $rightText',
                style: CustomFontStyle.popupNotificationTextStyle
                    .copyWith(color: context.colorScheme.primary)),
          ]),
        ));
  }
}
