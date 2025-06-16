enum InvoiceStatus {
  pending,
  paid,
  overdue;

  factory InvoiceStatus.fromJson(int index) =>
      InvoiceStatus.values.elementAt(index);

  int compareTo(InvoiceStatus other) => index > other.index ? 1 : -1;
}
