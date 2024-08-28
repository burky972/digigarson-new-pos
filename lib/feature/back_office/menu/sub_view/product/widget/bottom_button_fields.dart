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
        LightBlueButton(
          buttonText: 'Add',
          onTap: () => context
              .read<ProductCubit>()
              .addNewProduct(context.read<CategoryCubit>().selectedCategory!.id!),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: context.read<ProductCubit>().state.selectedProduct == null
              ? null
              : () async => await context
                  .read<ProductCubit>()
                  .patchProducts(productId: context.read<ProductCubit>().state.selectedProduct!.id!)
                  .whenComplete(() => context.read<ProductCubit>().getProducts()),
        ),
        LightBlueButton(
          buttonText: 'Save',
          onTap: () async => await context
              .read<ProductCubit>()
              .saveChanges()
              .then((value) => context.read<ProductCubit>().getProducts()),
        ),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
