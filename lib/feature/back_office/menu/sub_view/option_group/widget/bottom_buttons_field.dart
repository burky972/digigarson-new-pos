part of '../view/option_group_view.dart';

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
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            const LightBlueButton(buttonText: 'Move Up'),
            const LightBlueButton(buttonText: 'Move Down'),
            LightBlueButton(
              buttonText: 'Add',
              onTap: () => optionCubit.addNewOption(),
            ),
            LightBlueButton(
              buttonText: 'Delete',
              onTap: state.selectedOption == null
                  ? null
                  : () async => await patchOption(
                          context: context,
                          selectedOption: state.selectedOption,
                          allOptions: state.allOptions)
                      .whenComplete(() => context.read<ProductCubit>().getOptions()),
            ),
            LightBlueButton(
              buttonText: 'Save',
              onTap: () async => await optionCubit.saveChanges().whenComplete(
                    () => context
                        .read<ProductCubit>()
                        .getOptions()
                        .whenComplete(() async => await optionCubit.getOptions()),
                  ),
            ),
            const LightBlueButton(buttonText: 'Export'),
            LightBlueButton(
              buttonText: 'Exit',
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> patchOption(
      {required BuildContext context,
      required OptionModel? selectedOption,
      required List<OptionModel?> allOptions}) async {
    OptionCubit optionCubit = context.read<OptionCubit>();
    bool hasItemsInOption = false;
    appLogger.info("selected Option", '$selectedOption, ${selectedOption?.items?.length}');
    // for (var option in allOptions) {
    if (selectedOption?.items != null && selectedOption!.items!.isNotEmpty) {
      hasItemsInOption = true;
    }
    // }
    if (hasItemsInOption) {
      showOrderErrorDialog(context, 'Option HAS Items!');
    } else {
      await optionCubit
          .patchOptions(optionId: selectedOption!.id!)
          .whenComplete(() => optionCubit.getOptions());
    }
  }
}
