part of '../view/product_view.dart';

class _BottomButtonFields extends StatelessWidget {
  const _BottomButtonFields();

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = context.read<ProductCubit>();
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
          onTap: () =>
              productCubit.addNewProduct(context.read<CategoryCubit>().selectedSubCategory!.id!),
        ),
        LightBlueButton(
          buttonText: 'Delete',
          onTap: context.read<ProductCubit>().state.selectedProduct == null
              ? null
              : () async => await context
                  .read<ProductCubit>()
                  .patchProducts(productId: productCubit.state.selectedProduct!.id!)
                  .whenComplete(() => productCubit.getProducts()),
        ),
        LightBlueButton(
          buttonText: 'Save',
          onTap: () async => await context
              .read<ProductCubit>()
              .saveChanges()
              .then((value) => productCubit.getProducts()),
        ),
        const LightBlueButton(buttonText: 'Export'),
        LightBlueButton(
          buttonText: 'Exit',
          onTap: () => routeManager.pop(),
        ),
      ],
    );
  }
}
