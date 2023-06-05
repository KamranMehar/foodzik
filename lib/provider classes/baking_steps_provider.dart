import 'package:flutter/cupertino.dart';
import '../model classes/steps_to_bake.dart';

class BakingStepsProvider with ChangeNotifier{
 static  List<StepsToBake>? _stepsList=[];

   List<StepsToBake>? get stepsList => _stepsList;

   addStep(StepsToBake stepsToBake){
     _stepsList!.add(stepsToBake);
     notifyListeners();
   }
  void clearList(){
     _stepsList!.clear();
     notifyListeners();
   }
}