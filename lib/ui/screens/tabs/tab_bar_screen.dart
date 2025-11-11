import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
@override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    _tabController = TabController(length: 4, vsync: this);


}

@override
  void dispose() {
  _tabController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: const BoxDecoration(),
              dividerColor: Colors.transparent,
              labelColor: AppColors.primary,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              tabs: [
              Text("To do",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Text("In-Process",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Text("Completed",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Text("Canceled",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ]),
          ),
        ),

        /*          // --- Tab content ---
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                about_me(),
                security_tab(),
                Setting_tab(),
                // Center(child: Text('Settings Content')),
              ],
            ),
          ),*/

        Expanded(child:
        TabBarView(
        controller: _tabController,
        children: [
          // about_me(),
          // Text("Invest Page", style: TextStyle(fontSize: 22)),
          Center(child:  Text("Basic TabDeisign - Invest Page", style: TextStyle(fontSize: 22))),
          Center(child: Text('Basic TabDeisign - Practice Purpose', style: TextStyle(fontSize: 22))),
          Center(child: Text('Basic TabDeisign - Test Page', style: TextStyle(fontSize: 22))),
          Center(child: Text('Basic TabDeisign - Test Page', style: TextStyle(fontSize: 22))),


        ]))
      ],
    );
  }
}
