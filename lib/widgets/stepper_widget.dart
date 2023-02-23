import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  StepperWidget({
    super.key,
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.value,
    required this.onChanged,
  });

  final int lowerLimit, upperLimit, stepValue;
  int value;
  final ValueChanged<dynamic> onChanged;

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;

                widget.onChanged(widget.value);
              });
            },
            icon: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 24,
            child: Text(
              '${widget.value}',
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.value = widget.value == widget.upperLimit
                    ? widget.upperLimit
                    : widget.value += widget.stepValue;
              });
              widget.onChanged(widget.value);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
