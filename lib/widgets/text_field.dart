import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final double initialHeight;
  final double errorHeight;
  final String validationMessage;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatters;
  final RegExp? validationPattern;
  final String patternErrorMessage;
  final double? customWidth;
  final bool isValidationRequired;
  final bool isEnabled;
  final bool isUppercase;
  final Function(VoidCallback)? registerTouchedCallback;
  final Function(String)? onApiCall;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Function(String)? onChange;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.initialHeight = 45,
    this.errorHeight = 65,
    this.validationMessage = 'Field is Required',
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputFormatters,
    this.validationPattern,
    this.patternErrorMessage = 'Invalid input',
    this.customWidth,
    this.isValidationRequired = true,
    this.isUppercase = true,
    this.registerTouchedCallback,
    this.onApiCall,
    this.focusNode,
    this.suffixIcon,
    this.onChange,
  })  : assert(
  !isValidationRequired || registerTouchedCallback != null,
  'registerTouchedCallback must be provided when isValidationRequired is true',
  ),
        super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late double fieldHeight;
  String? errorMessage;
  bool _isTouched = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (widget.isUppercase)
      widget.controller.addListener(_updateTextToUppercase);
    fieldHeight = widget.initialHeight;
    if (widget.isValidationRequired && widget.registerTouchedCallback != null) {
      widget.registerTouchedCallback!(_markTouched);
    }
  }

  void _updateTextToUppercase() {
    if (widget.controller != null &&
        widget.controller!.text != widget.controller!.text.toUpperCase()) {
      widget.controller!.value = widget.controller!.value.copyWith(
        text: widget.controller!.text.toUpperCase(),
        selection:
        TextSelection.collapsed(offset: widget.controller!.text.length),
      );
    }
  }

  void _markTouched() {
    setState(() {
      _isTouched = true;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller?.removeListener(_updateTextToUppercase);
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {
      _isTouched = true;
    });

    if (widget.onChange != null) {
      widget.onChange!(value);
    }

    if (widget.isValidationRequired) {
      final isValid = widget.validationPattern?.hasMatch(value) ?? true;
      setState(() {
        if (value.isEmpty) {
          fieldHeight = widget.errorHeight;
          errorMessage = widget.validationMessage;
        } else if (!isValid) {
          fieldHeight = widget.errorHeight;
          errorMessage = widget.patternErrorMessage;
        } else {
          fieldHeight = widget.initialHeight;
          errorMessage = null;
        }
      });
      Form.of(context)?.validate();
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onApiCall != null) {
        widget.onApiCall!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.customWidth ?? MediaQuery.of(context).size.width;

    return SizedBox(
      height: fieldHeight,
      width: width,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        inputFormatters: widget.inputFormatters,
        focusNode: widget.focusNode,
        enabled: widget.isEnabled,
        validator: widget.isValidationRequired
            ? (value) {
          if (!_isTouched) return null;

          if (value == null || value.isEmpty) {
            setState(() {
              fieldHeight = widget.errorHeight;
              errorMessage = widget.validationMessage;
            });
            return errorMessage;
          }
          if (widget.validationPattern != null &&
              !widget.validationPattern!.hasMatch(value)) {
            setState(() {
              fieldHeight = widget.errorHeight;
              errorMessage = widget.patternErrorMessage;
            });
            return errorMessage;
          }
          setState(() {
            fieldHeight = widget.initialHeight;
            errorMessage = null;
          });
          return null;
        }
            : null,
        onChanged: _onChanged,
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          errorStyle: const TextStyle(height: 0),
          labelText: widget.isValidationRequired
              ? "${widget.labelText}*"
              : widget.labelText,
          floatingLabelBehavior:!widget.isEnabled ? FloatingLabelBehavior.always:null,
          labelStyle: const TextStyle(color: AppColors.textColorPrimary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:
            const BorderSide(color: AppColors.textFieldBorderColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:
            const BorderSide(color: AppColors.textFieldBorderColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:
            const BorderSide(color: AppColors.textFieldBorderColor, width: 0.5),
          ),
          errorText: _isTouched ? errorMessage : null,
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}