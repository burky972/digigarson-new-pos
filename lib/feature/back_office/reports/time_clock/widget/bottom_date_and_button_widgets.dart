part of '../view/time_clock_view.dart';

class _BottomDateAndButtonWidgets extends StatelessWidget {
  const _BottomDateAndButtonWidgets({
    required this.startDateController,
    required this.endDateController,
  });

  final TextEditingController startDateController;
  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.dynamicWidth(0.3),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const FromToTitle(title: 'From'),
                      Expanded(
                        child: SelectDateWidget(
                          startDateController: startDateController,
                          endDateController: endDateController,
                          isStartDay: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Row(
                    children: [
                      const FromToTitle(title: 'To'),
                      Expanded(
                        child: SelectDateWidget(
                          startDateController: startDateController,
                          endDateController: endDateController,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Buttons
          SizedBox(
              width: context.dynamicWidth(0.65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LightBlueButton(
                    buttonText: LocaleKeys.add.tr(),
                    onTap: () async {
                      // final startDate = DateHelper.stringToTimestamp(startDateController.text);
                      // final endDate = DateHelper.stringToTimestamp(endDateController.text);
                      //   await AppContainerItems.reportsCubit.getCategoryReports(ReportsRequestModel(
                      //       startDate: startDate.toString(), endDate: endDate.toString()));
                    },
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.delete.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.edit.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.export.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.printRecord.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.printSummary.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                  LightBlueButton(
                    buttonText: LocaleKeys.exit.tr(),
                    onTap: () => routeManager.pop(),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
