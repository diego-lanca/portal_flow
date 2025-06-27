# 📄 Portal Flow

Aplicativo Flutter desenvolvido para visualização de **boletos de clientes do sistema Contabilflow**.

> **Atenção:** Este aplicativo **só funciona para clientes ativos do Contabilflow**, com acesso autorizado.

---

## 🔎 O que é?

Este app permite que clientes Contabilflow consultem e visualizem seus boletos (mensalidades, serviços, etc.) de forma simples, prática e organizada, direto do celular.

Ele se conecta com a API do Contabilflow e lista os boletos vinculados ao CPF/CNPJ do cliente logado.

---

## ⚙️ Tecnologias e Arquitetura

O projeto foi construído utilizando os principais padrões de desenvolvimento Flutter, garantindo **manutenibilidade**, **performance** e **escalabilidade**.

### 🧱 Arquitetura BLoC

* Utilizamos o padrão **BLoC (Business Logic Component)** para gerenciar o estado da aplicação.
* Toda a lógica de negócios, chamadas à API, e o controle da UI estão separados da camada de apresentação.
* A arquitetura ajuda a manter o código limpo, reutilizável e testável.

### 🎨 Suporte a Temas

* O aplicativo possui suporte completo a **tema claro (Light)** e **tema escuro (Dark)**.
* O tema é ajustado automaticamente de acordo com as preferências do sistema do usuário.
* Também pode ser alternado manualmente dentro das configurações do app (caso essa opção esteja habilitada).

### 🔐 Autenticação

* O acesso é **restrito aos clientes do Contabilflow**.
* A autenticação é feita por meio de **token seguro** fornecido pela plataforma, com validação de login (CNPJ/CPF e senha).

---

## 📱 Funcionalidades

* 🔐 Login seguro com verificação de cliente ativo
* 📄 Listagem de boletos com vencimento, valor, e status
* 🧾 Visualização detalhada do boleto (linha digitável, PDF, código de barras)
* 🎨 Interface adaptada para **tema claro e escuro**
* 🔄 Atualização automática da lista de boletos
* 🚫 Bloqueio de acesso para usuários não autorizados

---

## 🛠 Como rodar localmente

> Pré-requisitos: Flutter instalado e configurado

```bash
git clone https://github.com/seuusuario/contabilflow-boletos.git
cd contabilflow-boletos
flutter pub get
flutter run
```

---

## 🧪 Testes

* Em breve: testes unitários e de widget com cobertura para os principais BLoCs.

---

## 🔒 Segurança

* A comunicação com o servidor é feita via HTTPS, com uso de interceptadores para controle de sessão

---

## 🤝 Contribuição

Este projeto é fechado ao público geral e de uso exclusivo do sistema Contabilflow. Para contribuições, entre em contato com a equipe de desenvolvimento.

---

## 📝 Licença

Este projeto é privado e de uso exclusivo dos clientes Contabilflow.
Todos os direitos reservados © Contabilflow 2025.
