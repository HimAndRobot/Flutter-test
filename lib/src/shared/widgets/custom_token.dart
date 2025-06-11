import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomToken extends FormField<String> {
  final String label;
  final Function(String) onCodeChanged;

  CustomToken({
    super.key,
    required this.label,
    required this.onCodeChanged,
    super.validator,
    super.onSaved,
  }) : super(
          initialValue: '',
          builder: (FormFieldState<String> state) {
            return _CustomTokenWidget(
              label: label,
              onCodeChanged: onCodeChanged,
              state: state,
            );
          },
        );
}

class _CustomTokenWidget extends StatefulWidget {
  final String label;
  final Function(String) onCodeChanged;
  final FormFieldState<String> state;

  const _CustomTokenWidget({
    required this.label,
    required this.onCodeChanged,
    required this.state,
  });

  @override
  State<_CustomTokenWidget> createState() => _CustomTokenWidgetState();
}

class _CustomTokenWidgetState extends State<_CustomTokenWidget> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(6, (index) => FocusNode());
    controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    String fullCode = controllers.map((e) => e.text).join('');
    widget.onCodeChanged(fullCode);
    widget.state.didChange(fullCode);

    if (value.length == 1) {
      if (index < focusNodes.length - 1) {
        focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty) {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Container(
          width: double.infinity,
          height: 80,
          child: Row(
            children: List.generate(
                6,
                (index) => Expanded(
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 225, 224, 224),
                          borderRadius: BorderRadius.circular(10),
                          border: widget.state.hasError
                              ? Border.all(color: Colors.red)
                              : null,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Focus(
                            onKeyEvent: (node, event) {
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.backspace &&
                                  controllers[index].text.isEmpty &&
                                  index > 0) {
                                focusNodes[index - 1].requestFocus();
                                return KeyEventResult.handled;
                              }
                              return KeyEventResult.ignored;
                            },
                            child: TextFormField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              onChanged: (value) => _onChanged(value, index),
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black),
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
        ),
        if (widget.state.hasError)
          Text(
            widget.state.errorText!,
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
