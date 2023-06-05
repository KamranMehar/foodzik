import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/steps_template.dart';
import 'package:provider/provider.dart';

import '../../../model classes/steps_to_bake.dart';
import '../../../provider classes/baking_steps_provider.dart';

class StepsWidget extends StatelessWidget {
  StepsWidget({super.key,});
  @override
  Widget build(BuildContext context) {
    return Consumer<BakingStepsProvider>(
      builder: (context, bakingStepsProvider, _) {
        if (bakingStepsProvider.stepsList!.isEmpty) {
          return const StepsTemplate(); // Replace with your desired widget when there are no steps
        } else {
          return StepsToBakeWidget(stepsToBake: bakingStepsProvider.stepsList);
        }
      },
    );
  }
}

class StepsToBakeWidget extends StatefulWidget {
  final List<StepsToBake>? stepsToBake;

  StepsToBakeWidget({Key? key, required this.stepsToBake}) : super(key: key);

  @override
  _StepsToBakeWidgetState createState() => _StepsToBakeWidgetState();
}

class _StepsToBakeWidgetState extends State<StepsToBakeWidget> {
  int currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics:const NeverScrollableScrollPhysics(),
      key: Key("Steper_key${widget.stepsToBake!.length}"),
      steps: _buildSteps(),
      currentStep: currentStepIndex,
      onStepContinue: () {
        setState(() {
          if (currentStepIndex < widget.stepsToBake!.length - 1) {
            currentStepIndex += 1;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (currentStepIndex > 0) {
            currentStepIndex -= 1;
          }
        });
      },
    );
  }

  List<Step> _buildSteps() {
    return List.generate(
        growable: true,
        widget.stepsToBake!.length, (index) {
      final step = widget.stepsToBake![index];
      return Step(
        title: Text(step.title ?? ''),
        content: Text(step.details ?? ''),
        isActive: true, // You can set this based on the current step index
      );
    });
  }
}
