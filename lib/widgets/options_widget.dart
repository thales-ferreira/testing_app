// File: lib/widgets/options_widget.dart

import 'package:flutter/material.dart';
import 'package:testing/models/question.dart';

class CustomRadioWidget extends StatefulWidget {
  final List<String> options;
  final Function(int) onOptionSelected;

  const CustomRadioWidget({
    Key? key,
    required this.options,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  _CustomRadioWidgetState createState() => _CustomRadioWidgetState();
}

class _CustomRadioWidgetState extends State<CustomRadioWidget> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        int index = widget.options.indexOf(option);
        return InkWell(
          onTap: () {
            setState(() {
              _selectedOption = index;
              widget.onOptionSelected(_selectedOption);
            });
          },
          child: Container(
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color:
                  _selectedOption == index ? Color(0xff15A4C2) : Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Color(0xff15A4C2)),
            ),
            child: ListTile(
              title: Text(
                option,
                style: TextStyle(
                  color: _selectedOption == index
                      ? (Color(0xffffffff))
                      : Colors.black,
                ),
              ),
              leading: Radio<int>(
                value: index,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                    widget.onOptionSelected(_selectedOption);
                  });
                },
                activeColor: Colors.transparent,
                fillColor: MaterialStateProperty.all(Colors.transparent),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final int selectedAnswer;
  final ValueChanged<int?> onAnswerSelected;
  final Question question;

  const OptionsWidget({
    Key? key,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRadioWidget(
      options: question.answers,
      onOptionSelected: onAnswerSelected,
    );
  }
}
