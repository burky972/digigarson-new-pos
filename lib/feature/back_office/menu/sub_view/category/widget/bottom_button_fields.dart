part of '../view/category_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TextField()),
        const LightBlueButton(buttonText: 'Upload'),
        const LightBlueButton(buttonText: 'inventory'),
        SizedBox(width: context.dynamicWidth(0.1)),
        const LightBlueButton(buttonText: 'Move Up'),
        const LightBlueButton(buttonText: 'Move Down'),
        LightBlueButton(
          buttonText: 'Add',
          onTap: () => context.read<CategoryCubit>().addNewSubCategory(),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: context.read<CategoryCubit>().state.selectedSubCategory == null
              ? null
              : () async {
                  await patchCategory(context);
                },
        ),
        LightBlueButton(
            buttonText: 'Save',
            onTap: () async => await context
                .read<CategoryCubit>()
                .saveSubCategoriesChanges()
                .whenComplete(() => context.read<CategoryCubit>().getCategories())),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => routeManager.pop(),
        ),
      ],
    );
  }

  Future<void> patchCategory(BuildContext context) async {
    CategoryCubit categoryCubit = context.read<CategoryCubit>();
    final bool isSuccess =
        await categoryCubit.patchCategories(categoryId: categoryCubit.selectedSubCategory!.id!);
    if (!isSuccess) {
      await showOrderErrorDialog(context, '${categoryCubit.state.exception?.message}!');
      await categoryCubit.getCategories();
    } else {
      await categoryCubit
          .patchCategories(categoryId: categoryCubit.state.selectedSubCategory!.id!)
          .whenComplete(() => categoryCubit.getCategories());
    }
  }
}
