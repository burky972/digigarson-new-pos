part of './main.dart';

class BlocProviderInitializeWidget extends StatelessWidget {
  const BlocProviderInitializeWidget({super.key, required this.child});
  final EasyLocalization child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppContainerItems.globalCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.caseCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.utilityItemCubit..init(),
        ),
        BlocProvider(
          create: (context) => AppContainerItems.branchCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.orderCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.categoryCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.productCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.optionCubit..init(),
        ),
        BlocProvider(
          create: (context) => AppContainerItems.noteCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.checkCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.tableCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.printerCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.restaurantCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.expenseCubit..init(),
        ),
        BlocProvider(
          create: (context) => AppContainerItems.quickServiceCubit,
        ),
        BlocProvider(
          create: (context) => AppContainerItems.sectionCubit..getSections(),
        ),
        BlocProvider(
          create: (context) => AppContainerItems.reportsCubit..init(),
        ),
        BlocProvider(
          create: (context) => AppContainerItems.rolesCubit..init(),
        ),
        BlocProvider(
          create: (context) => AppContainerItems.employeeCubit..init(),
        ),
      ],
      child: child,
    );
  }
}
