
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oralsync/core/helpers/snackbars.dart';
import 'package:oralsync/core/utils/icon_broken.dart';
import 'package:oralsync/translations/locale_keys.g.dart';
import '../../../../core/utils/colors_palette.dart';
import '../../../../core/utils/styles.dart';

class MultiInputFormField extends StatefulWidget {
  final Function(List<String>) onSave;

  const MultiInputFormField({super.key, required this.onSave});

  @override
  State<MultiInputFormField> createState() => _MultiInputFormFieldState();
}

class _MultiInputFormFieldState extends State<MultiInputFormField> {
  final _textController = TextEditingController();
  final _savedTexts = <String>[];

  void _saveText() {
    if (_textController.text.isNotEmpty) {
      var isTextEnterBefore = _savedTexts.contains(_textController.text);
      if (!isTextEnterBefore) {
        setState(() {
          _savedTexts.add(_textController.text);
          widget.onSave(_savedTexts);
          _textController.text = "";
        });
      } else {
        showCustomSnackBar(
          context,
          msg: LocaleKeys.this_company_has_been_added_before.tr(),
          backgroundColor: ColorsPalette.errorColor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Flexible(
      // width: size.width * .8,
      child: Column(
        children: [
          SizedBox(
            width: size.width * .8,
            child: TextFormField(
              controller: _textController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintStyle: AppStyles.styleSize14,
                fillColor: ColorsPalette.textFormFieldFillColor,
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(IconBroken.Plus),
                  onPressed: _saveText,
                ),
                hintText: LocaleKeys.insurance_companies.tr(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          if (_savedTexts.isNotEmpty)
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 10,
              alignment: WrapAlignment.start,
              children: _savedTexts
                  .map(
                    (text) => Chip(
                      label: Text(text),
                      backgroundColor: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      deleteIcon: const Icon(
                        IconBroken.Close_Square,
                      ),
                      onDeleted: () {
                        setState(() {
                          _savedTexts.removeWhere((element) => element == text);
                          widget.onSave(_savedTexts);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
