//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/cupertino.dart';

class RPSCustomPainter extends CustomPainter {
  Color filColor;
  Color stockColor;
  RPSCustomPainter({
    required this.filColor,
    required this.stockColor,
  });
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.03861283,size.height*0.01239252);
    path_0.cubicTo(size.width*0.02138717,size.height*0.04042991,size.width*0.008345133,size.height*0.09415888,size.width*0.002336283,size.height*0.1618224);
    path_0.cubicTo(size.width*0.0008694690,size.height*0.1783271,0,size.height*0.3023645,0,size.height*0.4947570);
    path_0.cubicTo(0,size.height*0.8310841,size.width*0.0005309735,size.height*0.8479252,size.width*0.01329425,size.height*0.9160000);
    path_0.cubicTo(size.width*0.02130752,size.height*0.9587290,size.width*0.03983628,size.height*1.000121,size.width*0.05076549,size.height*0.9996916);
    path_0.cubicTo(size.width*0.05841372,size.height*0.9994019,size.width*0.05830752,size.height*0.9989252,size.width*0.04689381,size.height*0.9822710);
    path_0.cubicTo(size.width*0.02320796,size.height*0.9477103,size.width*0.01381858,size.height*0.8850467,size.width*0.01126327,size.height*0.7445234);
    path_0.cubicTo(size.width*0.008887168,size.height*0.6137850,size.width*0.01027212,size.height*0.3051963,size.width*0.01348894,size.height*0.2485514);
    path_0.cubicTo(size.width*0.01546239,size.height*0.2137850,size.width*0.01873230,size.height*0.1910093,size.width*0.02638053,size.height*0.1587009);
    path_0.cubicTo(size.width*0.03739381,size.height*0.1121682,size.width*0.04902655,size.height*0.09341121,size.width*0.06679867,size.height*0.09351402);
    path_0.cubicTo(size.width*0.08233850,size.height*0.09359813,size.width*0.3229049,size.height*0.2600561,size.width*0.3378805,size.height*0.2810841);
    path_0.cubicTo(size.width*0.3571416,size.height*0.3081308,size.width*0.3697478,size.height*0.3595327,size.width*0.3871681,size.height*0.4820467);
    path_0.cubicTo(size.width*0.4108850,size.height*0.6488318,size.width*0.4283009,size.height*0.7138598,size.width*0.4623894,size.height*0.7628785);
    path_0.cubicTo(size.width*0.4810265,size.height*0.7896729,size.width*0.5225398,size.height*0.7872243,size.width*0.5427279,size.height*0.7581215);
    path_0.cubicTo(size.width*0.5730973,size.height*0.7143551,size.width*0.5954226,size.height*0.6288131,size.width*0.6140841,size.height*0.4847196);
    path_0.cubicTo(size.width*0.6238142,size.height*0.4095981,size.width*0.6381814,size.height*0.3374019,size.width*0.6488805,size.height*0.3098692);
    path_0.cubicTo(size.width*0.6617633,size.height*0.2767196,size.width*0.6771283,size.height*0.2612150,size.width*0.7387788,size.height*0.2191869);
    path_0.cubicTo(size.width*0.7723274,size.height*0.1963084,size.width*0.8211836,size.height*0.1626729,size.width*0.8473451,size.height*0.1444393);
    path_0.cubicTo(size.width*0.9223119,size.height*0.09217757,size.width*0.9318075,size.height*0.08798131,size.width*0.9462765,size.height*0.1008037);
    path_0.cubicTo(size.width*0.9687235,size.height*0.1207009,size.width*0.9821018,size.height*0.1859813,size.width*0.9868628,size.height*0.2988692);
    path_0.cubicTo(size.width*0.9903186,size.height*0.3808598,size.width*0.9884602,size.height*0.7942617,size.width*0.9844137,size.height*0.8436916);
    path_0.cubicTo(size.width*0.9788518,size.height*0.9116168,size.width*0.9630420,size.height*0.9723364,size.width*0.9457965,size.height*0.9920093);
    path_0.cubicTo(size.width*0.9404867,size.height*0.9980654,size.width*0.9412788,size.height*0.9989065,size.width*0.9497611,size.height*0.9962150);
    path_0.cubicTo(size.width*0.9707566,size.height*0.9895701,size.width*0.9936748,size.height*0.8992991,size.width*0.9970575,size.height*0.8099159);
    path_0.cubicTo(size.width*0.9982124,size.height*0.7793925,size.width*0.9988451,size.height*0.7754019,size.width*1.000204,size.height*0.7900561);
    path_0.cubicTo(size.width*1.001137,size.height*0.8001495,size.width*1.001841,size.height*0.6633178,size.width*1.001765,size.height*0.4859813);
    path_0.cubicTo(size.width*1.001690,size.height*0.3086449,size.width*1.000982,size.height*0.1782710,size.width*1.000188,size.height*0.1962617);
    path_0.cubicTo(size.width*0.9987478,size.height*0.2289720,size.width*0.9987478,size.height*0.2289720,size.width*0.9971792,size.height*0.1904206);
    path_0.cubicTo(size.width*0.9932235,size.height*0.09317757,size.width*0.9709071,size.height*0.01061682,size.width*0.9464668,size.height*0.002831776);
    path_0.cubicTo(size.width*0.9248562,size.height*-0.004056075,size.width*0.6626903,size.height*0.1779252,size.width*0.6466504,size.height*0.2109439);
    path_0.cubicTo(size.width*0.6308783,size.height*0.2434112,size.width*0.6189912,size.height*0.3038224,size.width*0.6046659,size.height*0.4242804);
    path_0.cubicTo(size.width*0.5909491,size.height*0.5396449,size.width*0.5765398,size.height*0.6088224,size.width*0.5579336,size.height*0.6486542);
    path_0.cubicTo(size.width*0.5244779,size.height*0.7202710,size.width*0.4752500,size.height*0.7178879,size.width*0.4420133,size.height*0.6430654);
    path_0.cubicTo(size.width*0.4235686,size.height*0.6015327,size.width*0.4094004,size.height*0.5316449,size.width*0.3960951,size.height*0.4165607);
    path_0.cubicTo(size.width*0.3832566,size.height*0.3054953,size.width*0.3690686,size.height*0.2349065,size.width*0.3538938,size.height*0.2065421);
    path_0.cubicTo(size.width*0.3422522,size.height*0.1847944,size.width*0.07459292,size.height*-0.0004485981,size.width*0.05647566,size.height*0.0007102804);
    path_0.cubicTo(size.width*0.05035841,size.height*0.001102804,size.width*0.04232080,size.height*0.006355140,size.width*0.03861283,size.height*0.01239252);
    path_0.moveTo(size.width*0.0009955752,size.height*0.4953271);
    path_0.cubicTo(size.width*0.0009955752,size.height*0.6726636,size.width*0.001292035,size.height*0.7452056,size.width*0.001654867,size.height*0.6565421);
    path_0.cubicTo(size.width*0.002019912,size.height*0.5678692,size.width*0.002019912,size.height*0.4227757,size.width*0.001654867,size.height*0.3341121);
    path_0.cubicTo(size.width*0.001292035,size.height*0.2454393,size.width*0.0009955752,size.height*0.3179907,size.width*0.0009955752,size.height*0.4953271);

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = stockColor;//.withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.03861283,size.height*0.01239252);
    path_1.cubicTo(size.width*0.02138717,size.height*0.04042991,size.width*0.008345133,size.height*0.09415888,size.width*0.002336283,size.height*0.1618224);
    path_1.cubicTo(size.width*0.0008694690,size.height*0.1783271,0,size.height*0.3023645,0,size.height*0.4947570);
    path_1.cubicTo(0,size.height*0.8310841,size.width*0.0005309735,size.height*0.8479252,size.width*0.01329425,size.height*0.9160000);
    path_1.cubicTo(size.width*0.02130752,size.height*0.9587290,size.width*0.03983628,size.height*1.000121,size.width*0.05076549,size.height*0.9996916);
    path_1.cubicTo(size.width*0.05841372,size.height*0.9994019,size.width*0.05830752,size.height*0.9989252,size.width*0.04689381,size.height*0.9822710);
    path_1.cubicTo(size.width*0.02320796,size.height*0.9477103,size.width*0.01381858,size.height*0.8850467,size.width*0.01126327,size.height*0.7445234);
    path_1.cubicTo(size.width*0.008887168,size.height*0.6137850,size.width*0.01027212,size.height*0.3051963,size.width*0.01348894,size.height*0.2485514);
    path_1.cubicTo(size.width*0.01546239,size.height*0.2137850,size.width*0.01873230,size.height*0.1910093,size.width*0.02638053,size.height*0.1587009);
    path_1.cubicTo(size.width*0.03739381,size.height*0.1121682,size.width*0.04902655,size.height*0.09341121,size.width*0.06679867,size.height*0.09351402);
    path_1.cubicTo(size.width*0.08233850,size.height*0.09359813,size.width*0.3229049,size.height*0.2600561,size.width*0.3378805,size.height*0.2810841);
    path_1.cubicTo(size.width*0.3571416,size.height*0.3081308,size.width*0.3697478,size.height*0.3595327,size.width*0.3871681,size.height*0.4820467);
    path_1.cubicTo(size.width*0.4108850,size.height*0.6488318,size.width*0.4283009,size.height*0.7138598,size.width*0.4623894,size.height*0.7628785);
    path_1.cubicTo(size.width*0.4810265,size.height*0.7896729,size.width*0.5225398,size.height*0.7872243,size.width*0.5427279,size.height*0.7581215);
    path_1.cubicTo(size.width*0.5730973,size.height*0.7143551,size.width*0.5954226,size.height*0.6288131,size.width*0.6140841,size.height*0.4847196);
    path_1.cubicTo(size.width*0.6238142,size.height*0.4095981,size.width*0.6381814,size.height*0.3374019,size.width*0.6488805,size.height*0.3098692);
    path_1.cubicTo(size.width*0.6617633,size.height*0.2767196,size.width*0.6771283,size.height*0.2612150,size.width*0.7387788,size.height*0.2191869);
    path_1.cubicTo(size.width*0.7723274,size.height*0.1963084,size.width*0.8211836,size.height*0.1626729,size.width*0.8473451,size.height*0.1444393);
    path_1.cubicTo(size.width*0.9223119,size.height*0.09217757,size.width*0.9318075,size.height*0.08798131,size.width*0.9462765,size.height*0.1008037);
    path_1.cubicTo(size.width*0.9687235,size.height*0.1207009,size.width*0.9821018,size.height*0.1859813,size.width*0.9868628,size.height*0.2988692);
    path_1.cubicTo(size.width*0.9903186,size.height*0.3808598,size.width*0.9884602,size.height*0.7942617,size.width*0.9844137,size.height*0.8436916);
    path_1.cubicTo(size.width*0.9788518,size.height*0.9116168,size.width*0.9630420,size.height*0.9723364,size.width*0.9457965,size.height*0.9920093);
    path_1.cubicTo(size.width*0.9404867,size.height*0.9980654,size.width*0.9412788,size.height*0.9989065,size.width*0.9497611,size.height*0.9962150);
    path_1.cubicTo(size.width*0.9707566,size.height*0.9895701,size.width*0.9936748,size.height*0.8992991,size.width*0.9970575,size.height*0.8099159);
    path_1.cubicTo(size.width*0.9982124,size.height*0.7793925,size.width*0.9988451,size.height*0.7754019,size.width*1.000204,size.height*0.7900561);
    path_1.cubicTo(size.width*1.001137,size.height*0.8001495,size.width*1.001841,size.height*0.6633178,size.width*1.001765,size.height*0.4859813);
    path_1.cubicTo(size.width*1.001690,size.height*0.3086449,size.width*1.000982,size.height*0.1782710,size.width*1.000188,size.height*0.1962617);
    path_1.cubicTo(size.width*0.9987478,size.height*0.2289720,size.width*0.9987478,size.height*0.2289720,size.width*0.9971792,size.height*0.1904206);
    path_1.cubicTo(size.width*0.9932235,size.height*0.09317757,size.width*0.9709071,size.height*0.01061682,size.width*0.9464668,size.height*0.002831776);
    path_1.cubicTo(size.width*0.9248562,size.height*-0.004056075,size.width*0.6626903,size.height*0.1779252,size.width*0.6466504,size.height*0.2109439);
    path_1.cubicTo(size.width*0.6308783,size.height*0.2434112,size.width*0.6189912,size.height*0.3038224,size.width*0.6046659,size.height*0.4242804);
    path_1.cubicTo(size.width*0.5909491,size.height*0.5396449,size.width*0.5765398,size.height*0.6088224,size.width*0.5579336,size.height*0.6486542);
    path_1.cubicTo(size.width*0.5244779,size.height*0.7202710,size.width*0.4752500,size.height*0.7178879,size.width*0.4420133,size.height*0.6430654);
    path_1.cubicTo(size.width*0.4235686,size.height*0.6015327,size.width*0.4094004,size.height*0.5316449,size.width*0.3960951,size.height*0.4165607);
    path_1.cubicTo(size.width*0.3832566,size.height*0.3054953,size.width*0.3690686,size.height*0.2349065,size.width*0.3538938,size.height*0.2065421);
    path_1.cubicTo(size.width*0.3422522,size.height*0.1847944,size.width*0.07459292,size.height*-0.0004485981,size.width*0.05647566,size.height*0.0007102804);
    path_1.cubicTo(size.width*0.05035841,size.height*0.001102804,size.width*0.04232080,size.height*0.006355140,size.width*0.03861283,size.height*0.01239252);
    path_1.moveTo(size.width*0.0009955752,size.height*0.4953271);
    path_1.cubicTo(size.width*0.0009955752,size.height*0.6726636,size.width*0.001292035,size.height*0.7452056,size.width*0.001654867,size.height*0.6565421);
    path_1.cubicTo(size.width*0.002019912,size.height*0.5678692,size.width*0.002019912,size.height*0.4227757,size.width*0.001654867,size.height*0.3341121);
    path_1.cubicTo(size.width*0.001292035,size.height*0.2454393,size.width*0.0009955752,size.height*0.3179907,size.width*0.0009955752,size.height*0.4953271);

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = stockColor;//.withOpacity(0.5);
    canvas.drawPath(path_1,paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.04548230,size.height*0.1051215);
    path_2.cubicTo(size.width*0.03244912,size.height*0.1196636,size.width*0.01683186,size.height*0.1896822,size.width*0.01348894,size.height*0.2485514);
    path_2.cubicTo(size.width*0.01027212,size.height*0.3051963,size.width*0.008887168,size.height*0.6137850,size.width*0.01126327,size.height*0.7445234);
    path_2.cubicTo(size.width*0.01322124,size.height*0.8522710,size.width*0.01732522,size.height*0.8961495,size.width*0.02974779,size.height*0.9422243);
    path_2.cubicTo(size.width*0.04644469,size.height*1.004150,size.width*0.01505088,size.height*1.000477,size.width*0.5045288,size.height*0.9977757);
    path_2.cubicTo(size.width*0.9480088,size.height*0.9953271,size.width*0.9480088,size.height*0.9953271,size.width*0.9571748,size.height*0.9746168);
    path_2.cubicTo(size.width*0.9684159,size.height*0.9492243,size.width*0.9805465,size.height*0.8909065,size.width*0.9844137,size.height*0.8436916);
    path_2.cubicTo(size.width*0.9884602,size.height*0.7942617,size.width*0.9903186,size.height*0.3808598,size.width*0.9868628,size.height*0.2988692);
    path_2.cubicTo(size.width*0.9821018,size.height*0.1859813,size.width*0.9687235,size.height*0.1207009,size.width*0.9462765,size.height*0.1008037);
    path_2.cubicTo(size.width*0.9318075,size.height*0.08798131,size.width*0.9223119,size.height*0.09217757,size.width*0.8473451,size.height*0.1444393);
    path_2.cubicTo(size.width*0.8211836,size.height*0.1626729,size.width*0.7723274,size.height*0.1963084,size.width*0.7387788,size.height*0.2191869);
    path_2.cubicTo(size.width*0.6771283,size.height*0.2612150,size.width*0.6617633,size.height*0.2767196,size.width*0.6488805,size.height*0.3098692);
    path_2.cubicTo(size.width*0.6381814,size.height*0.3374019,size.width*0.6238142,size.height*0.4095981,size.width*0.6140841,size.height*0.4847196);
    path_2.cubicTo(size.width*0.5954226,size.height*0.6288131,size.width*0.5730973,size.height*0.7143551,size.width*0.5427279,size.height*0.7581215);
    path_2.cubicTo(size.width*0.5225398,size.height*0.7872243,size.width*0.4810265,size.height*0.7896729,size.width*0.4623894,size.height*0.7628785);
    path_2.cubicTo(size.width*0.4283009,size.height*0.7138598,size.width*0.4108850,size.height*0.6488318,size.width*0.3871681,size.height*0.4820467);
    path_2.cubicTo(size.width*0.3697478,size.height*0.3595327,size.width*0.3571416,size.height*0.3081308,size.width*0.3378805,size.height*0.2810841);
    path_2.cubicTo(size.width*0.3212257,size.height*0.2577009,size.width*0.08089159,size.height*0.09318692,size.width*0.06526549,size.height*0.09447664);
    path_2.cubicTo(size.width*0.05918142,size.height*0.09498131,size.width*0.05027876,size.height*0.09976636,size.width*0.04548230,size.height*0.1051215);

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = filColor;
    canvas.drawPath(path_2,paint_2_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


}