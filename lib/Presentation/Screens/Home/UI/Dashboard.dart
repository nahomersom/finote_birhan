import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;

   return Stack(
     children: [
       Container(

         height: double.infinity,
         decoration:  BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               stops: const [
                 0.1,
                 0.9,

               ],
               colors: [

                  ColorResources.secondaryColor,
                 ColorResources.secondaryColor.withOpacity(0.65),
               ],
             )
         ),
       ),
       Container(
         margin: EdgeInsets.only(top: sizeH * 0.33),
         height: double.infinity,
         decoration:  const BoxDecoration(
           color: ColorResources.primaryColor,
           borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))
         ),
         child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Text('ድርጊቶች',  style: Theme.of(context)
        .textTheme
        .displayMedium
        ?.copyWith(color: ColorResources.textColor),
    ),
               SizedBox(height: sizeH * 0.03,),
               Expanded(
                 child: Row(
                   children: [
                     Expanded(
                         child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                     SizedBox(width: sizeW * 0.02,),
                     Expanded(
                         child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                     SizedBox(width: sizeW * 0.02,),
                     Expanded(
                         child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                   ],
                 ),
               ),
               SizedBox(height: sizeH * 0.01,),
               Expanded(child:   Row(
                 children: [
                   Expanded(
                       child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                   SizedBox(width: sizeW * 0.02,),
                   Expanded(
                       child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                   SizedBox(width: sizeW * 0.02,),
                   Expanded(
                       child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                 ],
               ),
               ),

               SizedBox(height: sizeH * 0.01,),
               Expanded(
                 child: Row(
                   children: [
                     Expanded(
                         child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                     SizedBox(width: sizeW * 0.02,),
                     Expanded(
                         child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                     SizedBox(width: sizeW * 0.02,),
                     Expanded(
                         child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
                   ],
                 ),
               )

             ],
           ),

         ),
       )
     ],
   );
  }

}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.sizeH,
    required this.text,
    required this.icon
  });

  final double sizeH;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH * 0.13,
                     decoration:  const BoxDecoration(
      boxShadow:  [
        BoxShadow(
            color: Color(0xffe8e8e8),
            blurStyle: BlurStyle.outer,
            spreadRadius: 1,
            blurRadius: 5
        ),
      ],
      color: ColorResources.primaryColor,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),

                   // border: Border.all(
                   //       color: ColorResources.textColor,
                   //       width: 0.1
                   //     )
                     ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorResources.lightSecondaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                icon,
                color: ColorResources.secondaryColor,
              ),
            ),
          ),
           SizedBox(height: sizeH*0.01,),
           Text(text,  style: Theme.of(context)
               .textTheme
               .titleSmall
               ?.copyWith(color: ColorResources.textColor),)
        ],
      ),
                   );
  }
}

