import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:flutter/material.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/core/utils/functions/functions.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/upload_products_screen.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';

Widget buildDashboardCardWidget(context,
        {required dynamic uid,
        required String image,
        required String name,
        required String categoryName,
        required String price,
        required String sale,
        required Function onDelete}) =>
    SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: AppConsts.widthExpandSize(context).w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                fit: StackFit.loose,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                      child: AspectRatio(
                        aspectRatio: 8 / 7,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                              padding: const EdgeInsets.all(38.0),
                              child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: double.infinity.w,
                          height: 90,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0.sp),
                          topLeft: Radius.circular(10.0.sp),
                          bottomLeft: Radius.circular(10.0.sp),
                          bottomRight: Radius.circular(30.0.sp))),
                  Positioned(
                      child: Padding(
                          padding: const EdgeInsets.all(78.0),
                          child: ElevatedButton(
                              onPressed: () => navToWithRTLAnimation(context, UploadProductsPage()),
                              style: ButtonStyle(
                                side: MaterialStatePropertyAll(BorderSide(color: Colors.black12)),
                                backgroundColor: MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStatePropertyAll(CircleBorder()),
                              ),
                              child: Icon(Icons.edit, size: 17.sp, color: AppConsts.greyAppColor))),
                      top: 60,
                      bottom: -90,
                      left: 65),
                  Positioned(
                      child: Padding(
                          padding: const EdgeInsets.all(78.0),
                          child: ElevatedButton(
                              onPressed: () async => onDelete,
                              style: ButtonStyle(
                                side: MaterialStatePropertyAll(BorderSide(color: Colors.black12)),
                                backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                                shape: MaterialStatePropertyAll(CircleBorder()),
                              ),
                              child:
                                  Icon(Icons.delete, size: 17.sp, color: AppConsts.whiteAppColor))),
                      top: 60,
                      bottom: -90,
                      right: 60),
                ],
              ),
              20.kH,
              Text(
                categoryName,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppConsts.greyAppColor),
              ),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$" + price,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  sale == ''
                      ? Text("")
                      : Text(
                          "التخفيض: " + sale + "\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: AppConsts.errorAppColor,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
