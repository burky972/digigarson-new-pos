import 'package:a_pos_flutter/feature/back_office/menu/view/menu_view.dart';
import 'package:a_pos_flutter/feature/back_office/restaurant/view/restaurant_dialog_view.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/view/table_layout_view.dart';
import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/responsive/paddings.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/button/exit_button.dart';
import 'package:flutter/material.dart';

class BackOfficeLaunchView extends StatelessWidget {
  const BackOfficeLaunchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: context.dynamicWidth(1),
            height: context.dynamicHeight(0.2),
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () => RestaurantDialogView().show(context),
                      child: const _EachTitleContainer(title: 'Restaurant'))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const MenuView())),
                      child: const _EachTitleContainer(title: 'Menu'))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const TableLayoutView())),
                      child: const _EachTitleContainer(title: 'Table Layout'))),
              const Expanded(flex: 1, child: _EachTitleContainer(title: 'Maintenance')),
            ]),
          ),
          SizedBox(
            width: context.dynamicWidth(1),
            height: context.dynamicHeight(0.4),
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: _EachImageContainer(
                      image: Assets.images.onBoarding.onboardingImageTwo.image())),
              Expanded(
                  flex: 1,
                  child: _EachImageContainer(
                      image: Assets.images.onBoarding.onboardingImageTwo.image())),
              Expanded(
                  flex: 1,
                  child: _EachImageContainer(
                      image: Assets.images.onBoarding.onboardingImageTwo.image())),
              Expanded(
                  flex: 1,
                  child: _EachImageContainer(
                      image: Assets.images.onBoarding.onboardingImageTwo.image())),
            ]),
          ),
          SizedBox(
            width: context.dynamicWidth(1),
            height: context.dynamicHeight(0.2),
            child: const Row(children: [
              Expanded(flex: 1, child: _EachTitleContainer(title: 'Employee')),
              Expanded(flex: 1, child: _EachTitleContainer(title: 'Reports')),
              Expanded(flex: 1, child: _EachTitleContainer(title: 'Settings')),
              Expanded(flex: 1, child: _EachTitleContainer(title: 'Member Cards')),
            ]),
          ),
          SizedBox(
            height: context.dynamicHeight(0.02),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExitButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MainView())),
            ),
          ),
        ],
      ),
    );
  }
}

class _EachTitleContainer extends StatelessWidget {
  const _EachTitleContainer({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(6)),
      margin: const AppPadding.extraMinAll(),
      height: context.dynamicHeight(0.1),
      child: Center(
          child: Text(title,
              style: CustomFontStyle.titlesTextStyle
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }
}

class _EachImageContainer extends StatelessWidget {
  const _EachImageContainer({required this.image});
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const AppPadding.extraMinAll(),
        height: context.dynamicHeight(0.4),
        child: Center(child: Assets.images.onBoarding.onboardingImageTwo.image()));
  }
}