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
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        const LightBlueButton(buttonText: 'Move Up'),
        const LightBlueButton(buttonText: 'Move Down'),
        LightBlueButton(
          buttonText: 'Add',
          onTap: () => context.read<CategoryCubit>().addNewCategory(),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: context.read<CategoryCubit>().state.selectedCategory == null
              ? null
              : () async {
                  await patchCategory(context);
                },
        ),
        LightBlueButton(
            buttonText: 'Save',
            onTap: () async => await context.read<CategoryCubit>().saveChanges()),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Future<void> patchCategory(BuildContext context) async {
    ProductCubit productCubit = context.read<ProductCubit>();
    bool hasProductInCategory = false;
    for (var product in productCubit.state.allProducts) {
      if (product?.category == context.read<CategoryCubit>().state.selectedCategory?.id) {
        hasProductInCategory = true;
        break;
      }
    }
    if (hasProductInCategory) {
      showOrderErrorDialog(context, 'CATEGORY HAS PRODUCTS!');
    } else {
      await context
          .read<CategoryCubit>()
          .patchCategories(categoryId: context.read<CategoryCubit>().state.selectedCategory!.id!)
          .whenComplete(() => context.read<CategoryCubit>().getCategories());
    }
  }
}
