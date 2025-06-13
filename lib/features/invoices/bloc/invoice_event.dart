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
  const InvoiceSortingChanged(this.sorting);

  final InvoiceSorting sorting;
}
