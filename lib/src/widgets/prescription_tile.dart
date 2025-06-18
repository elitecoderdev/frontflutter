import 'package:flutter/material.dart';
import '../models/prescription.dart';

class PrescriptionTile extends StatelessWidget {
  final Prescription p;
  const PrescriptionTile(this.p, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext c) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(p.medication),
        subtitle: Text('Emitida: ${p.issuedAt} por ${p.doctor}'),
      ),
    );
  }
}
