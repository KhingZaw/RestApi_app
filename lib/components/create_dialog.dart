import 'package:drivers_app/services/item/item_service.dart';
import 'package:flutter/material.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController cpuModelController = TextEditingController();
  TextEditingController hardDiskSizeController = TextEditingController();

  //declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  Future<void> _fetchData() async {
    await ItemService().getAllItemData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        title: const Text("Create New Item"),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign form key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Item Name"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter item name" : null,
                ),
                TextFormField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: "Year"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter year";
                    if (int.tryParse(value) == null)
                      return "Enter a valid year";
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter price";
                    if (double.tryParse(value) == null) {
                      return "Enter a valid price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: cpuModelController,
                  decoration: const InputDecoration(labelText: "CPU Model"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter CPU model" : null,
                ),
                TextFormField(
                  controller: hardDiskSizeController,
                  decoration:
                      const InputDecoration(labelText: "Hard Disk Size"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter hard disk size"
                      : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Get user input
                String name = nameController.text.trim();
                int year = int.parse(yearController.text.trim());
                double price = double.parse(priceController.text.trim());
                String cpuModel = cpuModelController.text.trim();
                String hardDiskSize = hardDiskSizeController.text.trim();

                var newItem = await ItemService().createItem(
                  name,
                  year,
                  price,
                  cpuModel,
                  hardDiskSize,
                );

                if (newItem != null) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Item Created: ${newItem.name}")),
                  );
                  _fetchData(); // Refresh the list

                  // ✅ Clear inputs after successful submission
                  nameController.clear();
                  yearController.clear();
                  priceController.clear();
                  cpuModelController.clear();
                  hardDiskSizeController.clear();

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}
