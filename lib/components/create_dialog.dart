import 'package:drivers_app/services/item/item_service.dart';
import 'package:drivers_app/models/item_model.dart';
import 'package:flutter/material.dart';

class CreateDialog extends StatefulWidget {
  final bool isEdit;
  final ItemModel? item;

  const CreateDialog({super.key, this.isEdit = false, this.item});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController cpuModelController = TextEditingController();
  TextEditingController hardDiskSizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.item != null) {
      print("DEBUG - Item Data: ${widget.item!.data}");

      nameController.text = widget.item!.name;

      if (widget.item!.data != null) {
        ItemData itemData = widget.item!.data!; // Use as an object, not a map

        yearController.text = itemData.year?.toString() ?? "";
        priceController.text = itemData.price?.toString() ?? "";
        cpuModelController.text = itemData.cpuModel;
        hardDiskSizeController.text = itemData.hardDiskSize;
        colorController.text = itemData.color;
      }
    }
  }

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
        title: Text(widget.isEdit ? "Update Item" : "Create New Item"),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    if (int.tryParse(value) == null) {
                      return "Enter a valid year";
                    }
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
                TextFormField(
                  controller: colorController,
                  decoration: const InputDecoration(labelText: "Color"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter color" : null,
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
                String name = nameController.text.trim();
                int year = int.parse(yearController.text.trim());
                double price = double.parse(priceController.text.trim());
                String cpuModel = cpuModelController.text.trim();
                String hardDiskSize = hardDiskSizeController.text.trim();
                String color = colorController.text.trim();

                if (widget.isEdit && widget.item != null) {
                  try {
                    // Update Item
                    var updatedItem = await ItemService().updateItem(
                      widget.item!.id,
                      name,
                      year,
                      price,
                      cpuModel,
                      hardDiskSize,
                      color,
                    );

                    if (updatedItem != null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Item Updated: ${updatedItem.name}")),
                      );
                      Navigator.pop(context); // Close the dialog
                    }
                  } catch (e) {
                    // Handle error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Update Failed: ${e.toString()}")),
                    );
                  }
                } else {
                  try {
                    // Create New Item
                    var newItem = await ItemService().createItem(
                      name,
                      year,
                      price,
                      cpuModel,
                      hardDiskSize,
                      color,
                    );

                    if (newItem != null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Item Created: ${newItem.name}")),
                      );
                      Navigator.pop(context); // Close the dialog
                    }
                  } catch (e) {
                    // Handle error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Creation Failed: ${e.toString()}")),
                    );
                  }
                }

                _fetchData();

                nameController.clear();
                yearController.clear();
                priceController.clear();
                cpuModelController.clear();
                hardDiskSizeController.clear();
                colorController.clear();

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: Text(widget.isEdit ? "Update" : "Create"),
          ),
        ],
      ),
    );
  }
}
