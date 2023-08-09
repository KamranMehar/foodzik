import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowToBakeTab extends StatefulWidget {
  final List<Map<dynamic, dynamic>> stepList;


  const HowToBakeTab({Key? key, required this.stepList}) : super(key: key);

  @override
  State<HowToBakeTab> createState() => _HowToBakeTabState();
}

class _HowToBakeTabState extends State<HowToBakeTab> {
  int currentIndex = 0;

  void goToNextStep() {
    if (currentIndex < widget.stepList.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void goToPreviousStep() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }


  void continueToNext() {
    if (currentIndex < widget.stepList.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Perform any action when all steps are completed
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.stepList[currentIndex];
    final isLastStep = currentIndex == widget.stepList.length - 1;

    return SingleChildScrollView(
      child: Column(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Stepper(
              currentStep: currentIndex,
              physics: const NeverScrollableScrollPhysics(),
              controlsBuilder: (context, details){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: currentIndex == 0 ? null : goToPreviousStep,
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: isLastStep ? null : continueToNext,
                      child: Text(isLastStep ? 'Finish' : 'Continue'),
                    ),
                  ],
                );
              },
              steps: widget.stepList
                  .map(
                    (step) => Step(
                  title: Text(
                    '${step['title']}',
                    style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                  subtitle: Text(step['details'],style: GoogleFonts.abel(fontSize: 16),),
                  content: const SizedBox.shrink(),
                  isActive: widget.stepList.indexOf(step) <= currentIndex,
                  state: widget.stepList.indexOf(step) == currentIndex
                      ? StepState.editing
                      : StepState.complete,
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
