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
  late List<bool> isFocused;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(6, (index) => FocusNode());
    controllers = List.generate(6, (index) => TextEditingController());
    isFocused = List.generate(6, (index) => false); // Inicializa a lista
    
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() {
        setState(() {
          isFocused[i] = focusNodes[i].hasFocus;
        });
      });
    }
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
    } else if (value.length == 2) {
      controllers[index].text = controllers[index].text.substring(1, 2);
      if (index < focusNodes.length - 1) {
        focusNodes[index + 1].requestFocus();
      }
    }
  }

  Border? containerBoder(int index) {
    if (focusNodes[index].hasFocus) {
      return Border.all(color: Colors.black);
    }
    if (widget.state.hasError) {
      return Border.all(color: const Color(0xFFFF0073));
    }
    return null;
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 80,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: widget.state.hasError ? const Color(0xFFFFFEDF5) : const Color.fromARGB(255, 225, 224, 224),
                          borderRadius: BorderRadius.circular(10),
                          border: containerBoder(index),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Focus(
                            onKeyEvent: (node, event) {
                              print(controllers[index].text.isEmpty);
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.backspace &&
                                  controllers[index].text.isEmpty &&
                                  index > 0 &&
                                  controllers[index].text.isEmpty) {
                               focusNodes[index - 1].requestFocus();
                               print('backspace');
                                return KeyEventResult.handled;
                              }
                              // se o campo estiver algo e um numero for digitado subistitui o numero
                              return KeyEventResult.ignored;
                            },
                            child: TextFormField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              onChanged: (value) => _onChanged(value, index),
                              onTapOutside: (event) {
                                focusNodes[index].unfocus();
                              },
                              onTap: () {
                                controllers[index].selection = TextSelection.fromPosition(
                                  TextPosition(offset: controllers[index].text.length),
                                );
                              },
                              maxLength: 2,
                              showCursor: false,
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
