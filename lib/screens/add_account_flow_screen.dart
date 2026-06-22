import 'dart:ui';

import 'package:flutter/material.dart';

enum AddAccountFlowKind { bank, card, upi, wallet, insurance, loan }

enum _AddAccountFlowScreenId {
  hub,
  bank,
  card,
  upi,
  wallet,
  insurance,
  loan,
  review,
  success,
}

const Color _flowBackground = Color(0xFFF6F8F7);
const Color _flowText = Color(0xFF17233E);
const Color _flowMuted = Color(0xFF6B7D9C);
const Color _flowMutedStrong = Color(0xFF465673);
const Color _flowBorder = Color(0xFFDCE5F0);
const Color _flowCard = Color(0xFFFDFEFE);
const Color _flowCardSoft = Color(0xFFF5F8FC);
const Color _flowTeal = Color(0xFF1FAF8F);
const Color _flowTealBright = Color(0xFF11D493);
const Color _flowButtonStart = Color(0xFF28B296);
const Color _flowButtonEnd = Color(0xFF1EDC96);
const Color _flowSwitchTrack = Color(0xFFC8D3E3);
const Color _flowSwitchTrackOff = Color(0xFFD8E1EC);

const List<BoxShadow> _flowShadow = [
  BoxShadow(
    color: Color(0x140F172A),
    blurRadius: 24,
    offset: Offset(0, 8),
  ),
  BoxShadow(
    color: Color(0x0A0F172A),
    blurRadius: 8,
    offset: Offset(0, 2),
  ),
];

class AddAccountFlowScreen extends StatefulWidget {
  const AddAccountFlowScreen({super.key, this.initialKind});

  final AddAccountFlowKind? initialKind;

  @override
  State<AddAccountFlowScreen> createState() => _AddAccountFlowScreenState();
}

class _AddAccountFlowScreenState extends State<AddAccountFlowScreen> {
  final TextEditingController _hubSearchController = TextEditingController();

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankLast4Controller = TextEditingController();
  final TextEditingController _bankIfscController = TextEditingController();
  final TextEditingController _bankNicknameController = TextEditingController();
  final TextEditingController _bankBalanceController = TextEditingController();
  final TextEditingController _bankAsOfController = TextEditingController();

  final TextEditingController _cardIssuerController = TextEditingController();
  final TextEditingController _cardLast4Controller = TextEditingController();
  final TextEditingController _cardNicknameController = TextEditingController();
  final TextEditingController _cardLimitController = TextEditingController();
  final TextEditingController _cardOutstandingController = TextEditingController();
  final TextEditingController _cardStatementDayController =
      TextEditingController();
  final TextEditingController _cardDueDayController = TextEditingController();

  final TextEditingController _upiVpaController = TextEditingController();

  final TextEditingController _walletIdentifierController =
      TextEditingController();
  final TextEditingController _walletBalanceController = TextEditingController();
  final TextEditingController _walletNicknameController =
      TextEditingController();

  final TextEditingController _insuranceProviderController =
      TextEditingController();
  final TextEditingController _insurancePolicyNumberController =
      TextEditingController();
  final TextEditingController _insurancePolicyNameController =
      TextEditingController();
  final TextEditingController _insuranceCoverageController =
      TextEditingController();
  final TextEditingController _insuranceDueController = TextEditingController();
  final TextEditingController _insurancePremiumController =
      TextEditingController();

  final TextEditingController _loanLenderController = TextEditingController();
  final TextEditingController _loanOutstandingController =
      TextEditingController();
  final TextEditingController _loanEmiController = TextEditingController();
  final TextEditingController _loanEmiDayController = TextEditingController();
  final TextEditingController _loanRateController = TextEditingController();
  final TextEditingController _loanNicknameController = TextEditingController();

  _AddAccountFlowScreenId _screen = _AddAccountFlowScreenId.hub;
  AddAccountFlowKind? _selectedKind;

  String _bankType = 'Savings';
  bool _bankIncludeInNetWorth = true;

  bool _cardReminders = true;

  String _upiProvider = 'Google Pay';
  String _upiLinkType = 'Bank';
  String _upiLinked = 'HDFC Bank •••• 4582';
  bool _upiIsDefault = true;

  String _walletProvider = 'Paytm';
  bool _walletIncludeInNetWorth = true;

  String _insuranceType = 'Life';
  String _insuranceFrequency = 'Monthly';

  String _loanType = 'Home Loan';

  @override
  void initState() {
    super.initState();
    _seedDefaults();
    if (widget.initialKind != null) {
      _selectedKind = widget.initialKind;
      _screen = _screenForKind(widget.initialKind!);
    }
  }

  @override
  void dispose() {
    _hubSearchController.dispose();
    _bankNameController.dispose();
    _bankLast4Controller.dispose();
    _bankIfscController.dispose();
    _bankNicknameController.dispose();
    _bankBalanceController.dispose();
    _bankAsOfController.dispose();
    _cardIssuerController.dispose();
    _cardLast4Controller.dispose();
    _cardNicknameController.dispose();
    _cardLimitController.dispose();
    _cardOutstandingController.dispose();
    _cardStatementDayController.dispose();
    _cardDueDayController.dispose();
    _upiVpaController.dispose();
    _walletIdentifierController.dispose();
    _walletBalanceController.dispose();
    _walletNicknameController.dispose();
    _insuranceProviderController.dispose();
    _insurancePolicyNumberController.dispose();
    _insurancePolicyNameController.dispose();
    _insuranceCoverageController.dispose();
    _insuranceDueController.dispose();
    _insurancePremiumController.dispose();
    _loanLenderController.dispose();
    _loanOutstandingController.dispose();
    _loanEmiController.dispose();
    _loanEmiDayController.dispose();
    _loanRateController.dispose();
    _loanNicknameController.dispose();
    super.dispose();
  }

  void _seedDefaults() {
    _hubSearchController.text = '';

    _bankNameController.text = '';
    _bankLast4Controller.text = '4582';
    _bankIfscController.text = 'HDFC0001234';
    _bankNicknameController.text = 'Salary / Emergency';
    _bankBalanceController.text = '450000';
    _bankAsOfController.text = '2026-05-10';
    _bankType = 'Savings';
    _bankIncludeInNetWorth = true;

    _cardIssuerController.text = '';
    _cardLast4Controller.text = '8234';
    _cardNicknameController.text = 'Regalia / Amazon Pay / Work card';
    _cardLimitController.text = '300000';
    _cardOutstandingController.text = '18400';
    _cardStatementDayController.text = '';
    _cardDueDayController.text = '';
    _cardReminders = true;

    _upiProvider = 'Google Pay';
    _upiLinkType = 'Bank';
    _upiVpaController.text = 'ayush@upi';
    _upiLinked = 'HDFC Bank •••• 4582';
    _upiIsDefault = true;

    _walletProvider = 'Paytm';
    _walletIdentifierController.text = '';
    _walletBalanceController.text = '1500';
    _walletNicknameController.text = 'Travel / Work';
    _walletIncludeInNetWorth = true;

    _insuranceType = 'Life';
    _insuranceProviderController.text = '';
    _insurancePolicyNumberController.text = 'XXXXX12345';
    _insurancePolicyNameController.text = 'LIC Jeevan / Health Plus';
    _insuranceCoverageController.text = '10000000';
    _insuranceDueController.text = '2026-05-10';
    _insurancePremiumController.text = '2500';
    _insuranceFrequency = 'Monthly';

    _loanType = 'Home Loan';
    _loanLenderController.text = '';
    _loanOutstandingController.text = '4550000';
    _loanEmiController.text = '45000';
    _loanEmiDayController.text = '';
    _loanRateController.text = '';
    _loanNicknameController.text = 'Home loan';
  }

  _AddAccountFlowScreenId _screenForKind(AddAccountFlowKind kind) {
    switch (kind) {
      case AddAccountFlowKind.bank:
        return _AddAccountFlowScreenId.bank;
      case AddAccountFlowKind.card:
        return _AddAccountFlowScreenId.card;
      case AddAccountFlowKind.upi:
        return _AddAccountFlowScreenId.upi;
      case AddAccountFlowKind.wallet:
        return _AddAccountFlowScreenId.wallet;
      case AddAccountFlowKind.insurance:
        return _AddAccountFlowScreenId.insurance;
      case AddAccountFlowKind.loan:
        return _AddAccountFlowScreenId.loan;
    }
  }

  void _openKind(AddAccountFlowKind kind) {
    setState(() {
      _selectedKind = kind;
      _screen = _screenForKind(kind);
    });
  }

  void _goBackFromForm() {
    setState(() {
      _screen = _AddAccountFlowScreenId.hub;
    });
  }

  void _goBackFromReview() {
    if (_selectedKind == null) {
      setState(() => _screen = _AddAccountFlowScreenId.hub);
      return;
    }

    setState(() {
      _screen = _screenForKind(_selectedKind!);
    });
  }

  void _openReview() {
    if (!_validateCurrentKind()) {
      return;
    }

    setState(() {
      _screen = _AddAccountFlowScreenId.review;
    });
  }

  bool _validateCurrentKind() {
    switch (_selectedKind) {
      case AddAccountFlowKind.bank:
        if (_bankNameController.text.trim().isEmpty) {
          _showToast('Please enter your bank name.');
          return false;
        }
        if (_bankBalanceController.text.trim().isEmpty) {
          _showToast('Please enter current balance.');
          return false;
        }
        if (_digitsOnly(_bankLast4Controller.text).isNotEmpty &&
            _digitsOnly(_bankLast4Controller.text).length != 4) {
          _showToast('Last 4 digits must be 4 numbers.');
          return false;
        }
        return true;
      case AddAccountFlowKind.card:
        if (_cardIssuerController.text.trim().isEmpty) {
          _showToast('Please enter card issuer.');
          return false;
        }
        if (_cardLimitController.text.trim().isEmpty) {
          _showToast('Please enter credit limit.');
          return false;
        }
        if (_cardOutstandingController.text.trim().isEmpty) {
          _showToast('Please enter outstanding amount.');
          return false;
        }
        if (_digitsOnly(_cardLast4Controller.text).isNotEmpty &&
            _digitsOnly(_cardLast4Controller.text).length != 4) {
          _showToast('Last 4 digits must be 4 numbers.');
          return false;
        }
        return true;
      case AddAccountFlowKind.upi:
        if (_upiVpaController.text.trim().isEmpty) {
          _showToast('Please enter your UPI ID (VPA).');
          return false;
        }
        return true;
      case AddAccountFlowKind.wallet:
        if (_walletIdentifierController.text.trim().isEmpty) {
          _showToast('Please enter wallet identifier.');
          return false;
        }
        if (_walletBalanceController.text.trim().isEmpty) {
          _showToast('Please enter wallet balance.');
          return false;
        }
        return true;
      case AddAccountFlowKind.insurance:
        if (_insuranceProviderController.text.trim().isEmpty) {
          _showToast('Please enter insurance provider.');
          return false;
        }
        if (_insurancePolicyNameController.text.trim().isEmpty) {
          _showToast('Please enter policy name.');
          return false;
        }
        if (_insuranceDueController.text.trim().isEmpty) {
          _showToast('Please select next due date.');
          return false;
        }
        return true;
      case AddAccountFlowKind.loan:
        if (_loanLenderController.text.trim().isEmpty) {
          _showToast('Please enter lender name.');
          return false;
        }
        if (_loanOutstandingController.text.trim().isEmpty) {
          _showToast('Please enter outstanding amount.');
          return false;
        }
        if (_loanEmiController.text.trim().isEmpty) {
          _showToast('Please enter EMI amount.');
          return false;
        }
        return true;
      case null:
        _showToast('Choose a category first.');
        return false;
    }
  }

  void _confirmAdd() {
    setState(() {
      _screen = _AddAccountFlowScreenId.success;
    });
  }

  void _resetFlow() {
    setState(() {
      _seedDefaults();
      _selectedKind = null;
      _screen = _AddAccountFlowScreenId.hub;
    });
  }

  void _goToAccountsDemo() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }

    _resetFlow();
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  String _digitsOnly(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _indianFormat(String value) {
    final raw = value.replaceAll(RegExp(r'[^0-9-]'), '');
    if (raw.isEmpty || raw == '-') {
      return '—';
    }

    final negative = raw.startsWith('-');
    final digits = raw.replaceAll('-', '');
    if (digits.isEmpty) {
      return '—';
    }

    if (digits.length <= 3) {
      return '${negative ? '- ' : ''}₹ $digits';
    }

    final last3 = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final parts = <String>[];
    while (rest.length > 2) {
      parts.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) {
      parts.insert(0, rest);
    }

    final grouped = [...parts, last3].join(',');
    return '${negative ? '- ' : ''}₹ $grouped';
  }

  String _summaryTitle() {
    switch (_selectedKind) {
      case AddAccountFlowKind.bank:
        final name = _bankNameController.text.trim();
        final nickname = _bankNicknameController.text.trim();
        return nickname.isNotEmpty ? nickname : (name.isNotEmpty ? name : 'Bank');
      case AddAccountFlowKind.card:
        final nick = _cardNicknameController.text.trim();
        final issuer = _cardIssuerController.text.trim();
        return nick.isNotEmpty ? nick : (issuer.isNotEmpty ? '$issuer Card' : 'Card');
      case AddAccountFlowKind.upi:
        return '$_upiProvider UPI';
      case AddAccountFlowKind.wallet:
        final nick = _walletNicknameController.text.trim();
        return nick.isNotEmpty ? nick : _walletProvider;
      case AddAccountFlowKind.insurance:
        final name = _insurancePolicyNameController.text.trim();
        return name.isNotEmpty ? name : 'Insurance Policy';
      case AddAccountFlowKind.loan:
        final nick = _loanNicknameController.text.trim();
        return nick.isNotEmpty ? nick : _loanType;
      case null:
        return '—';
    }
  }

  String _summarySubtitle() {
    switch (_selectedKind) {
      case AddAccountFlowKind.bank:
        final last4 = _digitsOnly(_bankLast4Controller.text);
        return '$_bankType •••• ${last4.isEmpty ? '—' : last4}';
      case AddAccountFlowKind.card:
        final issuer = _cardIssuerController.text.trim().isEmpty
            ? 'Issuer'
            : _cardIssuerController.text.trim();
        final last4 = _digitsOnly(_cardLast4Controller.text);
        return '$issuer •••• ${last4.isEmpty ? '—' : last4}';
      case AddAccountFlowKind.upi:
        return '${_upiVpaController.text.trim()} • $_upiLinkType';
      case AddAccountFlowKind.wallet:
        final id = _walletIdentifierController.text.trim().isEmpty
            ? '—'
            : _walletIdentifierController.text.trim();
        return '$_walletProvider • $id';
      case AddAccountFlowKind.insurance:
        final provider = _insuranceProviderController.text.trim().isEmpty
            ? 'Provider'
            : _insuranceProviderController.text.trim();
        return '$_insuranceType • $provider';
      case AddAccountFlowKind.loan:
        final lender = _loanLenderController.text.trim().isEmpty
            ? 'Lender'
            : _loanLenderController.text.trim();
        return '$lender • $_loanType';
      case null:
        return '—';
    }
  }

  List<_ReviewEntry> _reviewEntries() {
    switch (_selectedKind) {
      case AddAccountFlowKind.bank:
        return [
          _ReviewEntry('Balance', _indianFormat(_bankBalanceController.text)),
          _ReviewEntry('As of', _bankAsOfController.text.trim().isEmpty
              ? '—'
              : _bankAsOfController.text.trim()),
          _ReviewEntry('IFSC', _bankIfscController.text.trim().isEmpty
              ? '—'
              : _bankIfscController.text.trim()),
          _ReviewEntry(
            'Net worth',
            _bankIncludeInNetWorth ? 'Included' : 'Excluded',
          ),
        ];
      case AddAccountFlowKind.card:
        return [
          _ReviewEntry(
            'Outstanding',
            _indianFormat(_cardOutstandingController.text),
          ),
          _ReviewEntry('Limit', _indianFormat(_cardLimitController.text)),
          _ReviewEntry(
            'Statement day',
            _cardStatementDayController.text.trim().isEmpty
                ? '—'
                : 'Day ${_cardStatementDayController.text.trim()}',
          ),
          _ReviewEntry(
            'Due day',
            _cardDueDayController.text.trim().isEmpty
                ? '—'
                : 'Day ${_cardDueDayController.text.trim()}',
          ),
        ];
      case AddAccountFlowKind.upi:
        return [
          _ReviewEntry('Linked to', _upiLinked),
          _ReviewEntry('Default', _upiIsDefault ? 'Yes' : 'No'),
          _ReviewEntry('Provider', _upiProvider),
          _ReviewEntry('Link type', _upiLinkType),
        ];
      case AddAccountFlowKind.wallet:
        return [
          _ReviewEntry('Balance', _indianFormat(_walletBalanceController.text)),
          _ReviewEntry(
            'Identifier',
            _walletIdentifierController.text.trim().isEmpty
                ? '—'
                : _walletIdentifierController.text.trim(),
          ),
          _ReviewEntry('Provider', _walletProvider),
          _ReviewEntry(
            'Net worth',
            _walletIncludeInNetWorth ? 'Included' : 'Excluded',
          ),
        ];
      case AddAccountFlowKind.insurance:
        return [
          _ReviewEntry(
            'Coverage',
            _indianFormat(_insuranceCoverageController.text),
          ),
          _ReviewEntry('Premium', _indianFormat(_insurancePremiumController.text)),
          _ReviewEntry('Frequency', _insuranceFrequency),
          _ReviewEntry(
            'Next due',
            _insuranceDueController.text.trim().isEmpty
                ? '—'
                : _insuranceDueController.text.trim(),
          ),
        ];
      case AddAccountFlowKind.loan:
        return [
          _ReviewEntry(
            'Outstanding',
            _indianFormat(_loanOutstandingController.text),
          ),
          _ReviewEntry('EMI', _indianFormat(_loanEmiController.text)),
          _ReviewEntry(
            'EMI day',
            _loanEmiDayController.text.trim().isEmpty
                ? '—'
                : 'Day ${_loanEmiDayController.text.trim()}',
          ),
          _ReviewEntry(
            'Rate',
            _loanRateController.text.trim().isEmpty
                ? '—'
                : '${_loanRateController.text.trim()}%',
          ),
        ];
      case null:
        return const [];
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final parsed = DateTime.tryParse(controller.text.trim()) ?? DateTime(2026, 5, 10);
    final selected = await showDatePicker(
      context: context,
      initialDate: parsed,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (selected == null) {
      return;
    }

    setState(() {
      controller.text =
          '${selected.year.toString().padLeft(4, '0')}-'
          '${selected.month.toString().padLeft(2, '0')}-'
          '${selected.day.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _flowBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Stack(
            children: [
              const _AmbientFlowBackground(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final offset = Tween<Offset>(
                    begin: const Offset(0.03, 0),
                    end: Offset.zero,
                  ).animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: offset, child: child),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey(_screen),
                  child: _buildActiveScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveScreen() {
    switch (_screen) {
      case _AddAccountFlowScreenId.hub:
        return _buildHubScreen();
      case _AddAccountFlowScreenId.bank:
        return _buildBankScreen();
      case _AddAccountFlowScreenId.card:
        return _buildCardScreen();
      case _AddAccountFlowScreenId.upi:
        return _buildUpiScreen();
      case _AddAccountFlowScreenId.wallet:
        return _buildWalletScreen();
      case _AddAccountFlowScreenId.insurance:
        return _buildInsuranceScreen();
      case _AddAccountFlowScreenId.loan:
        return _buildLoanScreen();
      case _AddAccountFlowScreenId.review:
        return _buildReviewScreen();
      case _AddAccountFlowScreenId.success:
        return _buildSuccessScreen();
    }
  }

  Widget _buildHubScreen() {
    final kinds = AddAccountFlowKind.values.where((kind) {
      final q = _hubSearchController.text.trim().toLowerCase();
      if (q.isEmpty) {
        return true;
      }
      final meta = kind.meta;
      return meta.title.toLowerCase().contains(q) ||
          meta.subtitle.toLowerCase().contains(q) ||
          meta.quickSubtitle.toLowerCase().contains(q);
    }).toList();

    final quickKinds = <AddAccountFlowKind>[
      AddAccountFlowKind.bank,
      AddAccountFlowKind.card,
      AddAccountFlowKind.upi,
    ].where((kind) => kinds.contains(kind)).toList();

    return _FlowShell(
      title: 'Add Account',
      subtitle: 'Choose a category to add',
      onBack: () => Navigator.of(context).maybePop(),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.brightness_3_rounded,
          color: _flowText,
          size: 32,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroBanner(),
          const SizedBox(height: 20),
          _SearchBar(
            controller: _hubSearchController,
            onChanged: (_) => setState(() {}),
            onClear: () {
              _hubSearchController.clear();
              setState(() {});
            },
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Most used',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _flowText,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              Text(
                'Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _flowMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 102,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: quickKinds.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final kind = quickKinds[index];
                return _HubMiniCard(
                  meta: kind.meta,
                  onTap: () => _openKind(kind),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kinds.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.86,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemBuilder: (context, index) {
              final kind = kinds[index];
              return _HubGridCard(
                meta: kind.meta,
                onTap: () => _openKind(kind),
              );
            },
          ),
          const SizedBox(height: 20),
          const _TrustCard(),
        ],
      ),
    );
  }

  Widget _buildBankScreen() {
    return _FlowShell(
      title: 'Add Bank',
      subtitle: 'Step 1 of 2 — Details',
      onBack: _goBackFromForm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Essentials (fast)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: _flowMutedStrong,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F9),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  'MANUAL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: _flowMutedStrong,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFFD8E0EA),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 28),
          _SectionCard(
            children: [
              _SectionIntro(
                meta: AddAccountFlowKind.bank.meta,
                title: 'Account',
                subtitle: 'This powers the “Bank Accounts” section',
              ),
              const SizedBox(height: 24),
              const _FieldLabel('Bank name'),
              const SizedBox(height: 10),
              _TextInputField(
                controller: _bankNameController,
                hintText: 'e.g., HDFC Bank',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _DropdownField<String>(
                      label: 'Account type',
                      value: _bankType,
                      options: const ['Savings', 'Current', 'Salary'],
                      onChanged: (value) => setState(() => _bankType = value),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Last 4 digits',
                      child: _TextInputField(
                        controller: _bankLast4Controller,
                        hintText: '4582',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'IFSC (optional)',
                      child: _TextInputField(
                        controller: _bankIfscController,
                        hintText: 'HDFC0001234',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Nickname',
                      child: _TextInputField(
                        controller: _bankNicknameController,
                        hintText: 'Salary / Emergency',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          _SectionCard(
            children: [
              _SectionIntro(
                meta: _SectionMeta(
                  accent: const Color(0xFF0F8D67),
                  softAccent: const Color(0xFFE6F7F0),
                  icon: Icons.payments_outlined,
                  title: 'Balance',
                  subtitle: '',
                  quickSubtitle: '',
                ),
                title: 'Balance',
                subtitle: 'Used in total net worth calculations',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Current balance',
                      child: _TextInputField(
                        controller: _bankBalanceController,
                        hintText: '450000',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'As of',
                      child: _TextInputField(
                        controller: _bankAsOfController,
                        hintText: '2026-05-10',
                        readOnly: true,
                        suffixIcon: Icons.calendar_today_outlined,
                        onTap: () => _pickDate(_bankAsOfController),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _ToggleTile(
                title: 'Include in Net Worth',
                subtitle: 'Recommended for accurate insights.',
                value: _bankIncludeInNetWorth,
                onChanged: (value) {
                  setState(() => _bankIncludeInNetWorth = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 28),
          const _InfoCard(
            icon: Icons.lightbulb_outline_rounded,
            iconColor: Color(0xFFDD7A02),
            iconBackground: Color(0xFFFFF7E5),
            borderColor: Color(0xFFF7D98F),
            background: Color(0xFFFFFBF0),
            text:
                'Tip: Use a nickname like “Salary” so your Accounts page stays clean and easy to scan.',
          ),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Review details',
        onTap: _openReview,
      ),
    );
  }

  Widget _buildCardScreen() {
    return _FlowShell(
      title: 'Add Credit Card',
      subtitle: 'Step 1 of 2 — Details',
      onBack: _goBackFromForm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardPreview(
            title: _cardNicknameController.text.trim().isEmpty
                ? 'Your Card'
                : _cardNicknameController.text.trim(),
            last4: _digitsOnly(_cardLast4Controller.text).isEmpty
                ? '0000'
                : _digitsOnly(_cardLast4Controller.text),
          ),
          const SizedBox(height: 24),
          _SectionCard(
            children: [
              _SectionIntro(
                meta: AddAccountFlowKind.card.meta,
                title: 'Card',
                subtitle: 'Appears under “Credit Cards”',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Issuer',
                      child: _TextInputField(
                        controller: _cardIssuerController,
                        hintText: 'e.g., HDFC',
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Last 4 digits',
                      child: _TextInputField(
                        controller: _cardLast4Controller,
                        hintText: '8234',
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _FieldLabel('Nickname'),
              const SizedBox(height: 10),
              _TextInputField(
                controller: _cardNicknameController,
                hintText: 'Regalia / Amazon Pay / Work card',
                onChanged: (_) => setState(() {}),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _SectionCard(
            children: [
              _SectionIntro(
                meta: _SectionMeta(
                  accent: const Color(0xFF4746D6),
                  softAccent: const Color(0xFFE9EAFF),
                  icon: Icons.query_stats_rounded,
                  title: 'Limits & Billing',
                  subtitle: '',
                  quickSubtitle: '',
                ),
                title: 'Limits & Billing',
                subtitle: 'Helps generate credit insights & reminders',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Credit limit',
                      child: _TextInputField(
                        controller: _cardLimitController,
                        hintText: '300000',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Outstanding',
                      child: _TextInputField(
                        controller: _cardOutstandingController,
                        hintText: '18400',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Statement day',
                      child: _TextInputField(
                        controller: _cardStatementDayController,
                        hintText: 'e.g., 1',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Due day',
                      child: _TextInputField(
                        controller: _cardDueDayController,
                        hintText: 'e.g., 28',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _ToggleTile(
                title: 'Payment reminders',
                subtitle: 'Notifies before due date.',
                value: _cardReminders,
                onChanged: (value) {
                  setState(() => _cardReminders = value);
                },
              ),
            ],
          ),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Review details',
        onTap: _openReview,
      ),
    );
  }

  Widget _buildUpiScreen() {
    final linkedOptions = _upiLinkType == 'Credit Card'
        ? const [
            'HDFC Regalia •••• 8234',
            'ICICI Amazon Pay •••• 5671',
          ]
        : const [
            'HDFC Bank •••• 4582',
            'ICICI Bank •••• 9210',
          ];

    if (!linkedOptions.contains(_upiLinked)) {
      _upiLinked = linkedOptions.first;
    }

    return _FlowShell(
      title: 'Add UPI',
      subtitle: 'Step 1 of 2 — Details',
      onBack: _goBackFromForm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'UPI App',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _flowText,
                      ),
                    ),
                  ),
                  Text(
                    'Select one',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: _flowMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: ['Google Pay', 'Paytm', 'BHIM'].map((provider) {
                  return _FilterPill(
                    label: provider,
                    isSelected: _upiProvider == provider,
                    onTap: () => setState(() => _upiProvider = provider),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionCard(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Link type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _flowText,
                      ),
                    ),
                  ),
                  Text(
                    'Choose',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: _flowMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _SegmentedControl(
                value: _upiLinkType,
                options: const ['Bank', 'Credit Card'],
                onChanged: (value) {
                  setState(() {
                    _upiLinkType = value;
                    _upiLinked = value == 'Credit Card'
                        ? 'HDFC Regalia •••• 8234'
                        : 'HDFC Bank •••• 4582';
                  });
                },
              ),
              const SizedBox(height: 20),
              const _InfoCard(
                icon: Icons.info_outline_rounded,
                iconColor: Color(0xFFDD7A02),
                iconBackground: Color(0xFFFFF7E5),
                borderColor: Color(0xFFF7D98F),
                background: Color(0xFFFFFBF0),
                text:
                    'UPI on credit card is commonly supported for RuPay cards.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionCard(
            children: [
              _SectionIntro(
                meta: AddAccountFlowKind.upi.meta,
                title: 'UPI ID',
                subtitle: 'This helps identify the UPI account',
              ),
              const SizedBox(height: 24),
              const _FieldLabel('UPI ID (VPA)'),
              const SizedBox(height: 10),
              _TextInputField(
                controller: _upiVpaController,
                hintText: 'ayush@upi',
              ),
              const SizedBox(height: 24),
              _DropdownField<String>(
                label: _upiLinkType == 'Credit Card'
                    ? 'Linked credit card'
                    : 'Linked bank account',
                value: _upiLinked,
                options: linkedOptions,
                onChanged: (value) => setState(() => _upiLinked = value),
              ),
              const SizedBox(height: 10),
              const Text(
                'Demo list — in your app, load from user’s accounts.',
                style: TextStyle(
                  fontSize: 12,
                  color: _flowMuted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              _ToggleTile(
                title: 'Set as default',
                subtitle: 'Use in quick actions.',
                value: _upiIsDefault,
                onChanged: (value) {
                  setState(() => _upiIsDefault = value);
                },
              ),
            ],
          ),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Review details',
        onTap: _openReview,
      ),
    );
  }

  Widget _buildWalletScreen() {
    return _FlowShell(
      title: 'Add Wallet',
      subtitle: 'Step 1 of 2 — Details',
      onBack: _goBackFromForm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Wallet provider',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _flowText,
                      ),
                    ),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: _flowMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: ['Paytm', 'Amazon Pay', 'Other'].map((provider) {
                  return _FilterPill(
                    label: provider,
                    isSelected: _walletProvider == provider,
                    onTap: () => setState(() => _walletProvider = provider),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionCard(
            children: [
              _SectionIntro(
                meta: AddAccountFlowKind.wallet.meta,
                title: 'Wallet details',
                subtitle: 'Identifier + current balance',
              ),
              const SizedBox(height: 24),
              const _FieldLabel('Identifier'),
              const SizedBox(height: 10),
              _TextInputField(
                controller: _walletIdentifierController,
                hintText: 'Phone / email / handle',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Balance',
                      child: _TextInputField(
                        controller: _walletBalanceController,
                        hintText: '1500',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Nickname',
                      child: _TextInputField(
                        controller: _walletNicknameController,
                        hintText: 'Travel / Work',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _ToggleTile(
                title: 'Include in Net Worth',
                subtitle: 'Most users keep this ON.',
                value: _walletIncludeInNetWorth,
                onChanged: (value) {
                  setState(() => _walletIncludeInNetWorth = value);
                },
              ),
            ],
          ),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Review details',
        onTap: _openReview,
      ),
    );
  }

  Widget _buildInsuranceScreen() {
    return _FlowShell(
      title: 'Add Insurance',
      subtitle: 'Step 1 of 2 — Details',
      onBack: _goBackFromForm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            children: [
              _SectionIntro(
                meta: AddAccountFlowKind.insurance.meta,
                title: 'Policy',
                subtitle: 'For renewals + reminders',
              ),
              const SizedBox(height: 24),
              _DropdownField<String>(
                label: 'Type',
                value: _insuranceType,
                options: const ['Life', 'Health', 'Motor', 'Home', 'Travel'],
                onChanged: (value) => setState(() => _insuranceType = value),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Provider',
                      child: _TextInputField(
                        controller: _insuranceProviderController,
                        hintText: 'e.g., LIC',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Policy #',
                      child: _TextInputField(
                        controller: _insurancePolicyNumberController,
                        hintText: 'XXXXX12345',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _FieldLabel('Policy name'),
              const SizedBox(height: 10),
              _TextInputField(
                controller: _insurancePolicyNameController,
                hintText: 'LIC Jeevan / Health Plus',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Coverage',
                      child: _TextInputField(
                        controller: _insuranceCoverageController,
                        hintText: '10000000',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Next due',
                      child: _TextInputField(
                        controller: _insuranceDueController,
                        hintText: '2026-05-10',
                        readOnly: true,
                        suffixIcon: Icons.calendar_today_outlined,
                        onTap: () => _pickDate(_insuranceDueController),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Premium',
                      child: _TextInputField(
                        controller: _insurancePremiumController,
                        hintText: '2500',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DropdownField<String>(
                      label: 'Frequency',
                      value: _insuranceFrequency,
                      options: const ['Monthly', 'Quarterly', 'Yearly'],
                      onChanged: (value) {
                        setState(() => _insuranceFrequency = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showToast('Upload (demo)'),
                  icon: const Icon(Icons.file_upload_outlined),
                  label: const Text('Upload policy document (optional)'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    foregroundColor: _flowText,
                    backgroundColor: const Color(0xFFF2F6FB),
                    side: const BorderSide(color: _flowBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Review details',
        onTap: _openReview,
      ),
    );
  }

  Widget _buildLoanScreen() {
    return _FlowShell(
      title: 'Add Loan',
      subtitle: 'Step 1 of 2 — Details',
      onBack: _goBackFromForm,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            children: [
              _SectionIntro(
                meta: AddAccountFlowKind.loan.meta,
                title: 'Loan',
                subtitle: 'Typically shown as a liability',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _DropdownField<String>(
                      label: 'Type',
                      value: _loanType,
                      options: const [
                        'Home Loan',
                        'Car Loan',
                        'Personal Loan',
                        'Education Loan',
                        'Credit Line',
                      ],
                      onChanged: (value) => setState(() => _loanType = value),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Lender',
                      child: _TextInputField(
                        controller: _loanLenderController,
                        hintText: 'e.g., HDFC',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'Outstanding',
                      child: _TextInputField(
                        controller: _loanOutstandingController,
                        hintText: '4550000',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'EMI',
                      child: _TextInputField(
                        controller: _loanEmiController,
                        hintText: '45000',
                        keyboardType: TextInputType.number,
                        prefixText: '₹',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: 'EMI date (day)',
                      child: _TextInputField(
                        controller: _loanEmiDayController,
                        hintText: 'e.g., 5',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabeledField(
                      label: 'Interest rate',
                      child: _TextInputField(
                        controller: _loanRateController,
                        hintText: 'e.g., 8.5',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        suffixText: '%',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _FieldLabel('Nickname (optional)'),
              const SizedBox(height: 10),
              _TextInputField(
                controller: _loanNicknameController,
                hintText: 'Home loan',
              ),
            ],
          ),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Review details',
        onTap: _openReview,
      ),
    );
  }

  Widget _buildReviewScreen() {
    final kind = _selectedKind;
    final meta = kind?.meta ?? AddAccountFlowKind.bank.meta;
    final entries = _reviewEntries();

    return _FlowShell(
      title: 'Review',
      subtitle: 'Step 2 of 2 — Confirm',
      onBack: _goBackFromReview,
      trailing: TextButton(
        onPressed: _goBackFromReview,
        child: const Text(
          'Edit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: _flowText,
          ),
        ),
      ),
      body: Column(
        children: [
          _SectionCard(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: meta.softAccent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(meta.icon, color: meta.accent, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _summaryTitle(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: _flowText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _summarySubtitle(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: _flowMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: meta.softAccent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      meta.reviewPill,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: meta.accent,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: entries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 118,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return _ReviewMetricCard(entry: entry);
                },
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _TrustNoticeCard(),
        ],
      ),
      bottomBar: _PrimaryBottomBar(
        label: 'Add account',
        onTap: _confirmAdd,
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_flowButtonStart, _flowButtonEnd],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: _flowShadow,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 58),
            ),
            const SizedBox(height: 36),
            const Text(
              'Added successfully',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: _flowText,
                letterSpacing: -0.7,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Your item is now part of your overview. Add more for richer insights.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: _flowMutedStrong,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 42),
            _SectionCard(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: _flowMutedStrong,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _summaryTitle(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: _flowText,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _summarySubtitle(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: _flowMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 34),
            _PrimaryActionButton(
              label: 'Add another',
              onTap: _resetFlow,
            ),
            const SizedBox(height: 18),
            _SecondaryActionButton(
              label: 'Go to Accounts (demo)',
              onTap: _goToAccountsDemo,
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class _FlowShell extends StatelessWidget {
  const _FlowShell({
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.body,
    this.trailing,
    this.bottomBar,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final Widget body;
  final Widget? trailing;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xF5FFFFFF),
                border: Border(bottom: BorderSide(color: Color(0xFFE8EEF6))),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                  child: Row(
                    children: [
                      _HeaderIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: onBack,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: _flowText,
                                letterSpacing: -0.6,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                fontSize: 16,
                                color: _flowMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...[trailing].whereType<Widget>(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              24,
              20,
              bottomBar == null ? 32 : 140,
            ),
            child: body,
          ),
        ),
        ...[bottomBar].whereType<Widget>(),
      ],
    );
  }
}

class _AmbientFlowBackground extends StatelessWidget {
  const _AmbientFlowBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Container(color: _flowBackground),
          Positioned(
            top: -120,
            left: -110,
            child: _BlurOrb(
              size: 340,
              color: const Color(0xFFE7EEF9),
            ),
          ),
          Positioned(
            top: 420,
            right: -120,
            child: _BlurOrb(
              size: 330,
              color: const Color(0xFFDFF7F0),
            ),
          ),
          Positioned(
            bottom: -170,
            left: -160,
            child: _BlurOrb(
              size: 420,
              color: const Color(0xFFE3E4FA),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 26,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Icon(icon, color: _flowText, size: 34),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_flowTeal, _flowTealBright, _flowTeal],
          stops: [0.0, 0.62, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: _flowShadow,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -36,
            right: -36,
            child: _GlassBubble(size: 150, color: Colors.white.withAlpha(34)),
          ),
          Positioned(
            bottom: -40,
            left: -30,
            child: _GlassBubble(size: 160, color: Colors.black.withAlpha(18)),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Build a clean financial overview',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Add accounts & policies',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.8,
                  height: 1.02,
                ),
              ),
              SizedBox(height: 24),
              Wrap(
                spacing: 14,
                runSpacing: 10,
                children: [
                  _HeroChip(label: 'Net worth'),
                  _HeroChip(label: 'Reminders'),
                  _HeroChip(label: 'Insights'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlassBubble extends StatelessWidget {
  const _GlassBubble({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(24),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _flowBorder),
        boxShadow: _flowShadow,
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF9BABBF), size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 18,
                color: _flowText,
              ),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search bank, card, UPI, wallet...',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF9AACC4),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: onClear,
            child: const Text(
              'Clear',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: _flowText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HubMiniCard extends StatelessWidget {
  const _HubMiniCard({required this.meta, required this.onTap});

  final _SectionMeta meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: 270,
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _flowBorder),
            boxShadow: _flowShadow,
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: meta.softAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(meta.icon, color: meta.accent, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      meta.miniTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: _flowText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      meta.quickSubtitle,
                      style: const TextStyle(
                        fontSize: 15,
                        color: _flowMuted,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HubGridCard extends StatelessWidget {
  const _HubGridCard({required this.meta, required this.onTap});

  final _SectionMeta meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _flowBorder),
            boxShadow: _flowShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: meta.softAccent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(meta.icon, color: meta.accent, size: 34),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: const Color(0xFFD0D9E7),
                    size: 38,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                meta.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: _flowText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                meta.subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: _flowMuted,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrustCard extends StatelessWidget {
  const _TrustCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(250),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _flowBorder),
        boxShadow: _flowShadow,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: _flowText,
            size: 34,
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Private by design',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: _flowText,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Add manually in seconds. No PINs, no OTPs required in this flow.',
                  style: TextStyle(
                    fontSize: 16,
                    color: _flowMutedStrong,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.children,
    this.padding = const EdgeInsets.fromLTRB(18, 18, 18, 18),
  });

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _flowCard.withAlpha(252),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _flowBorder),
        boxShadow: _flowShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _SectionIntro extends StatelessWidget {
  const _SectionIntro({
    required this.meta,
    required this.title,
    required this.subtitle,
  });

  final _SectionMeta meta;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: meta.softAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(meta.icon, color: meta.accent, size: 30),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: _flowText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: _flowMuted,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: _flowMutedStrong,
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _TextInputField extends StatelessWidget {
  const _TextInputField({
    required this.controller,
    required this.hintText,
    this.prefixText,
    this.suffixText,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final String? prefixText;
  final String? suffixText;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _flowBorder),
        ),
        child: Row(
          children: [
            if (prefixText != null) ...[
              Text(
                prefixText!,
                style: const TextStyle(
                  fontSize: 18,
                  color: _flowMuted,
                ),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: AbsorbPointer(
                absorbing: readOnly,
                child: TextField(
                  controller: controller,
                  readOnly: readOnly,
                  keyboardType: keyboardType,
                  onTap: onTap,
                  onChanged: onChanged,
                  style: const TextStyle(
                    fontSize: 18,
                    color: _flowText,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: _flowMuted,
                    ),
                  ),
                ),
              ),
            ),
            if (suffixText != null) ...[
              const SizedBox(width: 10),
              Text(
                suffixText!,
                style: const TextStyle(
                  fontSize: 18,
                  color: _flowMuted,
                ),
              ),
            ],
            if (suffixIcon != null) ...[
              const SizedBox(width: 10),
              Icon(suffixIcon, color: _flowText, size: 26),
            ],
          ],
        ),
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label),
        const SizedBox(height: 10),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _flowBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: _flowMuted,
                size: 34,
              ),
              style: const TextStyle(
                fontSize: 18,
                color: _flowText,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(18),
              items: options.map((option) {
                return DropdownMenuItem<T>(
                  value: option,
                  child: Text(
                    '$option',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: _flowText,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (next) {
                if (next != null) {
                  onChanged(next);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _flowCardSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _flowBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: _flowText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: _flowMuted,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _SoftSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _SoftSwitch extends StatelessWidget {
  const _SoftSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 78,
        height: 44,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: value ? _flowSwitchTrack : _flowSwitchTrackOff,
          borderRadius: BorderRadius.circular(40),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.borderColor,
    required this.background,
    required this.text,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final Color borderColor;
  final Color background;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFB05A0D),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _flowBorder),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = option == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  option,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? _flowText : _flowMuted,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9EEF5) : const Color(0xFFF1F4F9),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _flowBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: isSelected ? _flowMutedStrong : _flowMutedStrong,
          ),
        ),
      ),
    );
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview({required this.title, required this.last4});

  final String title;
  final String last4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161F35), Color(0xFF203848)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x260F172A),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -34,
            right: -36,
            child: _GlassBubble(
              size: 150,
              color: const Color(0x3311D493),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preview',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFC5CFDB),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(18),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withAlpha(24)),
                    ),
                    child: const Text(
                      'CARD',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 54),
              Text(
                '••••  ••••  ••••  $last4',
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'monospace',
                  color: Color(0xFFEAF1F8),
                  letterSpacing: 3.2,
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    color: Color(0xFFDCE6F0),
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Add limit + outstanding for utilization insights',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFD2DCE7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustNoticeCard extends StatelessWidget {
  const _TrustNoticeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: _flowCardSoft,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _flowBorder),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, color: _flowMuted, size: 34),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'You can edit or remove this later. No sensitive credentials are required in this demo flow.',
              style: TextStyle(
                fontSize: 16,
                color: _flowMutedStrong,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewMetricCard extends StatelessWidget {
  const _ReviewMetricCard({required this.entry});

  final _ReviewEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: _flowCardSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _flowBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            entry.label,
            style: const TextStyle(
              fontSize: 16,
              color: _flowMuted,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            entry.value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _flowText,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryBottomBar extends StatelessWidget {
  const _PrimaryBottomBar({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xF2F6F8F7),
            border: Border(top: BorderSide(color: Color(0xFFE8EEF6))),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
              child: _PrimaryActionButton(label: label, onTap: onTap),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_flowButtonStart, _flowButtonEnd],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: _flowShadow,
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withAlpha(248),
          side: const BorderSide(color: _flowBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: _flowText,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

class _ReviewEntry {
  const _ReviewEntry(this.label, this.value);

  final String label;
  final String value;
}

class _SectionMeta {
  const _SectionMeta({
    required this.accent,
    required this.softAccent,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.quickSubtitle,
    this.miniTitle = '',
    this.reviewPill = '',
  });

  final Color accent;
  final Color softAccent;
  final IconData icon;
  final String title;
  final String subtitle;
  final String quickSubtitle;
  final String miniTitle;
  final String reviewPill;
}

extension on AddAccountFlowKind {
  _SectionMeta get meta {
    switch (this) {
      case AddAccountFlowKind.bank:
        return const _SectionMeta(
          accent: Color(0xFF2F66E8),
          softAccent: Color(0xFFEAF1FF),
          icon: Icons.account_balance_rounded,
          title: 'Bank',
          miniTitle: 'Bank',
          subtitle: 'Savings / current accounts',
          quickSubtitle: 'Balance & type',
          reviewPill: 'BANK',
        );
      case AddAccountFlowKind.card:
        return const _SectionMeta(
          accent: Color(0xFFBC6206),
          softAccent: Color(0xFFFFF6E5),
          icon: Icons.credit_card_rounded,
          title: 'Credit Card',
          miniTitle: 'Card',
          subtitle: 'Due dates + utilization',
          quickSubtitle: 'Dues & limit',
          reviewPill: 'CARD',
        );
      case AddAccountFlowKind.upi:
        return const _SectionMeta(
          accent: Color(0xFF6D38E7),
          softAccent: Color(0xFFF0EAFF),
          icon: Icons.qr_code_2_rounded,
          title: 'UPI',
          miniTitle: 'UPI',
          subtitle: 'Link bank or card',
          quickSubtitle: 'Linked source',
          reviewPill: 'UPI',
        );
      case AddAccountFlowKind.wallet:
        return const _SectionMeta(
          accent: Color(0xFF1778B6),
          softAccent: Color(0xFFEAF5FF),
          icon: Icons.account_balance_wallet_rounded,
          title: 'Wallet',
          miniTitle: 'Wallet',
          subtitle: 'Paytm / PhonePe etc.',
          quickSubtitle: 'Stored value',
          reviewPill: 'WALLET',
        );
      case AddAccountFlowKind.insurance:
        return const _SectionMeta(
          accent: Color(0xFF10825C),
          softAccent: Color(0xFFE8F8F0),
          icon: Icons.shield_outlined,
          title: 'Insurance',
          miniTitle: 'Insurance',
          subtitle: 'Premiums + renewals',
          quickSubtitle: 'Cover + due',
          reviewPill: 'INSURANCE',
        );
      case AddAccountFlowKind.loan:
        return const _SectionMeta(
          accent: Color(0xFFC71E4A),
          softAccent: Color(0xFFFFEFF3),
          icon: Icons.real_estate_agent_outlined,
          title: 'Loan',
          miniTitle: 'Loan',
          subtitle: 'EMI + outstanding',
          quickSubtitle: 'Liability info',
          reviewPill: 'LOAN',
        );
    }
  }
}
