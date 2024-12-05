import 'package:doctor/Core/resources/app_colors.dart';
import 'package:doctor/core/widgets/custom_app_bar.dart';
import 'package:doctor/features/st/st_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StView extends StatefulWidget {
  const StView({super.key});

  @override
  State<StView> createState() => _StViewState();
}

class _StViewState extends State<StView> {

  StController controller = Get.put(StController());
  @override
  void initState() {
    controller.getStData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar('احصائيات', context, false),
      body:GetBuilder<StController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [

              SizedBox(height: 12,),

              Image.asset('assets/images/logo.png',height: 200,),

              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                stCard('عدد الطلبات',controller.allData.toString()),

                SizedBox(width: 41,),

                stCard('عدد الطلبات التي تمت الموافقة',
                    controller.successData.toString()),

              ],),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                stCard(' عدد الطلبات المرفوضة ',controller.refusedData.toString()),

                  SizedBox(width: 41,),

                stCard('عدد الطلبات قيد الموافقة ',
                    controller.pendingData.toString()),

              ],),
              SizedBox(height: 12,),
              Divider(),
              SizedBox(height: 12,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  stCard(' عدد الطلبات المرفوضة اخر يوم',controller.lastDayRefusedData.toString()),

                  SizedBox(width: 21,),

                  stCard('عدد الطلبات قيد الموافقة اخر يوم ',
                      controller.lastDayPendingData.toString()),

                  SizedBox(width: 21,),

                  stCard('عدد الطلبات المرفوضة اخر يوم ',
                      controller.lastDayRefusedData.toString()),

                  SizedBox(width: 21,),

                  stCard('عدد الطلبات المقبولة اخر يوم ',
                      controller.lastDaySuccessData.toString()),
                ],),

              SizedBox(height: 12,),
              Divider(),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  stCard(' عدد الطلبات المرفوضة اخر اسبوع',controller.lastWeekRefusedData.toString()),

                  SizedBox(width: 21,),

                  stCard('عدد الطلبات قيد الموافقة اخر اسبوع ',
                      controller.lastWeekPendingData.toString()),

                  SizedBox(width: 21,),





                  stCard('عدد الطلبات المقبولة اخر اسبوع ',
                      controller.lastWeekSuccessData.toString()),
                ],),
              SizedBox(height: 12,),
              Divider(),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  stCard(' عدد الطلبات المرفوضة اخر شهر',controller.lastMonthRefusedData.toString()),

                  SizedBox(width: 21,),

                  stCard('عدد الطلبات قيد الموافقة اخر شهر ',
                      controller.lastMonthPendingData.toString()),

                  SizedBox(width: 21,),

                  stCard('عدد الطلبات المقبولة اخر شهر ',
                      controller.lastMonthSuccessData.toString()),
                ],),


            ],),
          );
        }
      ),
    );
  }
}

Widget stCard(String txt,String num){

  return Container(
    width:333,
    height: 120,
    decoration: BoxDecoration(
      borderRadius:BorderRadius.circular(12),
      color:AppColors.primary,
      border:Border.all(color:AppColors.backgroundColor)
    ),
    child:Padding(padding: EdgeInsets.all(12),
    child: Column(children: [

      Text(txt,style: GoogleFonts.cairo(
          color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold
      )),

      SizedBox(height: 9,),

      Text(num,style: GoogleFonts.cairo(
          color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold
      )),



      ],),
    ),
  );
}
