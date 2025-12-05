// lib/widgets/modal_helper.dart
import 'package:flutter/material.dart';

class ModalHelper {
  static Future<T?> showFormModal<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
            child: SingleChildScrollView(controller: controller, child: Padding(padding: const EdgeInsets.all(16.0), child: child)),
          );
        },
      ),
    );
  }
}
