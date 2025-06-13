enum InvoiceStatus {
  pending,
  paid,
  overdue;

  factory InvoiceStatus.fromJson(int index) =>
      InvoiceStatus.values.elementAt(index);
}
