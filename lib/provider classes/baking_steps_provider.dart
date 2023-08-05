import 'package:flutter/cupertino.dart';
import '../model classes/steps_to_bake.dart';

class BakingStepsProvider with ChangeNotifier{
 static  List<StepsToBake>? _stepsList=[];

   List<StepsToBake>? get stepsList => _stepsList;

   setAll(List<StepsToBake> value){
     _stepsList=value;
   }

   addStep(StepsToBake stepsToBake){
     _stepsList!.add(stepsToBake);
     notifyListeners();
   }
  void clearList(){
     _stepsList!.clear();
     notifyListeners();
   }
   void deleteStep(int index){
     _stepsList!.removeAt(index);
     notifyListeners();
   }
}