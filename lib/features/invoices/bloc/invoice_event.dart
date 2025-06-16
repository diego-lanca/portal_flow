part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

final class InvoiceSubscriptionRequested extends InvoiceEvent {
  const InvoiceSubscriptionRequested();
}

final class InvoiceSortingChanged extends InvoiceEvent {
  const InvoiceSortingChanged(this.sorting, {this.isAsc = false});

  final InvoiceSorting sorting;
  final bool isAsc;

  @override
  List<Object> get props => [sorting, isAsc];
}

final class InvoiceFilterChanged extends InvoiceEvent {
  const InvoiceFilterChanged(this.filter);

  final InvoiceFilter filter;

  @override
  List<Object> get props => [filter];
}

final class InvoiceRefreshRequested extends InvoiceEvent {
  const InvoiceRefreshRequested();
}

final class InvoiceSearchChanged extends InvoiceEvent {
  const InvoiceSearchChanged(this.search);

  final String search;

  @override
  List<Object> get props => [search];
}

final class InvoiceSearchToggled extends InvoiceEvent {
  const InvoiceSearchToggled();
}
