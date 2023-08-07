import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/admin_orders/components/pending_order_tile.dart';
import 'package:foodzik/const/colors.dart';
import 'dart:developer' as developer show log;


class PendingOrderTab extends StatefulWidget {
  const PendingOrderTab({super.key});

  @override
  State<PendingOrderTab> createState() => _PendingOrderTabState();
}

class _PendingOrderTabState extends State<PendingOrderTab> {


  @override
  Widget build(BuildContext context) {
    final ref=FirebaseDatabase.instance.ref("Orders/PendingOrders");

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
                    return PendingOrderTile(recipeMap: list[index]);
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
