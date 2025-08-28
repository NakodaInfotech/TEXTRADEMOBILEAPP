import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/PartyDetail/PartyDetailController.dart';

class PartyDetailScreen extends StatefulWidget {
  PartyDetailScreen({super.key});

  @override
  State<PartyDetailScreen> createState() => _PartyDetailScreenState();
}

class _PartyDetailScreenState extends State<PartyDetailScreen> {
  var partyDetailController = Get.put(PartyDetailController());

  ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          InkWell(
              onTap: () {
                partyDetailController.selectDateTimeRage(context);
              },
              child: monthView(context)),
          const Expanded(child: PartyDetailScreenTabBar()),
        ],
      ),
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
          GetX<PartyDetailController>(builder: (controller) {
            return Text(controller.selectedDate.value);
          })
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: appColor,
      title: Text(partyDetailController.ledger.nAME ?? ""),
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: () {
              partyDetailController.getGeneratedPdfLink();
            },
            child: const Icon(Icons.share),
          ),
        )
      ],
    );
  }
}

class PartyDetailScreenTabBar extends StatefulWidget {
  const PartyDetailScreenTabBar({super.key});

  @override
  State<PartyDetailScreenTabBar> createState() =>
      _PartyDetailScreenTabBarState();
}

class _PartyDetailScreenTabBarState extends State<PartyDetailScreenTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
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
                text: "Ledger",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[PartyDetailSummary(), LedgerDetailGrid()],
        ),
      ),
    );
  }
}

class PartyDetailSummary extends StatelessWidget {
  const PartyDetailSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<PartyDetailController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.partyDetailResponse.value.table?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                onTap: () {},
                child: salesViewItems(controller, index),
              ),
              const Divider()
            ],
          );
        },
      );
    });
  }

  Widget salesViewItems(
      PartyDetailController partyDetailController, int index) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Text(
            partyDetailController
                    .partyDetailResponse.value.table?[index].aCCTYPE ??
                "",
            style: (partyDetailController.partyDetailResponse.value
                                .table?[index].aCCTYPE ??
                            "") ==
                        "OPENING" ||
                    (partyDetailController.partyDetailResponse.value
                                .table?[index].aCCTYPE ??
                            "") ==
                        "CLOSING"
                ? const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)
                : const TextStyle(fontSize: 17),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "${partyDetailController.partyDetailResponse.value.table?[index].aMT.toStringAsFixed(2) ?? ""} ${partyDetailController.partyDetailResponse.value.table?[index].dRCR.toString() ?? ""}",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 14,
        ),
      ]),
    );
  }
}

class LedgerDetailGrid extends StatelessWidget {
  const LedgerDetailGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listItems();
  }

  Widget listItems() {
    return GetX<PartyDetailController>(builder: (controllers) {
      return !controllers.isApiLoading.value
          ? PlutoGrid(
              columns: controllers.columns,
              rows: controllers.buildRows(),
              onLoaded: (PlutoGridOnLoadedEvent event) {
                controllers.stateManager = event.stateManager;
                controllers.stateManager?.setShowColumnFilter(false);
                // event.stateManager.addListener(gridHandler);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (event) {
                if (controllers.stateManager!.currentRow == null) {
                  return;
                }

                // int index = controllers.stateManager!.currentRow?.sortIdx ?? 0;
                // final ItemTable? itemTable =
                //     controller.items.value.table?[index];
                // Get.toNamed(Utility.screenName(Screens.itemDetailScreen),
                //     arguments: itemTable);

                // controller.stateManager?.unCheckedRows;
              },
              onRowSecondaryTap: (event) {
                print("object");
              },
              configuration: const PlutoGridConfiguration(),
              mode: PlutoGridMode.normal,
            )
          : Container();
    });
  }
}
