import 'package:flutter/material.dart';

enum AlertType {
  emergencyAlert,
  efficiencyDropAlert,
  productionDelayAlert,
  machineFailure,
}

enum RecipientType {
  managersAndSupervisors,
  technicians,
  everyone,
}

class NotificationProvider extends ChangeNotifier {
  bool isReceived = true; // Toggle between received and send views
  AlertType? selectedAlertType;
  RecipientType? selectedRecipient;
  int? selectedWorkshop;
  int? selectedChaine;

  // List of received notifications
  final List<Map<String, dynamic>> receivedNotifications = [
    {
      "senderImage": "assets/images/smith.png",
      "alertType": "Emergency Alert",
      "workshop": 1,
      "chaine": 2,
      "date": "29 mar",
    },
    {
      "senderImage": "assets/images/harry.png",
      "alertType": "Efficiency drop Alert",
      "workshop": 1,
      "chaine": 2,
      "date": "12 mar",
    },
    {
      "senderImage": "assets/images/monica.png",
      "alertType": "Production delay Alert",
      "workshop": 1,
      "chaine": 2,
      "date": "12 mar",
    },
  ];

  void toggleView() {
    isReceived = !isReceived;
    notifyListeners();
  }

  void setAlertType(AlertType type) {
    selectedAlertType = type;
    // Reset recipient if not compatible with alert type
    if (type == AlertType.efficiencyDropAlert || type == AlertType.productionDelayAlert) {
      selectedRecipient = RecipientType.managersAndSupervisors;
    } else if (type == AlertType.machineFailure) {
      selectedRecipient = RecipientType.technicians;
    }
    notifyListeners();
  }

  void setRecipient(RecipientType type) {
    if (canSelectRecipient(type)) {
      selectedRecipient = type;
      notifyListeners();
    }
  }

  void setWorkshop(int number) {
    selectedWorkshop = number;
    notifyListeners();
  }

  void setChaine(int number) {
    selectedChaine = number;
    notifyListeners();
  }

  bool canSelectRecipient(RecipientType type) {
    if (selectedAlertType == AlertType.emergencyAlert) {
      return true;
    } else if ((selectedAlertType == AlertType.efficiencyDropAlert || 
                selectedAlertType == AlertType.productionDelayAlert) &&
               type == RecipientType.managersAndSupervisors) {
      return true;
    } else if (selectedAlertType == AlertType.machineFailure && 
               type == RecipientType.technicians) {
      return true;
    }
    return false;
  }

  void sendNotification() {
    // Implement sending notification logic here
    // Reset form after sending
    selectedAlertType = null;
    selectedRecipient = null;
    selectedWorkshop = null;
    selectedChaine = null;
    notifyListeners();
  }
} 