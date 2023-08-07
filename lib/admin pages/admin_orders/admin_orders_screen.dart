import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/admin_orders/sub_tabs/dilivered_orders.dart';
import 'package:foodzik/admin%20pages/admin_orders/sub_tabs/pending_orders.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/colors.dart';

class AdminOrdersTab extends StatefulWidget {
  const AdminOrdersTab({super.key});

  @override
  State<AdminOrdersTab> createState() => _AdminOrdersTabState();
}

class _AdminOrdersTabState extends State<AdminOrdersTab>  with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final themeModel=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeModel.isDark;

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.transparent, // Set the background color of the TabBar
            child: TabBar(
              controller: _tabController,
              indicatorColor: greenTextColor, // Set the color of the underline
              tabs: [
                Tab(child: Text("Pending Orders",style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    color:isThemeDark?Colors.white:Colors.black,fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),),
                Tab(child: Text("Delivered Orders",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      color:isThemeDark?Colors.white:Colors.black,fontSize: 14),),),
              ],
            ),
          ),
          Expanded(
            child:
            TabBarView(
              controller: _tabController,
              children: const [
                PendingOrderTab(),
                DeliveredOrders(),
              ],
            ),

          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
}
