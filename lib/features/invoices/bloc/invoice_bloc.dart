import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/data/repositories/invoice_repository.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

enum InvoiceSorting { alphabeticAsc, alphabeticDesc, dueDateAsc, dueDateDesc }

enum InvoiceFilter { all, pendings, paids, overdues }

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

// extension InvoiceSortingX on InvoiceSorting {
//   bool apply(Invoice invoice) {
//     switch (this) {
//       case InvoiceSorting.alphabeticAsc:
//         return
//     }
//   }
// }

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc({required InvoiceRepository invoiceRepository})
    : _invoiceRepository = invoiceRepository,
      super(const InvoiceState()) {
    on<InvoiceSubscriptionRequested>(_onSubscriptionRequested);
  }

  final InvoiceRepository _invoiceRepository;

  Future<void> _onSubscriptionRequested(
    InvoiceSubscriptionRequested event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(status: () => InvoiceLoadStatus.loading));

    await emit.forEach<List<Invoice>>(
      _invoiceRepository.streamInvoices(),
      onData: (invoices) => state.copyWith(
        status: () => InvoiceLoadStatus.success,
        invoices: () => invoices,
      ),
      onError: (e, _) => state.copyWith(
        status: () => InvoiceLoadStatus.fail,
      ),
    );
  }
}
