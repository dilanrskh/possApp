import 'package:flutter/material.dart';
import 'package:possapp/core/components/buttins.dart';
import 'package:possapp/core/components/custom_text_field.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/build_context_ext.dart';
import 'package:possapp/core/extensions/int_ext.dart';
import 'package:possapp/core/extensions/string_ext.dart';
import 'package:possapp/presentation/orders/widgets/payment_success_dialog.dart';

class PaymentCashDialog extends StatefulWidget {
  final int price;
  const PaymentCashDialog({super.key, required this.price});

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  TextEditingController? priceController;
  
  @override
  void initState() {
    priceController = TextEditingController(text: widget.price.currencyFormatRp);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Stack(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.highlight_off),
            color: AppColors.primary,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                'Pembayaran - Tunai',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(16),
          CustomTextField(
            controller: priceController!,
            label: '',
            showLabel: false,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final int priceValue = value.toIntegerFromText;
              priceController!.text = priceValue.currencyFormatRp;
              priceController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: priceController!.text.length));
            },
          ),
          const SpaceHeight(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button.filled(
                onPressed: () {},
                label: 'Uang Pas',
                disabled: true,
                textColor: AppColors.primary,
                fontSize: 13,
                width: 112,
                height: 50,
              ),
              const SpaceWidth(4),
              Flexible(
                child: Button.filled(
                  onPressed: () {},
                  label: widget.price.currencyFormatRp,
                  disabled: true,
                  textColor: AppColors.primary,
                  fontSize: 13,
                  height: 50,
                ),
              ),
            ],
          ),
          const SpaceHeight(30),
          Button.filled(
            onPressed: () {
              context.pop();
              showDialog(
                context: context,
                builder: (context) => const PaymentSuccessDialog(),
              );
            },
            label: 'Proses',
          ),
        ],
      ),
    );
  }
}
