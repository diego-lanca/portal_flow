import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/features/home/view/home_page.dart';
import 'package:portal_flow/features/invoices/bloc/invoice_bloc.dart';
import 'package:portal_flow/features/invoices/view/invoice_page.dart';
import 'package:portal_flow/features/main/cubit/main_cubit.dart';
import 'package:portal_flow/features/settings/view/settings_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static Route<void> route(InvoiceRepository invoiceRepository) {
    return MaterialPageRoute<void>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MainCubit()),
          BlocProvider(
            create: (_) =>
                InvoiceBloc(invoiceRepository: invoiceRepository)
                  ..add(const InvoiceSubscriptionRequested()),
          ),
        ],

        child: const MainPage(),
      ),
    );
  }

  int _tabToIndex(MainTab tab) => MainTab.values.indexOf(tab);
  MainTab _indexToTab(int index) => MainTab.values.elementAt(index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: _page(state.mainTab),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.house),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.history),
                label: 'Histórico',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.settings),
                label: 'Configurações',
              ),
            ],
            currentIndex: _tabToIndex(state.mainTab),
            onTap: (index) {
              context.read<MainCubit>().setTab(_indexToTab(index));
            },
          ),
        );
      },
    );
  }

  Widget _page(MainTab tab) {
    switch (tab) {
      case MainTab.home:
        return const HomePage();
      case MainTab.historic:
        return const InvoicePage();
      case MainTab.config:
        return const SettingsPage();
    }
  }
}
