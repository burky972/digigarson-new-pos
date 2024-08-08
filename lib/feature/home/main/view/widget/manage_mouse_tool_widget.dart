// part of '../main_view.dart';

// class _ManageMouseToolWidget extends StatefulWidget {
//   final TableItem table;
//   final VoidCallback onTap;

//   const _ManageMouseToolWidget({
//     required this.table,
//     required this.onTap,
//   });

//   @override
//   State<_ManageMouseToolWidget> createState() => __ManageMouseToolWidgetState();
// }

// class __ManageMouseToolWidgetState extends State<_ManageMouseToolWidget> {
//   OverlayEntry? _overlayEntry;

//   void _showOverlay(BuildContext context) {
//     final overlay = Overlay.of(context);
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         left: widget.table.position.dx + 20,
//         top: widget.table.position.dy + 20,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const AppPadding.minAll(),
//             decoration: BoxDecoration(
//               color: context.colorScheme.primary,
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Total amount: 24',
//                     style: CustomFontStyle.titlesTextStyle
//                         .copyWith(color: context.colorScheme.surface)),
//                 const SizedBox(height: 4.0),
//                 BlocSelector<TableCubit, TableState, DateTime?>(
//                   selector: (state) {
//                     return state.tableModel.first.lastOrderDate;
//                   },
//                   builder: (context, lastOrderDate) {
//                     return lastOrderDate != null
//                         ? TimerWidget(
//                             lastOrderTime: lastOrderDate,
//                             color: context.colorScheme.surface,
//                           )
//                         : const SizedBox();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     overlay.insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   Future<void> _handleTap() async {
//     context.read<GlobalCubit>().setSelectedTableName(widget.table.name.toString());
//     await context
//         .read<TableCubit>()
//         .setSelectedTable(context.read<TableCubit>().tableModel[widget.table.id]);

//     debugPrint(widget.table.name.toString() + widget.table.id.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (event) => _showOverlay(context),
//       onExit: (event) => _removeOverlay(),
//       child: InkWell(
//         onTap: widget.table.id > 44 ? null : _handleTap,
//         child: DecoratedBox(
//             //TODO! ADD LATER if isOpen color.green : colors.red
//             decoration: BoxDecoration(
//                 color: widget.table.id > 44 ? null : Colors.green,
//                 borderRadius: BorderRadius.circular(12)),
//             child: widget.table.buildTable()),
//       ),
//     );
//   }
// }
