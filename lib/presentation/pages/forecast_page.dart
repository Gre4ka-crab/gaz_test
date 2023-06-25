import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaz_test/units/pj_icons.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color.fromRGBO(7, 0, 225, 1), Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: const SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.white),
                  Text(
                    'Город Страна',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
