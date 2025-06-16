import 'package:flutter/material.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/http.dart';

class InvoiceRepository {
  InvoiceRepository();

  Stream<List<Invoice>> streamInvoices() async* {
    yield* Stream<List<Invoice>>.fromFuture(_getInvoices());
  }
}

Future<List<Invoice>> _getInvoices() async {
  try {
    final response = await dio.get<List<dynamic>>('invoice/client');

    if (response.data != null) {
      final invoices = response.data!.map(
        (i) => Invoice.fromJson(i as Map<String, dynamic>),
      ).toList();

      return invoices;
    }

    return [];
  } on Exception catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}
