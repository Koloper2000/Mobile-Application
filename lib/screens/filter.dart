import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motogp/controller/chipcontroller.dart';
import 'package:motogp/controller/filtercontroller.dart';
import 'package:motogp/model/motogp_model.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);

  final FilterController filterController = Get.put(FilterController());
  final ChipController chipController = Get.put(ChipController());

  final List<String> _chipLabel = [
    'Honda',
    'Suzuki',
    'Yamaha',
    'Aprilia',
    'Ducati'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          "Filtriranje vozaca prema timu",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Obx(
                () => Wrap(
                  spacing: 20,
                  children: List<Widget>.generate(5, (int index) {
                    return ChoiceChip(
                      label: Text(_chipLabel[index]),
                      selected: chipController.selectedChip == index,
                      onSelected: (bool selected) {
                        chipController.selectedChip = selected ? index : null;
                        filterController.onInit();
                        filterController.getMotogp(
                            MotogpTim.values[chipController.selectedChip]);
                      },
                    );
                  }),
                ),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filterController.motogpList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              "${filterController.motogpList[index].prezime}"),
                          subtitle:
                              Text("${filterController.motogpList[index].ime}"),
                          trailing:
                              Text("${filterController.motogpList[index].tim}"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
