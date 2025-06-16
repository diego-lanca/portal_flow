import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/features/invoices/invoices.dart';
import 'package:portal_flow/features/main/cubit/main_cubit.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceBright,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: BlocBuilder<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<InvoiceBloc>().add(
                  const InvoiceRefreshRequested(),
                );
              },
              child: Column(
                spacing: 16,
                children: [
                  _InvoiceHeader(state),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InvoicesInfoCard(
                        invoiceCount: state.overdueCount,
                        cardIcon: LucideIcons.triangleAlert,
                        cardTitle: 'Vencidos',
                      ),
                      _InvoicesInfoCard(
                        invoiceCount: state.pendingCount,
                        cardIcon: LucideIcons.clock4,
                        cardTitle: 'A vencer',
                      ),
                    ],
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsetsGeometry.only(left: 12),
                      child: Row(
                        spacing: 8,
                        children: List<ChoiceChip>.generate(4, (int index) {
                          return ChoiceChip(
                            selected:
                                index ==
                                InvoiceFilter.values.indexOf(
                                  state.filter,
                                ),

                            selectedColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,

                            labelStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontSize: 16,
                            ),

                            label: Text(
                              InvoiceFilter.values[index].name,
                            ),

                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(16),
                              ),
                            ),

                            onSelected: (_) => {
                              context.read<InvoiceBloc>().add(
                                InvoiceFilterChanged(
                                  InvoiceFilter.values[index],
                                ),
                              ),
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Expanded(
                    child: InvoiceList(
                      invoiceFilter: state.filter,
                      isSearchable: true,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InvoiceHeader extends StatelessWidget {
  const _InvoiceHeader(this.state);

  final InvoiceState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<InvoiceBloc>().add(
                  const InvoiceSearchChanged(''),
                );
                context.read<InvoiceBloc>().add(
                  const InvoiceSearchToggled(),
                );
                context.read<MainCubit>().setTab(MainTab.home);
              },
              icon: const Icon(LucideIcons.arrowLeft),
            ),

            if (!state.searchOpen) ...[
              const SizedBox(width: 4),

              const Expanded(
                child: Text(
                  'Boletos',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ] else ...[
              Expanded(
                child: TextField(
                  onChanged: (value) => context.read<InvoiceBloc>().add(
                    InvoiceSearchChanged(value),
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],

            // Botão de Pesquisa
            IconButton(
              onPressed: () {
                context.read<InvoiceBloc>().add(const InvoiceSearchToggled());
              },
              icon: Icon(
                LucideIcons.search,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface,
              ),
              tooltip: 'Procurar',
            ),

            // Botão de Filtro
            PopupMenuButton(
              onSelected: (value) {
                debugPrint(value.toString());
              },
              itemBuilder: (context) {
                final selectedColor = Theme.of(
                  context,
                ).colorScheme.primaryContainer;
                final unselectedColor = Theme.of(
                  context,
                ).colorScheme.surfaceContainer;

                return [
                  PopupMenuItem<Widget>(
                    padding: EdgeInsets.zero,
                    onTap: () {
                      bool isAsc;

                      if (state.sorting == InvoiceSorting.status) {
                        isAsc = !state.sortingAsc;
                      } else {
                        isAsc = true;
                      }

                      context.read<InvoiceBloc>().add(
                        InvoiceSortingChanged(
                          InvoiceSorting.status,
                          isAsc: isAsc,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: state.sorting == InvoiceSorting.status
                            ? selectedColor
                            : unselectedColor,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Row(
                              spacing: 4,
                              children: [
                                Icon(LucideIcons.letterText),
                                Text('Status'),
                              ],
                            ),
                          ),
                          if (state.sorting == InvoiceSorting.status)
                            Icon(
                              state.sortingAsc
                                  ? LucideIcons.arrowDownNarrowWide
                                  : LucideIcons.arrowDownWideNarrow,
                            ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<Widget>(
                    padding: EdgeInsets.zero,
                    onTap: () {
                      bool isAsc;

                      if (state.sorting == InvoiceSorting.dueDate) {
                        isAsc = !state.sortingAsc;
                      } else {
                        isAsc = true;
                      }

                      context.read<InvoiceBloc>().add(
                        InvoiceSortingChanged(
                          InvoiceSorting.dueDate,
                          isAsc: isAsc,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: state.sorting == InvoiceSorting.dueDate
                            ? selectedColor
                            : unselectedColor,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Row(
                              spacing: 4,
                              children: [
                                Icon(LucideIcons.calendar),
                                Text('Data de Vencimento'),
                              ],
                            ),
                          ),
                          if (state.sorting == InvoiceSorting.dueDate)
                            Icon(
                              state.sortingAsc
                                  ? LucideIcons.arrowDownNarrowWide
                                  : LucideIcons.arrowDownWideNarrow,
                            ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<Widget>(
                    padding: EdgeInsets.zero,
                    onTap: () {
                      bool isAsc;

                      if (state.sorting == InvoiceSorting.alphabetic) {
                        isAsc = !state.sortingAsc;
                      } else {
                        isAsc = true;
                      }

                      context.read<InvoiceBloc>().add(
                        InvoiceSortingChanged(
                          InvoiceSorting.alphabetic,
                          isAsc: isAsc,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: state.sorting == InvoiceSorting.alphabetic
                            ? selectedColor
                            : unselectedColor,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Row(
                              spacing: 4,
                              children: [
                                Icon(LucideIcons.letterText),
                                Text('Nome'),
                              ],
                            ),
                          ),
                          if (state.sorting == InvoiceSorting.alphabetic)
                            Icon(
                              state.sortingAsc
                                  ? LucideIcons.arrowDownAZ
                                  : LucideIcons.arrowDownZA,
                            ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              icon: Icon(
                LucideIcons.funnel,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface,
              ),
              tooltip: 'Filtrar',
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoicesInfoCard extends StatelessWidget {
  const _InvoicesInfoCard({
    required this.invoiceCount,
    required this.cardIcon,
    required this.cardTitle,
  });

  final num invoiceCount;
  final String cardTitle;
  final IconData cardIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 6,
              children: [
                Icon(
                  cardIcon,
                  size: 20,
                ),
                Text(
                  cardTitle,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
              width: 125,
            ),
            Text(
              '$invoiceCount',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
