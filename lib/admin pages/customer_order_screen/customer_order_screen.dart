import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/colors.dart';
import '../../provider classes/theme_model.dart';
import '../admin_orders/sub_tabs/dilivered_orders.dart';
import '../admin_orders/sub_tabs/pending_orders.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({super.key});

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final themeModel=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeModel.isDark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackLeadingBtn(),
        centerTitle: true,
        title: Text("Customer Orders",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 18.sp),),
      ),
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
