import 'package:portal_flow/data/data.dart';

enum InvoiceSorting { status, alphabetic, dueDate }

extension InvoiceSortingX on InvoiceSorting {
  Iterable<Invoice> applyAll(Iterable<Invoice> invoices, {bool isAsc = false}) {
    final list = List<Invoice>.from(invoices);

    switch (this) {
      case InvoiceSorting.alphabetic:
        if (isAsc) {
          list.sort(
            (a, b) => a.fileName.compareTo(b.fileName),
          );
        } else {
          list.sort(
            (a, b) => b.fileName.compareTo(a.fileName),
          );
        }
      case InvoiceSorting.dueDate:
        if (isAsc) {
          list.sort(
            (a, b) => a.dueDate.compareTo(b.dueDate),
          );
        } else {
          list.sort(
            (a, b) => b.dueDate.compareTo(a.dueDate),
          );
        }
      case InvoiceSorting.status:
        if (isAsc) {
          list.sort(
            (a, b) => a.status.compareTo(b.status),
          );
        } else {
          list.sort(
            (a, b) => b.status.compareTo(a.status),
          );
        }
    }

    return list;
  }
}
