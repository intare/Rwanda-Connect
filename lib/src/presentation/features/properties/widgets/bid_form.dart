import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/repositories/property_repository_impl.dart';
import '../../../../domain/entities/property.dart';
import '../../../../domain/repositories/property_repository.dart';

/// Form widget for placing a bid on a property.
class BidForm extends ConsumerStatefulWidget {
  const BidForm({
    super.key,
    required this.property,
    required this.onBidPlaced,
  });

  final Property property;
  final VoidCallback onBidPlaced;

  @override
  ConsumerState<BidForm> createState() => _BidFormState();
}

class _BidFormState extends ConsumerState<BidForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitBid() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    final amount = double.parse(_amountController.text.replaceAll(',', ''));
    final message = _messageController.text.trim();

    final repository = ref.read(propertyRepositoryProvider);
    final result = await repository.placeBid(
      widget.property.id,
      amount,
      message: message.isEmpty ? null : message,
    );

    if (!mounted) return;

    switch (result) {
      case PropertySuccess():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bid placed successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        widget.onBidPlaced();
      case PropertyFailure(:final message):
        setState(() {
          _error = message;
          _isSubmitting = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Place a Bid',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Listed price: ${widget.property.formattedPrice}',
            style: AppTypography.bodySmallSecondary,
          ),
          const SizedBox(height: AppSpacing.md),

          // Amount field
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Bid Amount',
              prefixText: 'RWF ',
              hintText: 'Enter your bid amount',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a bid amount';
              }
              final amount = double.tryParse(value.replaceAll(',', ''));
              if (amount == null || amount <= 0) {
                return 'Please enter a valid amount';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),

          // Message field
          TextFormField(
            controller: _messageController,
            maxLines: 3,
            maxLength: 500,
            decoration: const InputDecoration(
              labelText: 'Message (Optional)',
              hintText: 'Add a message to the property owner...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Error message
          if (_error != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.danger,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _error!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Submit button
          FilledButton(
            onPressed: _isSubmitting ? null : _submitBid,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Submit Bid'),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet for placing a bid.
class BidBottomSheet extends StatelessWidget {
  const BidBottomSheet({
    super.key,
    required this.property,
    required this.onBidPlaced,
  });

  final Property property;
  final VoidCallback onBidPlaced;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Form
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SafeArea(
              child: BidForm(
                property: property,
                onBidPlaced: () {
                  Navigator.pop(context);
                  onBidPlaced();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows the bid bottom sheet.
Future<void> showBidBottomSheet(
  BuildContext context, {
  required Property property,
  required VoidCallback onBidPlaced,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BidBottomSheet(
        property: property,
        onBidPlaced: onBidPlaced,
      ),
    ),
  );
}
