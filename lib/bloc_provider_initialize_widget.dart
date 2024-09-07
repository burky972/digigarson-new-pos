part of './main.dart';

class BlocProviderInitializeWidget extends StatelessWidget {
  const BlocProviderInitializeWidget({super.key, required this.child});
  final EasyLocalization child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GlobalCubit(),
        ),
        BlocProvider(
          create: (context) => CaseCubit(),
        ),
        BlocProvider(
          create: (context) => UtilityItemCubit()..init(),
        ),
        BlocProvider(
          create: (context) => BranchCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => OptionCubit()..init(),
        ),
        BlocProvider(
          create: (context) => NoteServePaymentCancelReasonCubit(),
        ),
        BlocProvider(
          create: (context) => CheckCubit(),
        ),
        BlocProvider(
          create: (context) => TableCubit(),
        ),
        BlocProvider(
          create: (context) => PrinterCubit(),
        ),
        BlocProvider(
          create: (context) => RestaurantCubit(),
        ),
        BlocProvider(
          create: (context) => SectionCubit()..getSections(),
        ),
      ],
      child: child,
    );
  }
}
