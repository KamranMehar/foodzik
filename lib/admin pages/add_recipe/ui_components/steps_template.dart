import 'package:flutter/material.dart';

class StepsTemplate extends StatefulWidget {
  const StepsTemplate({Key? key}) : super(key: key);

  @override
  State<StepsTemplate> createState() => _StepsTemplateState();
}

class _StepsTemplateState extends State<StepsTemplate> {
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          isActive: true,
          title: const Text('Title'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Detail...'),
          ),
        ),
        const Step(
          isActive: true,
          title: Text('Title 2'),
          content: Text('Detail...'),
        ),
      ],
    );
  }
}
