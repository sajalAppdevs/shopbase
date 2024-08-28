import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopbase_firebase/core/app_cubit/pick_image/pick_image_cubit.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/pages/screens/upload_products/cubit/upload_products_cubit.dart';

import '../../../../../../../../core/utils/consts/consts.dart';
import '../../../../../../../../core/utils/functions/functions.dart';
import '../../../../../../widgets/custom_button/build_basic_button_widget.dart';
import '../../../../../../widgets/custom_button/build_outlined_button.dart';
import '../../../widgets/create_upload_form_field_widget.dart';

class UploadProductPage extends StatefulWidget {
  const UploadProductPage({super.key});

  @override
  State<UploadProductPage> createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  bool _isOnSale = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadProductsCubit(),
      child: BlocBuilder<UploadProductsCubit, UploadProductsState>(
        builder: (context, state) {
          var cubit = UploadProductsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConsts.backgroundAppColor,
              title: const Text("رفع منتج جديد"),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: SafeArea(
                  child: Column(
                    children: [
                      20.kH,
                      BlocProvider(
                        create: (context) => PickImageCubit(),
                        child:
                            BlocBuilder<PickImageCubit, PickImageState>(builder: (context, state) {
                          var imgCubit = PickImageCubit.get(context);
                          if (state.pickedImage == null) {
                            SizedBox(
                              width: AppConsts.widthExpandSize(context) * 0.4,
                              height: AppConsts.heightExpandSize(context) * 0.4,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppConsts.basicAppColor,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image_outlined,
                                          size: 80, color: AppConsts.basicAppColor),
                                      TextButton(
                                        onPressed: () => imgCubit.pickImage(ImageSource.gallery),
                                        child: const Text("Pick Product image"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(state.pickedImage!.path),
                                height: AppConsts.heightExpandSize(context) * 0.5,
                                alignment: Alignment.center,
                              ),
                            );
                          }

                          if (state.pickedImage != null || state.productNetworkImage != null) {
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => imgCubit.pickImage(ImageSource.camera),
                                  child: const Text("Pick another image"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      state.copyWith(pickedImage: null, productNetworkImage: null),
                                  child: const Text(
                                    "Remove image",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          }
                          return SizedBox(
                            width: AppConsts.widthExpandSize(context) * 0.4,
                            height: AppConsts.heightExpandSize(context) * 0.4,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppConsts.basicAppColor,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.image_outlined,
                                        size: 80, color: AppConsts.basicAppColor),
                                    TextButton(
                                      onPressed: () => imgCubit.pickImage(ImageSource.gallery),
                                      child: const Text("Pick Product image"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      25.kH,
                      DropdownButton<String>(
                        value: cubit.selectedCategory,
                        hint: Text('اختر القسم'),
                        onChanged: (value) {
                          // setState(() {
                          //   cubit.selectedCategory = value;
                          //   switch (value) {
                          //     case "Winter":
                          //       cubit.selectedSubCategory = winterClothesSubCategories;
                          //       break;
                          //     case "Summer":
                          //       cubit.selectedSubCategory = summerClothesSubCategories;
                          //       break;
                          //     case "Suits":
                          //       cubit.selectedSubCategory = suitsClothesSubCategories;
                          //       break;
                          //     default:
                          //       cubit.selectedSubCategory = null;
                          //   }
                          // });
                        },
                        items: AppConsts.categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                      ),
                      16.kH,
                      if (cubit.selectedSubCategory != null)
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: cubit.selectedSubCategory!.map((subCategory) {
                            return Chip(
                              label: Text(subCategory),
                            );
                          }).toList(),
                        ),
                      25.kH,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Column(
                          children: [
                            uploadFormField(const ValueKey('Title'),
                                controller: titleController,
                                min: 1,
                                max: 2,
                                length: 80,
                                hint: 'اسم المنتج',
                                label: 'المنتج',
                                validateTitle: "حقل اسم المنتج فارغ , الرجاء املئ الحقل الفارغ"),
                            10.kH,
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: uploadFormField(
                                    const ValueKey('Price \$'),
                                    controller: quantityController,
                                    min: 1,
                                    max: 1,
                                    length: 1000,
                                    hint: '10\$',
                                    label: 'السعر',
                                    validateTitle: 'املئ خانة السعر',
                                    inputType: TextInputType.number,
                                    list: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d{0,2}'),
                                      ),
                                    ],
                                    prefix: Text(
                                      "\$ ",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                10.kW,
                                Flexible(
                                  flex: 1,
                                  child: uploadFormField(const ValueKey('Quantity'),
                                      controller: quantityController,
                                      min: 1,
                                      max: 1,
                                      length: 1000,
                                      hint: '10',
                                      label: 'الكمية',
                                      validateTitle: 'املئ خانة الكمية'),
                                )
                              ],
                            ),
                            15.kH,
                            uploadFormField(const ValueKey('Description'),
                                controller: descriptionController,
                                min: 5,
                                max: 8,
                                length: 1000,
                                hint: "وصف المنتج بالتفصيل الممل",
                                label: "وصف المنتج",
                                validateTitle: "خانة الوصف فارغة , يرجى ملء الحقل الفارغ",
                                capitalization: TextCapitalization.sentences),
                            25.kH,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: SizedBox(
              height: 90,
              child: Column(
                children: [
                  10.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      10.kW,
                      Expanded(
                          child: buildOutlinedButton(
                              title: 'مسح البيانات',
                              function: () => cubit.clearForm(
                                  titleController: titleController,
                                  priceController: priceController,
                                  descriptionController: descriptionController,
                                  quantityController: quantityController),
                              color: Colors.white,
                              borderColor: AppConsts.basicAppColor)),
                      10.kW,
                      Expanded(
                          child: state is LoadingUploadProductState
                              ? appCircleLoading()
                              : basicButton(
                                  title: "رفع البيانات",
                                  function: () => cubit.uploadProduct(context,
                                      titleController: titleController,
                                      priceController: priceController,
                                      descriptionController: descriptionController,
                                      quantityController: quantityController))),
                      10.kW,
                    ],
                  ),
                  10.kH,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
