part of '../view/option_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, state) {
        OptionCubit optionCubit = context.read<OptionCubit>();
        return Row(
          children: [
            const Expanded(child: TextField()),
            const LightBlueButton(buttonText: 'Upload'),
            const LightBlueButton(buttonText: 'inventory'),
            const Spacer(),
            const LightBlueButton(buttonText: 'Move Up'),
            const LightBlueButton(buttonText: 'Move Down'),
            InkWell(
                onTap: () => optionCubit.addNewItem(),
                child: const LightBlueButton(buttonText: 'Add')),
            InkWell(
                onTap: optionCubit.state.selectedItem == null
                    ? null
                    : () async => optionCubit.handleItemDeletion(optionCubit.state.selectedItem!),
                // .whenComplete(() => optionCubit.getOptions()),
                child: const LightBlueButton(buttonText: 'Delete')),
            InkWell(
                onTap: () async {
                  await optionCubit.saveItemChanges();
                },
                child: const LightBlueButton(buttonText: 'Save')),
            const LightBlueButton(buttonText: 'Export'),
            InkWell(
                onTap: () => Navigator.pop(context),
                child: const LightBlueButton(buttonText: 'Exit')),
          ],
        );
      },
    );
  }
}
