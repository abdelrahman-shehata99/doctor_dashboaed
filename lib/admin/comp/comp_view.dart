import 'package:doctor/admin/comp/comp_controller.dart';
import 'package:doctor/admin/comp/user_details.dart';
import 'package:doctor/core/widgets/Custom_button.dart';
import 'package:doctor/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompView extends StatefulWidget {
  const CompView({super.key});

  @override
  State<CompView> createState() => _CompViewState();
}

class _CompViewState extends State<CompView> {
  CompController controller = Get.put(CompController());
  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('الشكاوي', context, false),
      body: GetBuilder<CompController>(builder: (_) {
        return ListView(
          children: [
            SizedBox(
              height: 12,
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: controller.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CompCard(
                      data: controller.data[index],
                      screenWidth: screenWidth,
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: screenWidth, // Max width per card
                  mainAxisSpacing: 10,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 10,
                )),
          ],
        );
      }),
    );
  }
}

class CompCard extends StatelessWidget {
  Map<String, dynamic> data;
  double screenWidth;
  CompCard({super.key, required this.data, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: screenWidth,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              width: screenWidth*.3,
              child: Text(
                data['title'],
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cairo(
                    color: Colors.black, fontSize: screenWidth * .012),
              ),
            ),
            Text(
              'اسم المستخدم : ' + data['user_name'],
              style: GoogleFonts.cairo(
                  color: Colors.black, fontSize: screenWidth * .012),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: CustomButton(
                  text: 'انتقل لحساب المستخدم',
                  size: screenWidth * .012,
                  onPressed: () {
                    Get.to(userDetailsView(
                      id: data['user_id'],
                    ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
