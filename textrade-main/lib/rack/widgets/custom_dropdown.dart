import 'package:flutter/material.dart';
import 'package:textrade/rack/model/rack_model.dart';

void showCustomDropdown({
  required BuildContext context,
  required Offset position,
  required List<RackTable> items,
  required Function(RackTable) onSelected,
}) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final RelativeRect positionRect = RelativeRect.fromRect(
    Rect.fromPoints(
      position,
      position.translate(overlay.size.width, 48),
    ),
    Offset.zero & overlay.size,
  );

  showMenu<RackTable>(
    context: context,
    position: positionRect,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    items: items.map((RackTable item) {
      return PopupMenuItem<RackTable>(
        value: item,
        child: Container(
          constraints: const BoxConstraints(minWidth: 200),
          child: Text(
            item.rACKNAME ?? '',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }).toList(),
  ).then((RackTable? selected) {
    if (selected != null) {
      onSelected(selected);
    }
  });
}
