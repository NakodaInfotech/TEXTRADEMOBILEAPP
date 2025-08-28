import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/Items/ItemDetailScreen/ItemDetailController.dart';
import 'package:textrade/Items/ItemDetailScreen/SummaryScreen.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen>
    with TickerProviderStateMixin {
  var itemDetailController = Get.put(ItemDetailScreenController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
          child: Column(
        children: [
          monthView(context),
          const Expanded(child: MyStatelessWidget())
        ],
      )),
    );
  }

  Widget monthView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 80,
      color: appColor,
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: Colors.black,
            size: 40,
          ),
          const SizedBox(
            width: 8,
          ),
          GetX<ItemDetailScreenController>(builder: (controller) {
            return Text(controller.selectedDate.value);
          })
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: Text(itemDetailController.itemTable?.iTEMNAME ?? ""),
      elevation: 0,
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color.fromRGBO(226, 187, 100, 1),
            tabs: <Widget>[
              Tab(
                text: "SUMMARY",
              ),
              Tab(
                text: "CUSTOMERS",
              ),
              Tab(
                text: "SUPPLIES",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SummaryScreen(),
            CustomerScreen(),
            SupplierView(),
          ],
        ),
      ),
    );
  }
}
