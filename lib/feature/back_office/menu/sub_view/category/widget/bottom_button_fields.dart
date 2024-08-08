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
        InkWell(
            onTap: () {
              context.read<CategoryCubit>().addNewCategory();
            },
            child: const LightBlueButton(buttonText: 'Add')),
        InkWell(
            onTap: context.read<CategoryCubit>().state.selectedCategory == null
                ? null
                : () async {
                    await patchCategory(context);
                  },
            child: const LightBlueButton(buttonText: 'Delete')),
        InkWell(
            onTap: () async {
              await context.read<CategoryCubit>().saveChanges();
            },
            child: const LightBlueButton(buttonText: 'Save')),
        const LightBlueButton(buttonText: 'Export'),
        InkWell(
            onTap: () => Navigator.pop(context), child: const LightBlueButton(buttonText: 'Exit')),
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
