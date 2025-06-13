part of 'invoice_bloc.dart';

enum InvoiceLoadStatus { initial, loading, success, fail }

final class InvoiceState extends Equatable {
  const InvoiceState({
    this.status = InvoiceLoadStatus.initial,
    this.invoices = const [],
    this.sorting = InvoiceSorting.dueDateDesc,
  });

  final InvoiceLoadStatus status;
  final List<Invoice> invoices;
  final InvoiceSorting sorting;

  Iterable<Invoice> get pendingInvoices =>
      invoices.where((i) => i.status == InvoiceStatus.pending);

  Iterable<Invoice> filteredInvoices(InvoiceFilter filter) =>
      filter.applyAll(invoices);

  InvoiceState copyWith({
    InvoiceLoadStatus Function()? status,
    List<Invoice> Function()? invoices,
    InvoiceSorting Function()? sorting,
  }) {
    return InvoiceState(
      status: status != null ? status() : this.status,
      invoices: invoices != null ? invoices() : this.invoices,
      sorting: sorting != null ? sorting() : this.sorting,
    );
  }

  @override
  List<Object> get props => [status, invoices, sorting];
}
