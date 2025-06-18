class Prescription {
  final String id, patientId, medication, issuedAt, doctor, notes;
  Prescription({
    required this.id,
    required this.patientId,
    required this.medication,
    required this.issuedAt,
    required this.doctor,
    required this.notes,
  });
  factory Prescription.fromJson(Map<String, dynamic> j) => Prescription(
    id: j['id'],
    patientId: j['patientId'],
    medication: j['medication'],
    issuedAt: j['issuedAt'],
    doctor: j['doctor'],
    notes: j['notes'],
  );
}
