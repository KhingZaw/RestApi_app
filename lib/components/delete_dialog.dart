import 'package:drivers_app/services/item/item_service.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final String itemId;
  const DeleteDialog({super.key, required this.itemId});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  Future<void> _fetchData() async {
    await ItemService().getAllItemData();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Item"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            bool isDeleted = await ItemService().deleteItem(widget.itemId);
            if (isDeleted) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item deleted successfully")),
              );
              _fetchData(); // Refresh the list
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to delete item")),
              );
            }
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
