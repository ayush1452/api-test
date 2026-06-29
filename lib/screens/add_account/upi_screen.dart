// lib/screens/add_account/upi_screen.dart
// UPI Account — Form (Step 1) → Review (Step 2) → Success

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aa_theme.dart';

class _UpiApp {
  const _UpiApp(this.name, this.sub, this.bg);
  final String name, sub;
  final Color bg;
}

const _kUpiApps = [
  _UpiApp('PhonePe', 'Most popular UPI app in India', Color(0xFF4C1D95)),
  _UpiApp('Google Pay', 'GPay — by Google', Color(0xFF166534)),
  _UpiApp('Paytm', 'Paytm UPI & Wallet', Color(0xFF0369A1)),
  _UpiApp('BHIM', 'By NPCI — official UPI app', Color(0xFF1E3A8A)),
  _UpiApp('Amazon Pay', 'Amazon Pay UPI', Color(0xFF78350F)),
  _UpiApp('iMobile Pay', 'By ICICI Bank', Color(0xFF991B1B)),
  _UpiApp('Other UPI App', 'Enter app manually', Color(0xFF334155)),
];

class UpiScreen extends StatefulWidget {
  const UpiScreen({super.key});

  @override
  State<UpiScreen> createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen> {
  int _step = 1;

  _UpiApp? _app;
  String _linkType = 'Bank';
  final _vpa = TextEditingController();
  String _linked = 'HDFC Bank •••• 4582';
  bool _isDefault = false;

  @override
  void dispose() {
    _vpa.dispose();
    super.dispose();
  }

  void _back() {
    if (_step > 1) setState(() => _step--);
    else Navigator.of(context).pop();
  }

  void _validate() {
    if (_app == null) { _toast('Please select a UPI app'); return; }
    if (_vpa.text.trim().isEmpty || !_vpa.text.contains('@')) {
      _toast('Please enter a valid UPI ID (e.g. name@ybl)');
      return;
    }
    setState(() => _step = 2);
  }

  void _toast(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            margin: const EdgeInsets.all(16)));

  List<String> get _linkedOptions => _linkType == 'Credit Card'
      ? ['HDFC Regalia •••• 8234', 'ICICI Amazon Pay •••• 5671']
      : ['HDFC Bank •••• 4582', 'ICICI Bank •••• 9210', 'Axis Bank •••• 3319'];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 1,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _step--);
      },
      child: Scaffold(
        backgroundColor: aaBg,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0.04, 0), end: Offset.zero)
                  .animate(anim),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey(_step),
            child: _step == 1 ? _form() : _step == 2 ? _review() : _success(),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    // Ensure linked is valid for current type
    if (!_linkedOptions.contains(_linked)) _linked = _linkedOptions.first;

    return Column(children: [
      AATopBar(
        title: 'Add UPI',
        subtitle: 'Link UPI to a bank or credit card',
        onBack: _back,
      ),
      const AAStepBar(current: 1),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // UPI App picker
            AACard(children: [
              const AALabel('UPI App', required: true),
              const SizedBox(height: 5),
              AAPickerBtn(
                label: _app?.name ?? 'Select UPI app',
                isPlaceholder: _app == null,
                onTap: () async {
                  final picked = await Navigator.of(context).push<_UpiApp>(
                    MaterialPageRoute(builder: (_) => _UpiAppPickerScreen()),
                  );
                  if (picked != null) setState(() => _app = picked);
                },
              ),
            ]),
            const SizedBox(height: 13),

            // Link type
            AACard(children: [
              AALabel('Link type'),
              const SizedBox(height: 10),
              _RadioRow(
                title: 'Link to Bank Account',
                subtitle: 'Best for daily payments.',
                badge: 'RECOMMENDED',
                selected: _linkType == 'Bank',
                onTap: () => setState(() {
                  _linkType = 'Bank';
                  _linked = _linkedOptions.first;
                }),
              ),
              const SizedBox(height: 8),
              _RadioRow(
                title: 'Link to Credit Card',
                subtitle: 'Commonly supported for RuPay credit cards.',
                selected: _linkType == 'Credit Card',
                onTap: () => setState(() {
                  _linkType = 'Credit Card';
                  _linked = _linkedOptions.first;
                }),
              ),
              if (_linkType == 'Credit Card') ...[
                const SizedBox(height: 10),
                const AABanner(
                  kind: AABannerKind.amber,
                  icon: Icons.info_outline_rounded,
                  text: 'Ensure your card supports UPI — mostly RuPay credit cards.',
                ),
              ],
            ]),
            const SizedBox(height: 13),

            // VPA + linked account
            AACard(children: [
              AALabel('Primary UPI ID (VPA)', required: true),
              const SizedBox(height: 5),
              AAInput(
                controller: _vpa,
                hint: 'ayush@ybl',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 4),
              Text('Format: username@bankcode  (e.g. ayush@ybl, 9876@paytm)',
                  style: GoogleFonts.dmSans(fontSize: 11, color: aaT3, height: 1.5)),
              const SizedBox(height: 14),
              AALabel(_linkType == 'Credit Card' ? 'Linked credit card' : 'Linked bank account'),
              const SizedBox(height: 5),
              AADropdown(
                value: _linked,
                items: _linkedOptions,
                onChanged: (v) => setState(() => _linked = v ?? _linked),
              ),
              const SizedBox(height: 14),
              AAToggle(
                title: 'Set as default',
                subtitle: 'Use this UPI in quick actions.',
                value: _isDefault,
                onChanged: (v) => setState(() => _isDefault = v),
              ),
            ]),
          ]),
        ),
      ),
      AACtaBar(
        primary: AAPrimaryBtn(
          label: 'Review details',
          icon: Icons.arrow_forward_rounded,
          onTap: _validate,
        ),
      ),
    ]);
  }

  Widget _review() {
    return Column(children: [
      AATopBar(
        title: 'Review',
        subtitle: 'Confirm before adding',
        onBack: _back,
        trailing: TextButton(
          onPressed: _back,
          child: Text('Edit', style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w700, color: aaPT)),
        ),
      ),
      const AAStepBar(current: 2),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
          child: Column(children: [
            AAReviewCard(
              title: '${_app?.name ?? '—'} UPI',
              cells: [
                AAReviewCell('UPI App', _app?.name ?? '—'),
                AAReviewCell('VPA', _vpa.text),
                AAReviewCell('Linked to', _linked),
                AAReviewCell('Link type', _linkType),
                AAReviewCell('Default', _isDefault ? 'Yes' : 'No'),
              ],
            ),
            const SizedBox(height: 13),
            const AATrustNote(),
          ]),
        ),
      ),
      AACtaBar(
        primary: AAPrimaryBtn(
          label: 'Add account',
          icon: Icons.check_circle_rounded,
          onTap: () => setState(() => _step = 3),
        ),
      ),
    ]);
  }

  Widget _success() {
    return Scaffold(
      backgroundColor: aaBg,
      body: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 12, 18, 13),
          decoration: const BoxDecoration(
              color: aaSurf,
              border: Border(bottom: BorderSide(color: aaBdr))),
          child: Row(children: [
            _CloseBtn(onTap: () => Navigator.of(context).pop()),
            const SizedBox(width: 10),
            Text('UPI Added', style: GoogleFonts.dmSans(fontSize: 17, fontWeight: FontWeight.w800, color: aaT1)),
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 40),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: aaSurf, borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: aaBdr, width: 1.5), boxShadow: aaShadow,
                ),
                child: Row(children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: _app?.bg ?? ciPurpleBg,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${_app?.name ?? '—'} UPI', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: aaT1)),
                    Text(_vpa.text, style: GoogleFonts.dmSans(fontSize: 12, color: aaT3)),
                  ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFBBF7D0), width: 1.5),
                    ),
                    child: Text('ACTIVE', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF16A34A))),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              const AASuccessIcon(color: Color(0xFF7C3AED)),
              const SizedBox(height: 20),
              Text('UPI Account Added!', style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w800, color: aaT1, letterSpacing: -0.5)),
              const SizedBox(height: 7),
              Text('Your ${_app?.name ?? 'UPI'} is linked to $_linked and ready to use.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(fontSize: 13, color: aaT3, height: 1.65)),
              const SizedBox(height: 20),
              AACard(padding: const EdgeInsets.symmetric(vertical: 4), children: [
                _SummaryRow('Linked To', _linked),
                _SummaryRow('Default UPI', _isDefault ? 'Set' : 'Not set', highlight: _isDefault),
              ]),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => setState(() => _step = 2),
                child: Text('Made a mistake? Edit this account',
                    style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: aaT3, decoration: TextDecoration.underline)),
              ),
              const SizedBox(height: 20),
              AAPrimaryBtn(label: 'Add Another Account', icon: Icons.add_rounded,
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const UpiScreen()))),
              const SizedBox(height: 10),
              AASecondaryBtn(label: 'Back to Accounts', onTap: () => Navigator.of(context).pop()),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ── UPI App Picker ────────────────────────────────────────────────────────────

class _UpiAppPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aaBg,
      body: Column(children: [
        AATopBar(title: 'Select UPI App', subtitle: 'Choose your UPI app', onBack: () => Navigator.of(context).pop()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              Container(
                decoration: BoxDecoration(color: aaSurf, borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: aaBdr, width: 1.5), boxShadow: aaShadow),
                child: Column(children: _kUpiApps.asMap().entries.map((e) {
                  final app = e.value;
                  final isLast = e.key == _kUpiApps.length - 1;
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(app),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      decoration: BoxDecoration(border: isLast ? null : const Border(bottom: BorderSide(color: aaBdr))),
                      child: Row(children: [
                        Container(width: 34, height: 34,
                            decoration: BoxDecoration(color: app.bg, borderRadius: BorderRadius.circular(9)),
                            child: Center(child: Text(app.name[0], style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white)))),
                        const SizedBox(width: 11),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(app.name, style: GoogleFonts.dmSans(fontSize: 13.5, fontWeight: FontWeight.w600, color: aaT1)),
                          Text(app.sub, style: GoogleFonts.dmSans(fontSize: 10, color: aaT3)),
                        ])),
                        const Icon(Icons.chevron_right_rounded, color: aaBdr2, size: 16),
                      ]),
                    ),
                  );
                }).toList()),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ── Tiny helpers ──────────────────────────────────────────────────────────────

class _RadioRow extends StatelessWidget {
  const _RadioRow({required this.title, required this.subtitle, required this.selected, required this.onTap, this.badge});
  final String title, subtitle;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: aaSurf,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: selected ? aaP : aaBdr, width: 1.5),
          ),
          child: Row(children: [
            Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? const Color(0xFF1A73E8) : aaBdr2, width: 2),
              ),
              child: selected
                  ? Center(child: Container(width: 10, height: 10,
                      decoration: const BoxDecoration(color: Color(0xFF1A73E8), shape: BoxShape.circle)))
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: aaT1)),
              Text(subtitle, style: GoogleFonts.dmSans(fontSize: 11, color: aaT3)),
            ])),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0x0611D493),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: aaP),
                ),
                child: Text(badge!, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: aaPT)),
              ),
          ]),
        ),
      );
}

class _CloseBtn extends StatelessWidget {
  const _CloseBtn({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(width: 36, height: 36,
            decoration: BoxDecoration(color: aaBg, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.close_rounded, color: aaT1, size: 18)));
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value, {super.key, this.highlight = false});
  final String label, value;
  final bool highlight;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: aaBdr))),
        child: Row(children: [
          Expanded(child: Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: aaT3))),
          highlight
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFBBF7D0), width: 1.5),
                  ),
                  child: Text(value, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF16A34A))))
              : Text(value, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: aaT1)),
        ]),
      );
}
