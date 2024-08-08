part of '../re_open_right_widget.dart';

class _ReOpenButton extends StatelessWidget {
  const _ReOpenButton({required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .08,
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
          style: const TextStyle(color: Colors.indigo, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ReOpenLeftTextWidget extends StatelessWidget {
  const _ReOpenLeftTextWidget({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.indigo, fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}

class _ReOpenRightText extends StatelessWidget {
  const _ReOpenRightText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: Colors.deepOrange.shade400, fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}
