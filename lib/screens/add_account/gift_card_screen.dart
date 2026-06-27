// lib/screens/add_account/gift_card_screen.dart
// Add Account → Gift Cards & Coupons (3-step flow)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aa_theme.dart';

// ── Data ──────────────────────────────────────────────────────────────────────

class _Brand {
  const _Brand(this.name, this.color, this.icon);
  final String name;
  final Color color;
  final IconData icon;
}

const _kBrands = [
  _Brand('Amazon', Color(0xFFFF9900), Icons.shopping_bag_rounded),
  _Brand('Flipkart', Color(0xFF2874F0), Icons.shopping_cart_rounded),
  _Brand('Myntra', Color(0xFFFF3F6C), Icons.checkroom_rounded),
  _Brand('Swiggy', Color(0xFFFC8019), Icons.restaurant_rounded),
  _Brand('Zomato', Color(0xFFE23744), Icons.lunch_dining_rounded),
  _Brand('PhonePe', Color(0xFF5F259F), Icons.qr_code_rounded),
  _Brand('Nykaa', Color(0xFFFC2779), Icons.face_rounded),
  _Brand('Croma', Color(0xFF00843D), Icons.devices_rounded),
  _Brand("McDonald's", Color(0xFFDA291C), Icons.fastfood_rounded),
  _Brand('BookMyShow', Color(0xFFE02020), Icons.movie_rounded),
  _Brand('MakeMyTrip', Color(0xFF0D2B58), Icons.flight_rounded),
  _Brand('Ola', Color(0xFF23B14D), Icons.local_taxi_rounded),
  _Brand('Uber', Color(0xFF000000), Icons.local_taxi_rounded),
  _Brand('Other', Color(0xFF455A52), Icons.card_giftcard_rounded),
];

const _kCardTypes = ['Gift Card', 'Coupon Code', 'Voucher', 'Store Credit', 'Cashback'];

// ── Screen ────────────────────────────────────────────────────────────────────

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  int _step = 1;

  _Brand? _brand;
  String _customBrand = '';
  String _cardType = 'Gift Card';
  final _balCtrl = TextEditingController();
  final _originalCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _nickCtrl = TextEditingController();
  DateTime? _expiryDate;
  bool _expiryReminder = true;
  int _reminderDays = 7;
  bool _showPin = false;

  @override
  void dispose() {
    _balCtrl.dispose();
    _originalCtrl.dispose();
    _codeCtrl.dispose();
    _pinCtrl.dispose();
    _nickCtrl.dispose();
    super.dispose();
  }

  bool get _canProceed =>
      _brand != null &&
      (_brand!.name != 'Other' || _customBrand.trim().isNotEmpty) &&
      _balCtrl.text.trim().isNotEmpty;

  String get _displayBrand =>
      _brand?.name == 'Other' && _customBrand.trim().isNotEmpty
          ? _customBrand.trim()
          : (_brand?.name ?? '—');

  Color get _brandColor => _brand?.color ?? ciAmberIcon;

  double? get _usedPercent {
    final original = double.tryParse(_originalCtrl.text.trim());
    final balance = double.tryParse(_balCtrl.text.trim());
    if (original == null || balance == null || original <= 0) return null;
    final used = original - balance;
    if (used < 0) return null;
    return (used / original).clamp(0.0, 1.0);
  }

  Future<void> _pickExpiry() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? now.add(const Duration(days: 90)),
      firstDate: now,
      lastDate: DateTime(now.year + 10),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: aaP),
        ),
        child: child!,
      ),
    );
    if (d != null) setState(() => _expiryDate = d);
  }

  Future<void> _pickBrand() async {
    final result = await Navigator.of(context).push<_Brand>(
      MaterialPageRoute(builder: (_) => _BrandPickerScreen(selected: _brand)),
    );
    if (result != null) setState(() => _brand = result);
  }

  void _next() {
    if (_step == 1 && !_canProceed) return;
    setState(() => _step++);
  }

  void _back() {
    if (_step > 1) setState(() => _step--);
    else Navigator.of(context).maybePop();
  }

  bool get _isExpiringSoon {
    if (_expiryDate == null) return false;
    final diff = _expiryDate!.difference(DateTime.now()).inDays;
    return diff >= 0 && diff <= 30;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 1,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        backgroundColor: aaBg,
        body: Column(children: [
          AATopBar(
            title: switch (_step) {
              2 => 'Review Card',
              3 => 'Card Added!',
              _ => 'Gift Card & Coupons',
            },
            subtitle: switch (_step) {
              2 => 'Check before saving',
              3 => 'Your voucher is tracked',
              _ => 'Track vouchers & rewards',
            },
            onBack: _back,
            trailing: _step < 3 ? const AADarkBtn() : null,
          ),
          if (_step < 3) AAStepBar(current: _step, total: 2),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.04),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: switch (_step) {
                2 => _ReviewStep(key: const ValueKey(2), state: this),
                3 => _SuccessStep(key: const ValueKey(3), state: this),
                _ => _FormStep(key: const ValueKey(1), state: this),
              },
            ),
          ),
          if (_step == 1)
            AACtaBar(
              primary: AAPrimaryBtn(
                label: 'Review Details',
                onTap: _canProceed ? _next : null,
              ),
              secondary: AASecondaryBtn(
                label: 'Cancel',
                onTap: () => Navigator.of(context).maybePop(),
              ),
            ),
          if (_step == 2)
            AACtaBar(
              primary: AAPrimaryBtn(label: 'Add Card', onTap: _next),
              secondary: AASecondaryBtn(label: 'Edit', onTap: _back),
            ),
        ]),
      ),
    );
  }
}

// ── Step 1: Form ──────────────────────────────────────────────────────────────

class _FormStep extends StatelessWidget {
  const _FormStep({super.key, required this.state});
  final _GiftCardScreenState state;

  @override
  Widget build(BuildContext context) {
    final s = state;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AACueCard(
          icon: Icons.card_giftcard_rounded,
          iconColor: ciAmberIcon,
          text: 'Store gift cards, coupon codes, and vouchers with expiry reminders.',
        ),
        const SizedBox(height: 16),

        // Brand & Type
        AACard(children: [
          const AALabel('Brand / Store', required: true),
          const SizedBox(height: 8),
          AAPickerBtn(
            label: s._brand == null ? 'Select brand' : s._displayBrand,
            onTap: s._pickBrand,
          ),
          if (s._brand?.name == 'Other') ...[
            const SizedBox(height: 12),
            const AALabel('Brand Name', required: true),
            const SizedBox(height: 8),
            AAInput(
              hint: 'e.g. Blinkit',
              onChanged: (v) => s.setState(() => s._customBrand = v),
            ),
          ],
          const SizedBox(height: 12),
          const AALabel('Card Type'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: _kCardTypes.map((t) {
              final sel = s._cardType == t;
              return GestureDetector(
                onTap: () => s.setState(() => s._cardType = t),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: sel ? aaP.withOpacity(0.1) : aaBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: sel ? aaP : aaBdr,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    t,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: sel ? aaP : aaT2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ]),
        const SizedBox(height: 12),

        // Balance
        AACard(children: [
          const AALabel('Current Balance / Value', required: true),
          const SizedBox(height: 8),
          AAInput(
            hint: '0.00',
            controller: s._balCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
            prefix: Text('₹', style: GoogleFonts.dmSans(fontSize: 14, color: aaT2)),
            onChanged: (_) => s.setState(() {}),
          ),
          if (s._balCtrl.text.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              fmtCurrency(s._balCtrl.text.trim()),
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: ciAmberIcon,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 12),
          const AALabel('Original Value (optional)'),
          const SizedBox(height: 8),
          AAInput(
            hint: '0.00',
            controller: s._originalCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
            prefix: Text('₹', style: GoogleFonts.dmSans(fontSize: 14, color: aaT2)),
            onChanged: (_) => s.setState(() {}),
          ),
          // Usage bar
          if (s._usedPercent != null) ...[
            const SizedBox(height: 10),
            Row(children: [
              Text(
                '${(s._usedPercent! * 100).toStringAsFixed(0)}% used',
                style: GoogleFonts.dmSans(fontSize: 11, color: aaT3),
              ),
              const Spacer(),
              Text(
                '₹${(double.parse(s._originalCtrl.text) - double.parse(s._balCtrl.text)).toStringAsFixed(0)} spent',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: aaT3,
                ),
              ),
            ]),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: s._usedPercent,
                backgroundColor: aaBdr,
                valueColor: AlwaysStoppedAnimation<Color>(
                  s._usedPercent! > 0.8 ? ciRoseIcon : ciAmberIcon,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ]),
        const SizedBox(height: 12),

        // Code & PIN
        AACard(children: [
          const AALabel('Card / Coupon Code'),
          const SizedBox(height: 8),
          AAInput(
            hint: 'e.g. AMZN-XXXX-XXXX-XXXX',
            controller: s._codeCtrl,
            inputFormatters: [UpperCaseTextFormatter()],
          ),
          const SizedBox(height: 12),
          Row(children: [
            const Expanded(child: AALabel('PIN (optional)')),
            GestureDetector(
              onTap: () => s.setState(() => s._showPin = !s._showPin),
              child: Text(
                s._showPin ? 'Hide' : 'Show',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: aaP,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 8),
          AAInput(
            hint: '****',
            controller: s._pinCtrl,
            obscureText: !s._showPin,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ]),
        const SizedBox(height: 12),

        // Nickname & Expiry
        AACard(children: [
          const AALabel('Nickname (optional)'),
          const SizedBox(height: 8),
          AAInput(
            hint: s._brand != null ? 'e.g. ${s._displayBrand} Birthday Gift' : 'e.g. Amazon Gift Card',
            controller: s._nickCtrl,
          ),
          const SizedBox(height: 12),
          const AALabel('Expiry Date'),
          const SizedBox(height: 8),
          AAPickerBtn(
            label: s._expiryDate != null
                ? _fmtDate(s._expiryDate!)
                : 'Select expiry date',
            icon: Icons.calendar_today_rounded,
            onTap: s._pickExpiry,
          ),
          if (s._expiryDate != null && s._isExpiringSoon) ...[
            const SizedBox(height: 8),
            AABanner(
              kind: AABannerKind.amber,
              icon: Icons.warning_amber_rounded,
              text: 'This card expires in ${s._expiryDate!.difference(DateTime.now()).inDays} days. Use it soon!',
            ),
          ],
        ]),
        const SizedBox(height: 12),

        // Expiry Reminder
        AACard(children: [
          AAToggle(
            title: 'Expiry Reminder',
            subtitle: 'Get notified before this card expires',
            value: s._expiryReminder,
            onChanged: (v) => s.setState(() => s._expiryReminder = v),
          ),
          if (s._expiryReminder) ...[
            const SizedBox(height: 12),
            const AALabel('Remind me before'),
            const SizedBox(height: 8),
            AADropdown(
              value: s._reminderDays.toString(),
              items: const ['3', '7', '14', '30'],
              onChanged: (v) =>
                  s.setState(() => s._reminderDays = int.parse(v!)),
            ),
            const SizedBox(height: 4),
            Text(
              '${s._reminderDays} days before expiry',
              style: GoogleFonts.dmSans(fontSize: 11, color: aaT3),
            ),
          ],
        ]),
        const SizedBox(height: 16),
        const AASecurityNote(),
      ]),
    );
  }
}

// ── Step 2: Review ────────────────────────────────────────────────────────────

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({super.key, required this.state});
  final _GiftCardScreenState state;

  @override
  Widget build(BuildContext context) {
    final s = state;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Gift card visual
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                s._brandColor.withOpacity(0.8),
                s._brandColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: s._brandColor.withOpacity(0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(
                s._brand?.icon ?? Icons.card_giftcard_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                s._cardType,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (s._expiryDate != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Exp: ${_fmtDateShort(s._expiryDate!)}',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ]),
            const SizedBox(height: 10),
            Text(
              s._displayBrand,
              style: GoogleFonts.dmSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              fmtCurrency(s._balCtrl.text.trim()),
              style: GoogleFonts.dmSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            Text(
              'Balance',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            if (s._codeCtrl.text.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  s._codeCtrl.text.trim(),
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ]),
        ),
        const SizedBox(height: 20),

        AAReviewCard(
          title: 'Card Details',
          cells: [
            AAReviewCell('Brand', s._displayBrand),
            AAReviewCell('Type', s._cardType),
            AAReviewCell('Balance', fmtCurrency(s._balCtrl.text.trim())),
            if (s._originalCtrl.text.trim().isNotEmpty)
              AAReviewCell('Original Value', fmtCurrency(s._originalCtrl.text.trim())),
            if (s._codeCtrl.text.trim().isNotEmpty)
              AAReviewCell('Code', s._codeCtrl.text.trim()),
            if (s._expiryDate != null)
              AAReviewCell('Expires', _fmtDate(s._expiryDate!)),
            if (s._nickCtrl.text.trim().isNotEmpty)
              AAReviewCell('Nickname', s._nickCtrl.text.trim()),
            AAReviewCell(
              'Expiry Reminder',
              s._expiryReminder ? '${s._reminderDays} days before' : 'Off',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const AATrustNote(),
      ]),
    );
  }
}

// ── Step 3: Success ───────────────────────────────────────────────────────────

class _SuccessStep extends StatelessWidget {
  const _SuccessStep({super.key, required this.state});
  final _GiftCardScreenState state;

  @override
  Widget build(BuildContext context) {
    final s = state;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: AASuccessIcon(color: ciAmberIcon)),
        const SizedBox(height: 20),
        Center(
          child: Column(children: [
            Text(
              '${s._displayBrand} Card Added!',
              style: GoogleFonts.dmSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: aaT1,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your ${s._cardType.toLowerCase()} worth ${fmtCurrency(s._balCtrl.text.trim())} is saved',
              style: GoogleFonts.dmSans(fontSize: 13, color: aaT3),
              textAlign: TextAlign.center,
            ),
          ]),
        ),
        const SizedBox(height: 28),

        if (s._expiryDate != null && s._isExpiringSoon) ...[
          AABanner(
            kind: AABannerKind.amber,
            icon: Icons.warning_amber_rounded,
            text: 'This card expires in ${s._expiryDate!.difference(DateTime.now()).inDays} days. Don\'t forget to use it!',
          ),
          const SizedBox(height: 16),
        ],

        AACard(children: [
          _Row(
            s._brand?.icon ?? Icons.card_giftcard_rounded,
            'Brand',
            s._displayBrand,
            iconColor: s._brandColor,
          ),
          _Row(Icons.category_rounded, 'Type', s._cardType),
          _Row(Icons.payments_rounded, 'Balance',
              fmtCurrency(s._balCtrl.text.trim()), iconColor: ciAmberIcon),
          if (s._codeCtrl.text.trim().isNotEmpty)
            _Row(Icons.qr_code_rounded, 'Code', s._codeCtrl.text.trim()),
          if (s._expiryDate != null)
            _Row(Icons.event_rounded, 'Expires', _fmtDate(s._expiryDate!)),
          _Row(
            s._expiryReminder
                ? Icons.notifications_active_rounded
                : Icons.notifications_off_rounded,
            'Reminder',
            s._expiryReminder ? '${s._reminderDays} days before' : 'Off',
            iconColor: s._expiryReminder ? aaP : aaT3,
          ),
        ]),
        const SizedBox(height: 28),

        SizedBox(
          width: double.infinity,
          child: AAPrimaryBtn(
            label: '+ Add Another Card',
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: AASecondaryBtn(
            label: 'Back to Accounts',
            onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
          ),
        ),
      ]),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.label, this.value, {this.iconColor = aaT3});
  final IconData icon;
  final String label, value;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 10),
          Text(label,
              style: GoogleFonts.dmSans(fontSize: 13, color: aaT3)),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: aaT1,
              ),
            ),
          ),
        ]),
      );
}

// ── Brand Picker ──────────────────────────────────────────────────────────────

class _BrandPickerScreen extends StatefulWidget {
  const _BrandPickerScreen({this.selected});
  final _Brand? selected;

  @override
  State<_BrandPickerScreen> createState() => _BrandPickerScreenState();
}

class _BrandPickerScreenState extends State<_BrandPickerScreen> {
  String _q = '';

  List<_Brand> get _filtered => _kBrands
      .where((b) => b.name.toLowerCase().contains(_q.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aaBg,
      body: Column(children: [
        AATopBar(
          title: 'Select Brand',
          subtitle: 'Choose a store or brand',
          onBack: () => Navigator.of(context).pop(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: AAInput(
            hint: 'Search brands…',
            prefix: const Icon(Icons.search_rounded, color: aaT3, size: 18),
            onChanged: (v) => setState(() => _q = v),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _filtered.isEmpty
              ? Center(
                  child: Text('No brand found',
                      style: GoogleFonts.dmSans(color: aaT3)),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: _filtered.length,
                  itemBuilder: (_, i) {
                    final b = _filtered[i];
                    final selected = widget.selected?.name == b.name;
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pop(b),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected ? aaP.withOpacity(0.06) : aaSurf,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected ? aaP : aaBdr,
                            width: 1.5,
                          ),
                          boxShadow: aaShadow,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: b.color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(b.icon, color: b.color, size: 20),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              b.name,
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: selected ? aaP : aaT1,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ]),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

String _fmtDate(DateTime d) =>
    '${d.day} ${_months[d.month - 1]} ${d.year}';

String _fmtDateShort(DateTime d) =>
    '${_months[d.month - 1]} \'${d.year.toString().substring(2)}';

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) =>
      newValue.copyWith(text: newValue.text.toUpperCase());
}
