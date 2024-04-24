import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
      setState(() {
        _savedTexts.add(_textController.text);
        widget.onSave(_savedTexts);
        _textController.text = "";
      });
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
                    (text) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(text),
                          IconButton(
                            onPressed: () {
                              _savedTexts
                                  .removeWhere((element) => element == text);
                              setState(() {});
                            },
                            icon: const Icon(
                              IconBroken.Close_Square,
                            ),
                          )
                        ],
                      ),
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
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }
}
