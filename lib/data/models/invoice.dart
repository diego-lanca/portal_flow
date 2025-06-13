import 'package:equatable/equatable.dart';
import 'package:portal_flow/core/core.dart';

class Invoice extends Equatable {
  const Invoice({
    this.id = 0,
    this.customerAccount = '',
    this.reference,
    this.fileName = '',
    this.bankSlip,
    this.bill = '',
    this.dueDate,
    this.status = InvoiceStatus.pending,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as int,
      customerAccount: json['customerAccount'] as String,
      reference: json['reference'] as String?,
      fileName: json['fileName'] as String,
      bankSlip: json['bankSlip'] as String?,
      bill: json['bill'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: InvoiceStatus.fromJson(json['status'] as int),
    );
  }

  final int id;
  final String customerAccount;
  final String? reference;
  final String fileName;
  final String? bankSlip; // Base64
  final String bill; // Base64
  final DateTime? dueDate;
  final InvoiceStatus status;

  @override
  List<Object?> get props => [
    id,
    customerAccount,
    reference,
    fileName,
    bankSlip,
    bill,
    dueDate,
    status,
  ];
}
