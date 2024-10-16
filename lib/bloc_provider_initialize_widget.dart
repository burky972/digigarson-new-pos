part of './main.dart';

class BlocProviderInitializeWidget extends StatelessWidget {
  const BlocProviderInitializeWidget({super.key, required this.child});
  final EasyLocalization child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // create: (_) => GlobalCubit(),
          create: (_) => AppContainerItems.globalCubit,
        ),
        BlocProvider(
          // create: (context) => CaseCubit(),
          create: (context) => AppContainerItems.caseCubit,
        ),
        BlocProvider(
          // create: (context) => UtilityItemCubit()..init(),
          create: (context) => AppContainerItems.utilityItemCubit..init(),
        ),
        BlocProvider(
          // create: (context) => BranchCubit(),
          create: (context) => AppContainerItems.branchCubit,
        ),
        BlocProvider(
          // create: (context) => OrderCubit(),
          create: (context) => AppContainerItems.orderCubit,
        ),
        BlocProvider(
          // create: (context) => CategoryCubit(),
          create: (context) => AppContainerItems.categoryCubit,
        ),
        BlocProvider(
          // create: (context) => ProductCubit(),
          create: (context) => AppContainerItems.productCubit,
        ),
        BlocProvider(
          // create: (context) => OptionCubit()..init(),
          create: (context) => AppContainerItems.optionCubit..init(),
        ),
        BlocProvider(
          // create: (context) => NoteServePaymentCancelReasonCubit(),
          create: (context) => AppContainerItems.noteCubit,
        ),
        BlocProvider(
          // create: (context) => CheckCubit(),
          create: (context) => AppContainerItems.checkCubit,
        ),
        BlocProvider(
          // create: (context) => TableCubit(),
          create: (context) => AppContainerItems.tableCubit,
        ),
        BlocProvider(
          // create: (context) => PrinterCubit(),
          create: (context) => AppContainerItems.printerCubit,
        ),
        BlocProvider(
          // create: (context) => RestaurantCubit(),
          create: (context) => AppContainerItems.restaurantCubit,
        ),
        BlocProvider(
          // create: (context) => QuickServiceCubit(),
          create: (context) => AppContainerItems.quickServiceCubit,
        ),
        BlocProvider(
          // create: (context) => SectionCubit()..getSections(),
          create: (context) => AppContainerItems.sectionCubit..getSections(),
        ),
      ],
      child: child,
    );
  }
}
