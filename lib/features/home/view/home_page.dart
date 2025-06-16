import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/features/auth/auth.dart';
import 'package:portal_flow/features/invoices/bloc/invoice_bloc.dart';
import 'package:portal_flow/features/invoices/view/invoice_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          const _HomeHeader(),
          Padding(
            padding: const EdgeInsetsGeometry.only(left: 16, top: 16),
            child: Row(
              children: [
                BlocBuilder<InvoiceBloc, InvoiceState>(
                  builder: (context, state) {
                    final pendingInvoicesLenght = state.pendingInvoices.length;

                    return Text(
                      'Boletos em Aberto: $pendingInvoicesLenght',
                      style: const TextStyle(fontSize: 22),
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: InvoiceList(invoiceFilter: InvoiceFilter.pendings,),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);

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
            // Avatar pequeno
            if (user.profileImage != null)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.memory(
                    user.profileImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.15),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),

            const SizedBox(width: 16),

            // Nome e saudação
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo!',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Botão de Notificações
            IconButton(
              onPressed: () {
                // context.read<AuthBloc>().add(AuthLogoutPressed());
              },
              icon: Icon(
                LucideIcons.bell,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface,
              ),
              tooltip: 'Notificações',
            ),
          ],
        ),
      ),
    );
  }
}
