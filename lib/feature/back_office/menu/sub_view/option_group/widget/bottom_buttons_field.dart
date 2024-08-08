part of '../view/option_group_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    OptionCubit optionCubit = context.read<OptionCubit>();
    return Row(
      children: [
        const Expanded(child: TextField()),
        const LightBlueButton(buttonText: 'Upload'),
        const LightBlueButton(buttonText: 'inventory'),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        const LightBlueButton(buttonText: 'Move Up'),
        const LightBlueButton(buttonText: 'Move Down'),
        InkWell(
            onTap: () => optionCubit.addNewOption(),
            child: const LightBlueButton(buttonText: 'Add')),
        InkWell(
            onTap: optionCubit.state.selectedOption == null
                ? null
                : () async => await patchOption(context),
            child: const LightBlueButton(buttonText: 'Delete')),
        InkWell(
            onTap: () async {
              await optionCubit.saveChanges();
            },
            child: const LightBlueButton(buttonText: 'Save')),
        const LightBlueButton(buttonText: 'Export'),
        InkWell(
            onTap: () => Navigator.pop(context), child: const LightBlueButton(buttonText: 'Exit')),
      ],
    );
  }

  Future<void> patchOption(BuildContext context) async {
    OptionCubit optionCubit = context.read<OptionCubit>();
    bool hasItemsInOption = false;
    for (var option in optionCubit.state.allOptions) {
      if (option?.items != null || option!.items!.isNotEmpty) {
        hasItemsInOption = true;
        break;
      }
    }
    if (hasItemsInOption) {
      showOrderErrorDialog(context, 'Option HAS Items!');
    } else {
      await optionCubit
          .patchOptions(optionId: optionCubit.state.selectedOption!.id!)
          .whenComplete(() => optionCubit.getOptions());
    }
  }
}
