import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/colors.dart';
import '../../../provider classes/theme_model.dart';
import '../components/pending_order_tile.dart';

class DeliveredOrders extends StatefulWidget {
  const DeliveredOrders({super.key});

  @override
  State<DeliveredOrders> createState() => _DeliveredOrdersState();
}

class _DeliveredOrdersState extends State<DeliveredOrders> {

  @override
  Widget build(BuildContext context) {

    final ref=FirebaseDatabase.instance.ref("Orders/DeliveredOrders");

    return Scaffold(
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot){
          if(!snapshot.hasData){
            return const Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: CircularProgressIndicator(color: greenPrimary,strokeWidth: 1,)),
            );
          }else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong\nTry again"),);
          }else{
            //if data found
            Map<dynamic, dynamic>? map = snapshot.data!.snapshot
                .value as dynamic;
            List<dynamic> list = [];
            list.clear();
            if(map!=null){
              list = map.values.toList();
              // developer.log(list.toString());
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context,index){
                    return PendingOrderTile(
                        isDelivered: true,
                        recipeMap: list[index]);
                  });
            }else{
              return const Center(child: Text("No Order Found"),);
            }
          }
        },
      ),
    );
  }
}
