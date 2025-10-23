import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ramzi_store/view/screen/address/add.dart';

import '../../../controller/addressController.dart';

class AddressView extends StatelessWidget {
  AddressView({super.key});

  final AddressControllerImp controller = Get.put(AddressControllerImp());

  void _addNewAddress() async {
    Get.to(() => AddressAdd());
  }

  void _removeAddress(String addressId) {
    controller.deleteAddress(addressId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addresses"),
        centerTitle: true,
      ),
      body: GetBuilder<AddressControllerImp>(
        builder: (controller) {
          return controller.addresses.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  "No addresses added yet",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap the + button to add your first address",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.blue),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Name as headline
                      Text(
                        address.addressName ?? 'Unnamed Address',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Full address
                      Text(
                        '${address.addressCity}, ${address.addressStreet}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      // Phone number
                      if (address.addressPhonenumber != null && address.addressPhonenumber!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                address.addressPhonenumber!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  subtitle: address.addressDetails != null && address.addressDetails!.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      address.addressDetails!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeAddress(address.addressId.toString()),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addNewAddress,
      ),
    );
  }
}