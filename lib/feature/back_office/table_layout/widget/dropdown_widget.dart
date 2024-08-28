part of '../view/table_layout_view.dart';

class _SectionDropDownWidget extends StatelessWidget {
  const _SectionDropDownWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      builder: (context, state) {
        // create a list of dropdown menu items
        final items = state.originalSections?.map<DropdownMenuItem<String>>((SectionModel value) {
          return DropdownMenuItem<String>(
            value: value.id,
            child: Text(value.title ?? ''),
          );
        }).toList();

        // if selectedSection is null and allSections is not empty, select the first item
        String? selectedValue;
        if (state.selectedSection != null) {
          selectedValue = state.selectedSection?.id;
        } else if (state.allSections != null && state.allSections!.isNotEmpty) {
          selectedValue = state.allSections!.first.id;
        }

        // check if the selected value is in the items list
        final isSelectedValueInItems = items?.any((item) => item.value == selectedValue) ?? false;

        // if the selected value is not in the items list, make allSections's first item selected
        if (!isSelectedValueInItems && state.allSections != null && state.allSections!.isNotEmpty) {
          selectedValue = state.allSections!.first.id;
        }

        return DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          style: context.textTheme.titleSmall,
          onChanged: (newValue) {
            final selectedSection = (state.originalSections ?? state.allSections)?.firstWhere(
              (section) => section.id == newValue,
              orElse: () => SectionModel.empty(),
            );

            Random random = Random();
            int randomNumber = random.nextInt(1000000);
            context.read<SectionCubit>().setSelectedSection(
                  sectionModel: selectedSection ??
                      SectionModel.empty().copyWith(
                          id: (newValue?.length.toString() ?? '0') + randomNumber.toString()),
                );
          },
          items: items,
        );
      },
    );
  }
}
