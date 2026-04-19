import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KeuzeHoeveelheid {
  
static void hoeveelHeidPopup({
  required BuildContext context,
  required DocumentSnapshot ingredient,
  required Function(int hoeveelheid) onConfirm,
}) {
  final controller = TextEditingController();


  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) {
      return Padding(padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top:16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hoeveel ${ingredient['naam']}?'),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(onPressed: () {
            final hoeveelheid =
            int.tryParse(controller.text) ?? 0;
            onConfirm(hoeveelheid);
            Navigator.pop(context);
          }, child: Text('Toevoegen'))
        ],
      ),
      );
    }
   );
  }
}