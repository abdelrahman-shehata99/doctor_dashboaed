import 'package:doctor/admin/controller/booking_controller.dart';
import 'package:doctor/core/resources/app_colors.dart';
import 'package:doctor/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>(); // Unique Key

  BookingController controller = Get.put(BookingController());
  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar('الحجوزات', context, false),
      body: GetBuilder<BookingController>(builder: (_) {
        return GridView.builder(
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BookingCard(
                      data: controller.data[index],
                      screenWidth: screenWidth,
                      isCancelled:
                          controller.data[index]['status'] == 'Refuse'));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
             // maxCrossAxisExtent: screenWidth * .5, // Max width per card
              mainAxisSpacing: 10,
             mainAxisExtent: screenHeight * .65,
              crossAxisSpacing: 10,
            ));
      }),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isCancelled;
  double screenWidth;
  BookingCard({
    super.key,
    required this.screenWidth,
    required this.data,
    this.isCancelled = false,
  });

  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: 16, horizontal: screenWidth * .01),
        padding: EdgeInsets.all(screenWidth * .01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: isCancelled ? null : AppColors.primaryBGLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تاريخ الحجز : ${data['date']}",
                    style: GoogleFonts.alexandria(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * .01,
                      color: isCancelled ? Colors.grey : AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    "وقت الحجز : ${data['time']}",
                    style: GoogleFonts.alexandria(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * .01,
                      color: isCancelled ? Colors.grey : AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Doctor Info
            Text(
              "بيانات الطبيب",
              style: GoogleFonts.alexandria(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(data['image']),
                  radius: 40, // Responsive image size
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        "الاسم",
                        data['name'],
                        screenWidth,
                      ),
                      _buildInfoRow(
                        "البريد الالكتروني",
                        data['email'],
                        screenWidth,
                      ),
                      _buildInfoRow(
                        "رقم الهاتف",
                        data['phone'],
                        screenWidth,
                      ),
                      _buildInfoRow(
                          "المؤهلات", data['qualifications'], screenWidth),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            // User Info
            Text(
              "بيانات المستخدم",
              style: GoogleFonts.alexandria(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * .01,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("اسم المستخدم", data['user_name'], screenWidth),
                _buildInfoRow(
                  "بريد المستخدم",
                  data['user_email'],
                  screenWidth,
                ),
                _buildInfoRow("هاتف المستخدم", data['user_phone'], screenWidth),
              ],
            ),
            const SizedBox(height: 10),
            // Action Buttons
            if (!isCancelled)
              _buildActionButton(
                "الغاء الحجز",
                Colors.red,
                screenWidth,
                () => controller.cancel(data['booking_id']),
              ),
                           
            if (isCancelled)
              _buildActionButton(
                "حذف",
                Colors.red,
                screenWidth,
                () => controller.delete(data['booking_id']),
              ),
          ],
        ),
      ),
    );
  }

  // Reusable info row
  Widget _buildInfoRow(String label, String value, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * .01,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * .01,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable action button
  Widget _buildActionButton(
      String text, Color color, double screenWidth, VoidCallback onTap,
      {IconData? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.alexandria(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * .01,
                color: Colors.white,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
