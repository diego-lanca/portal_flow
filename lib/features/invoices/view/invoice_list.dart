import 'dart:convert';
import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/features/invoices/bloc/invoice_bloc.dart';

class InvoiceList extends StatelessWidget {
  const InvoiceList({
    this.invoiceFilter = InvoiceFilter.all,
    this.isSearchable = false,
    super.key,
  });

  final InvoiceFilter invoiceFilter;
  final bool isSearchable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        final invoices = isSearchable
            ? state.filteredSearchInvoices(invoiceFilter)
            : state.filteredInvoices(invoiceFilter);

        if (state.invoices.isEmpty) {
          if (state.status == InvoiceLoadStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state.status != InvoiceLoadStatus.success) {
            return const Text('Ocorreu um erro ao carregar os boletos.');
          }

          return const Center(
            child: Text(
              'Nenhum boleto encontrado.',
            ),
          );
        }

        return CupertinoScrollbar(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 12),
            child: ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices.elementAt(index);

                return Padding(
                  padding: const EdgeInsetsGeometry.symmetric(vertical: 8),
                  child: _InvoiceCard(invoice: invoice),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  _InvoiceCard({required this.invoice});

  final format = DateFormat('dd/MM/yyyy');
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final daysToOverdue = invoice.dueDate.day - DateTime.now().day;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        spacing: 12,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.surfaceBright,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        LucideIcons.scrollText500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoice.fileName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (invoice.status != InvoiceStatus.paid)
                          if (daysToOverdue > 0)
                            Text(
                              'Vence em $daysToOverdue dias',
                              style: const TextStyle(fontSize: 16),
                            )
                          else if (daysToOverdue == 0)
                            const Text(
                              'Vence hoje',
                              style: TextStyle(fontSize: 16),
                            )
                          else
                            Text(
                              'Venceu hà ${-daysToOverdue} dias',
                              style: const TextStyle(fontSize: 16),
                            )
                        else
                          const Text(
                            'Finalizado',
                            style: TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ],
                ),
                _statusChip(invoice.status),
              ],
            ),
          ),
          Accordion(
            paddingListTop: 0,
            paddingListBottom: 0,
            paddingListHorizontal: 0,
            paddingBetweenClosedSections: 0,
            paddingBetweenOpenSections: 0,

            disableScrolling: true,

            children: [
              AccordionSection(
                header: Padding(
                  padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text('Conta: '),
                      ),
                      Text(invoice.customerAccount),
                    ],
                  ),
                ),

                headerBorderRadius: 12,
                headerBackgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainer,
                contentBackgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainer,
                contentBorderColor: Colors.transparent,
                rightIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),

                content: _InvoiceAccordionContent(invoice: invoice),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.pending:
        return Container(
          decoration: BoxDecoration(
            color: Colors.yellowAccent.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            child: Text(
              'Pendente',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        );
      case InvoiceStatus.paid:
        return Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            child: Text(
              'Pago',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        );
      case InvoiceStatus.overdue:
        return Container(
          decoration: BoxDecoration(
            color: Colors.redAccent.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            child: Text(
              'Vencido',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        );
    }
  }
}

class _InvoiceAccordionContent extends StatelessWidget {
  const _InvoiceAccordionContent({required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd/MM/yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nome: ${invoice.fileName}'),
        Text(
          'Vencimento: ${format.format(invoice.dueDate)}',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final path = await _createFileFromString(invoice.bill);

                await OpenFilex.open(path);
              },
              label: const Text('Baixar'),
              icon: const Icon(LucideIcons.download),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> _createFileFromString(String encoded) async {
    final bytes = base64.decode(encoded);
    final dir = (await getApplicationDocumentsDirectory()).path;

    final file = File('$dir/${DateTime.now().millisecondsSinceEpoch}.pdf');

    await file.writeAsBytes(bytes);

    return file.path;
  }
}
