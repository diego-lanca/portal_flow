part of 'invoice_bloc.dart';

enum InvoiceLoadStatus { initial, loading, success, fail }

final class InvoiceState extends Equatable {
  const InvoiceState({
    this.status = InvoiceLoadStatus.initial,
    this.invoices = const [],
    this.sorting = InvoiceSorting.status,
    this.sortingAsc = true,
    this.filter = InvoiceFilter.all,
    this.searchTerm = '',
    this.searchOpen = false,
  });

  final InvoiceLoadStatus status;
  final List<Invoice> invoices;
  final InvoiceSorting sorting;
  final InvoiceFilter filter;
  final bool sortingAsc;
  final String searchTerm;
  final bool searchOpen;

  Iterable<Invoice> get pendingInvoices =>
      invoices.where((i) => i.status == InvoiceStatus.pending);

  Iterable<Invoice> get overdueInvoices =>
      invoices.where((i) => i.status == InvoiceStatus.overdue);

  Iterable<Invoice> get paidInvoices =>
      invoices.where((i) => i.status == InvoiceStatus.paid);

  Iterable<Invoice> filteredSearchInvoices(InvoiceFilter filter) {
    final invoices = filter
        .applyAll(this.invoices)
        .where(
          (i) => i.fileName.toLowerCase().contains(searchTerm.toLowerCase()),
        );

    return sorting.applyAll(invoices, isAsc: sortingAsc);
  }

  Iterable<Invoice> filteredInvoices(InvoiceFilter filter) {
    final invoices = filter.applyAll(this.invoices);

    return sorting.applyAll(invoices, isAsc: sortingAsc);
  }

  InvoiceState copyWith({
    InvoiceLoadStatus? status,
    List<Invoice>? invoices,
    InvoiceSorting? sorting,
    InvoiceFilter? filter,
    bool? sortingAsc,
    String? searchTerm,
    bool? searchOpen,
  }) {
    return InvoiceState(
      status: status ?? this.status,
      invoices: invoices ?? this.invoices,
      sorting: sorting ?? this.sorting,
      filter: filter ?? this.filter,
      sortingAsc: sortingAsc ?? this.sortingAsc,
      searchTerm: searchTerm ?? this.searchTerm,
      searchOpen: searchOpen ?? this.searchOpen,
    );
  }

  int get totalInvoices => invoices.length;
  int get pendingCount => pendingInvoices.length;
  int get overdueCount => overdueInvoices.length;
  int get paidCount => paidInvoices.length;

  bool get hasActiveSearch => searchTerm.isNotEmpty;

  @override
  List<Object> get props => [
    status,
    invoices,
    sorting,
    filter,
    sortingAsc,
    searchTerm,
    searchOpen,
  ];
}
