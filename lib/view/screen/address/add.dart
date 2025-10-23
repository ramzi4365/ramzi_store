import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/addressController.dart';

class AddressAdd extends StatelessWidget {
  AddressAdd({super.key});

  final AddressControllerImp controller = Get.put(AddressControllerImp());


  // Validation methods (moved from controller to UI)


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formState,
          child: Column(
            children: [
              // Address Name Field
              TextFormField(
                controller: controller.addressNameController,
                decoration: const InputDecoration(
                  labelText: 'Address Name (e.g., Home, Office, etc.)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a name for this address',
                ),
                validator: controller.validateAddressName,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: controller.validatePhone,
              ),
              const SizedBox(height: 16),

              // City Field
              TextFormField(
                controller: controller.cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: controller.validateCity,
              ),
              const SizedBox(height: 16),

              // Street Field
              TextFormField(
                controller: controller.streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
                validator: controller.validateStreet,
              ),
              const SizedBox(height: 16),

              // Additional Details Field
              TextFormField(
                controller: controller.detailsController,
                decoration: const InputDecoration(
                  labelText: 'Additional Details (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'Any additional location details',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: controller.saveAddress,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}