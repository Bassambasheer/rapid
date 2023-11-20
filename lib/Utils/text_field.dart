import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    this.hint = '',
    Key? key,
    this.pass = false,
    this.controller,
    this.value,
    this.insideHint,
    this.lines = 1,
    this.type,
    this.readonly = false,
    this.validator,
    this.capitalization = TextCapitalization.sentences,
    this.length,
    this.formatter,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.action = TextInputAction.next,
    this.onTap,
    this.focusNode,
    this.icon,
    this.fillColor = '#ffffff',
    this.labelIcon,
    this.optional,
    this.onChanged,
  }) : super(key: key);
  final String hint;
  final String? value;
  final String? insideHint;
  final bool pass;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final int? lines;
  final int? length;
  final bool? optional;
  final TextInputAction action;
  final TextCapitalization capitalization;
  final TextInputType? type;
  final bool readonly;
  final Function? validator;
  final String? fillColor;
  final List<TextInputFormatter>? formatter;
  final Widget? icon;
  final Widget? labelIcon;
  final FocusNode? focusNode;
  //ontap
  final VoidCallback? onTap;
  //onchanged
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: true,
      onTap: onTap,
      focusNode: focusNode,
      onChanged: onChanged as void Function(String)?,
      initialValue: value,
      inputFormatters: formatter,
      autovalidateMode: autovalidateMode,
      keyboardType: type,
      textInputAction: action,
      readOnly: readonly,
      controller: controller,
      maxLength: length,
      obscureText: pass,
      maxLines: lines,
      cursorColor: Colors.black,
      showCursor: true,
      cursorWidth: 1,
      cursorHeight: 18,
      textCapitalization: TextCapitalization.sentences,
      enabled: true,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
        ).fontFamily,
      ),
      decoration: InputDecoration(
        // hintText: hint,
        label: RichText(
          text: TextSpan(
            text: hint,
            style: const TextStyle(
                color: Colors.black54, // Change this to your desired text color
                fontWeight: FontWeight.w500,
                fontSize: 14),
            children: [
              optional == true
                  ? const TextSpan()
                  : const TextSpan(
                      text: ' *', // Asterisk with a space
                      style: TextStyle(
                        color: Colors.red, // Red color for asterisk
                      ),
                    ),
            ],
          ),
        ),
        suffixIcon: icon,

        fillColor: HexColor(fillColor!),
        filled: true,
        errorStyle: TextStyle(
          fontSize: 12,
          color: HexColor('#de5151'),
          fontFamily: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
          ).fontFamily,
        ),
        hintStyle: TextStyle(
          color: HexColor('#8e9aa6'),
          fontSize: 14,
          fontFamily: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
          ).fontFamily,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: HexColor('#d5dce0'),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: HexColor('#5374ff'),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: HexColor('#de5151'),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: HexColor('#de5151'),
          ),
        ),
      ),
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        } else {
          return null;
        }
      },
    );
  }
}
