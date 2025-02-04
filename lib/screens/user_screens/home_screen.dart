import 'package:drivers_app/components/create_dialog.dart';
import 'package:drivers_app/components/delete_dialog.dart';
import 'package:drivers_app/screens/user_screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivers_app/models/item_model.dart';
import 'package:drivers_app/services/item/item_service.dart';
import 'package:drivers_app/components/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ItemModel>> _itemsFuture;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Load initial data
  }

  Future<void> _fetchData() async {
    setState(() {
      _isRefreshing = true;
    });

    _itemsFuture = ItemService().getAllItemData();

    // Wait for the future to complete and then stop loading
    _itemsFuture.whenComplete(() {
      setState(() {
        _isRefreshing = false; // Stop loading after fetch
      });
    });
  }

  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => SettingsScreen(),
      ),
    );
  }

  void _showCreateItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDialog();
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteDialog(
          itemId: itemId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _showCreateItemDialog(context);
              },
              icon: Icon(Icons.add_circle_outline))
        ],
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !_isRefreshing) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Show loading while waiting for data
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No items found"));
          }

          var data = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _fetchData, // Allow pull-to-refresh
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: ListTile(
                        title: Text(
                          data[index].name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        subtitle: data[index].data != null
                            ? Row(
                                children: [
                                  Text(
                                    data[index].data!.color,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data[index].data!.capacity,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "No data available",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                        trailing: IconButton(
                          onPressed: () =>
                              _showDeleteConfirmation(context, data[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
