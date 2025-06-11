import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortunity_app/src/shared/widgets/custom_token.dart';

class TokenPage extends ConsumerStatefulWidget {
  const TokenPage({super.key, required this.formKey, required this.onTokenSaved});
  final GlobalKey<FormState> formKey;
  final Function(String) onTokenSaved;

  @override
  ConsumerState<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends ConsumerState<TokenPage> {

  String? _validateToken(String? value) {
    if (value == null || value.length != 6) {
      return 'Token must be 6 digits';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomToken(
              label: 'Token', 
              onCodeChanged: (code) {},
              validator: _validateToken,
                onSaved: (newValue) {
                 widget.onTokenSaved(newValue ?? '');
               },
            ),
          ],
        ),
      ),
    );
  }
}