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
            LightBlueButton(buttonText: 'Add', onTap: () => optionCubit.addNewItem()),
            LightBlueButton(
              buttonText: 'Delete',
              onTap: optionCubit.state.selectedItem == null
                  ? null
                  : () async => optionCubit.handleItemDeletion(optionCubit.state.selectedItem!),
            ),
            LightBlueButton(
              buttonText: 'Save',
              onTap: () async =>
                  await optionCubit.saveItemChanges().whenComplete(() => optionCubit.getOptions()),
            ),
            const LightBlueButton(buttonText: 'Export'),
            LightBlueButton(buttonText: 'Exit', onTap: () => routeManager.pop()),
          ],
        );
      },
    );
  }
}
