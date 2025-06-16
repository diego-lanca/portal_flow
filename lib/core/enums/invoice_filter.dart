import 'package:portal_flow/core/enums/invoice_status.dart';
import 'package:portal_flow/data/data.dart';

enum InvoiceFilter {
  all,
  pendings,
  paids,
  overdues;

  String get name {
    switch (this) {
      case InvoiceFilter.all:
        return 'Todos';
      case InvoiceFilter.pendings:
        return 'Pendentes';
      case InvoiceFilter.paids:
        return 'Pagos';
      case InvoiceFilter.overdues:
        return 'Vencidos';
    }
  }
}

extension InvoiceFilterX on InvoiceFilter {
  bool apply(Invoice invoice) {
    switch (this) {
      case InvoiceFilter.all:
        return true;
      case InvoiceFilter.pendings:
        return invoice.status == InvoiceStatus.pending;
      case InvoiceFilter.paids:
        return invoice.status == InvoiceStatus.paid;
      case InvoiceFilter.overdues:
        return invoice.status == InvoiceStatus.overdue;
    }
  }

  Iterable<Invoice> applyAll(Iterable<Invoice> invoices) {
    return invoices.where(apply);
  }
}
