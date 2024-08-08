part of '../view/product_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TextField()),
        const LightBlueButton(buttonText: 'Upload'),
        const LightBlueButton(buttonText: 'inventory'),
        const Spacer(),
        const LightBlueButton(buttonText: 'Move Up'),
        const LightBlueButton(buttonText: 'Move Down'),
        InkWell(
            onTap: () {
              context
                  .read<ProductCubit>()
                  .addNewProduct(context.read<CategoryCubit>().selectedCategory!.id!);
            },
            child: const LightBlueButton(buttonText: 'Add')),
        InkWell(
            onTap: context.read<ProductCubit>().state.selectedProduct == null
                ? null
                : () async => await context
                    .read<ProductCubit>()
                    .patchProducts(
                        productId: context.read<ProductCubit>().state.selectedProduct!.id!)
                    .whenComplete(() => context.read<ProductCubit>().getProducts()),
            child: const LightBlueButton(buttonText: 'Delete')),
        InkWell(
            onTap: () => context.read<ProductCubit>().saveChanges(),
            child: const LightBlueButton(buttonText: 'Save')),
        const LightBlueButton(buttonText: 'Export'),
        InkWell(
            onTap: () => Navigator.pop(context), child: const LightBlueButton(buttonText: 'Exit')),
      ],
    );
  }
}
