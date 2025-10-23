import 'package:ramzi_store/core/class/statusRequest.dart';

handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else if (response is Map) {
    // Check if the response contains a status field
    if (response.containsKey('status')) {
      if (response['status'] == 'success') {
        return StatusRequest.success;
      } else if (response['status'] == 'failure') {
        return StatusRequest.failure;
      }
    }
    // If no status field, assume success for backward compatibility
    return StatusRequest.success;
  } else {
    return StatusRequest.serverfailure;
  }
}