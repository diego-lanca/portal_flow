import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc({required InvoiceRepository invoiceRepository})
    : _invoiceRepository = invoiceRepository,
      super(const InvoiceState()) {
    on<InvoiceSubscriptionRequested>(_onSubscriptionRequested);
    on<InvoiceFilterChanged>(_onFilterChanged);
    on<InvoiceRefreshRequested>(_onRefreshRequested);
    on<InvoiceSortingChanged>(_onSortingChanged);
    on<InvoiceSearchChanged>(_onSearchChanged);
    on<InvoiceSearchToggled>(_onSearchToggled);
  }

  final InvoiceRepository _invoiceRepository;

  Future<void> _onSubscriptionRequested(
    InvoiceSubscriptionRequested event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(status: InvoiceLoadStatus.loading));

    await emit.forEach<List<Invoice>>(
      _invoiceRepository.streamInvoices(),
      onData: (invoices) => state.copyWith(
        status: InvoiceLoadStatus.success,
        invoices: invoices,
      ),
      onError: (e, _) => state.copyWith(
        status: InvoiceLoadStatus.fail,
      ),
    );
  }

  Future<void> _onFilterChanged(
    InvoiceFilterChanged event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onSortingChanged(
    InvoiceSortingChanged event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(
      state.copyWith(sorting: event.sorting, sortingAsc: event.isAsc),
    );
  }

  Future<void> _onRefreshRequested(
    InvoiceRefreshRequested event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(
      state.copyWith(
        status: InvoiceLoadStatus.loading,
        invoices: [],
      ),
    );

    await emit.forEach<List<Invoice>>(
      _invoiceRepository.streamInvoices(),
      onData: (invoices) => state.copyWith(
        status: InvoiceLoadStatus.success,
        invoices: invoices,
      ),
      onError: (e, _) => state.copyWith(
        status: InvoiceLoadStatus.fail,
      ),
    );
  }

  Future<void> _onSearchChanged(
    InvoiceSearchChanged event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(searchTerm: event.search));
  }

  Future<void> _onSearchToggled(
    InvoiceSearchToggled event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(
      state.copyWith(
        searchOpen: !state.searchOpen,
        searchTerm: state.searchOpen ? '' : state.searchTerm,
      ),
    );
  }
}
