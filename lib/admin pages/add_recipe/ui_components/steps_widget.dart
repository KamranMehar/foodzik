import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/steps_template.dart';
import 'package:provider/provider.dart';

import '../../../model classes/steps_to_bake.dart';
import '../../../provider classes/baking_steps_provider.dart';

class StepsWidget extends StatelessWidget {
  StepsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BakingStepsProvider>(
      builder: (context, bakingStepsProvider, _) {
        if (bakingStepsProvider.stepsList!.isEmpty) {
          return const StepsTemplate();
        } else {
          return StepsToBakeWidget(
            stepsToBake: bakingStepsProvider.stepsList,
            onDeleteStep: (index) {
              bakingStepsProvider.deleteStep(index);
            },
          );
        }
      },
    );
  }
}


class StepsToBakeWidget extends StatefulWidget {
  final List<StepsToBake>? stepsToBake;
  final Function(int) onDeleteStep;

  StepsToBakeWidget({
    Key? key,
    required this.stepsToBake,
    required this.onDeleteStep,
  }) : super(key: key);

  @override
  _StepsToBakeWidgetState createState() => _StepsToBakeWidgetState();
}

class _StepsToBakeWidgetState extends State<StepsToBakeWidget> {
  int currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
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
      widget.stepsToBake!.length,
          (index) {
        final step = widget.stepsToBake![index];
        return Step(
          title: Text(step.title ?? ''),
          content: Column(
            children: [
              Text(step.details ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Call the onDeleteStep function to delete the step
                      widget.onDeleteStep(index);
                      _updateCurrentStepIndex(index);
                    },
                  ),
                ],
              ),
            ],
          ),
          isActive: true, // You can set this based on the current step index
          state: StepState.editing, // This enables the delete button for each step
        );
      },
    );
  }

  void _updateCurrentStepIndex(int deletedIndex) {
    setState(() {
      if (currentStepIndex > 0) {
        currentStepIndex -= 1;
      }
      if (deletedIndex <= currentStepIndex) {
        currentStepIndex -= 1;
      }
    });
  }
}


/*

class StepsToBakeWidget extends StatefulWidget {
  final List<StepsToBake>? stepsToBake;
  final Function(int) onDeleteStep;

  StepsToBakeWidget({
    Key? key,
    required this.stepsToBake,
    required this.onDeleteStep,
  }) : super(key: key);

  @override
  _StepsToBakeWidgetState createState() => _StepsToBakeWidgetState();
}

class _StepsToBakeWidgetState extends State<StepsToBakeWidget> {
  int currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
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
    return List.generate(growable: true, widget.stepsToBake!.length, (index) {
      final step = widget.stepsToBake![index];
      return Step(
        title: Text(step.title ?? ''),
        content: Column(
          children: [
            Text(step.details ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Call the onDeleteStep function to delete the step
                    widget.onDeleteStep(index);
                  },
                ),
              ],
            ),
          ],
        ),
        isActive: true, // You can set this based on the current step index
        state: StepState.editing, // This enables the delete button for each step
      );
    });
  }
}
*/
