import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/consts/consts.dart';
import 'package:shopbase_firebase/features/data/models/products_model.dart';
import 'package:shopbase_firebase/features/presentation/screens/04-dashboard/presentation/widgets/create_upload_form_field_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_outlined_button.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_snack_bar/build_snackbar_widget.dart';
import 'package:uuid/uuid.dart';

class UploadProductsPage extends StatefulWidget {
  final ProductsModel? productModel;

  const UploadProductsPage({super.key, this.productModel});

  @override
  State<UploadProductsPage> createState() => _UploadProductsPageState();
}

class _UploadProductsPageState extends State<UploadProductsPage> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  bool isSaleEnabled = false;
  XFile? _pickedImage;
  String? productNetworkImage;
  String? productImageUrl;
  String? selectedCategory;

  late TextEditingController _titleController,
      _priceController,
      _descriptionController,
      _quantityController,
      salesController;
  dynamic selectedSubCategory;

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      selectedCategory = widget.productModel!.productCategory;
      selectedSubCategory = widget.productModel!.productSubCategory;
    }
    _titleController = TextEditingController(text: widget.productModel?.productTitle);
    _priceController = TextEditingController(text: widget.productModel?.productPrice.toString());
    salesController = TextEditingController(text: widget.productModel?.productSale.toString());
    _descriptionController = TextEditingController(text: widget.productModel?.productDescription);
    _quantityController = TextEditingController(text: widget.productModel?.productQuantity);

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    salesController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    salesController.clear();
    _quantityController.clear();
    removePickedImage();
  }

  void removePickedImage() {
    setState(() {
      _pickedImage = null;
      productNetworkImage = null;
    });
  }

  Future<void> _uploadProduct(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      showErrorSnackBar("ارفق صورة هنا!!!", 3, context);
      return;
    }
    if (selectedCategory == null || selectedSubCategory == null) {
      showErrorSnackBar("الكاتيجوري فاضية!!", 3, context);
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      try {
        final productID = const Uuid().v4();
        if (_pickedImage != null) {
          final ref =
              FirebaseStorage.instance.ref().child("productsImages").child('$productID.jpg');
          await ref.putFile(File(_pickedImage!.path));
          productImageUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance.collection("products").doc(productID).set({
          'productId': productID,
          'productTitle': _titleController.text,
          'productPrice': _priceController.text,
          'productImage': productImageUrl,
          'productCategory': selectedCategory.toString().trim(),
          'productSubCategory': selectedSubCategory.toString().trim(), // Convert enum to string
          'productDescription': _descriptionController.text,
          'productQuantity': _quantityController.text,
          'productSale': salesController.text,
          'createdAt': Timestamp.now()
        });
        Navigator.pop(context);
        showSuccessSnackBar("تم ارفاق المنتج بنجاح!", 3, context);
        if (!mounted) return;
        clearForm();
      } on FirebaseException catch (error) {
        print("FirebaseException in _uploadProduct Function: ${error.message}");
        await showErrorSnackBar(
            "FirebaseException in _uploadProduct Function: ${error.toString()}", 3, context);
      } catch (error, stackTrace) {
        print("Catch in _uploadProduct Function: ${error.toString()}");
        print("Catch in _uploadProduct Function: ${stackTrace.toString()}");
        await showErrorSnackBar(error.toString(), 3, context);
      }
    }
  }

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && productNetworkImage == null) {
      showErrorSnackBar("ارفق صورة هنا!!!", 3, context);
      return;
    }
    if (selectedCategory == null || selectedSubCategory == null) {
      showErrorSnackBar("الكاتيجوري فاضية!!", 3, context);
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child("productsImages")
              .child('${widget.productModel!.productId}.jpg');
          await ref.putFile(File(_pickedImage!.path));
          productImageUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection("products")
            .doc(widget.productModel!.productId)
            .update({
          'productId': widget.productModel!.productId,
          'productTitle': _titleController.text,
          'productPrice': _priceController.text,
          'productImage': productImageUrl ?? productNetworkImage,
          'productCategory': selectedCategory,
          'productSubCategory': selectedSubCategory,
          'productDescription': _descriptionController.text,
          'productQuantity': _quantityController.text,
          'createdAt': widget.productModel!.createdAt,
        });
        showSuccessSnackBar("تم تعديل المنتج بنجاح!", 3, context);
        if (!mounted) clearForm();
      } on FirebaseException catch (error) {
        print("FirebaseException in _editProduct Function: ${error.message}");
        await showErrorSnackBar(error.toString(), 3, context);
      } catch (error) {
        print("Catch in _editProduct Function: ${error.toString()}");
        await showErrorSnackBar(error.toString(), 3, context);
      } finally {
        // setState(() {
        //   _isLoading = false;
        // });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          productNetworkImage = null;
        });
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          productNetworkImage = null;
        });
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConsts.backgroundAppColor,
        title: const Text("رفع منتج جديد"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('هل يوجد تخفيض'),
              10.kW,
              Switch.adaptive(
                value: isSaleEnabled,
                onChanged: (value) {
                  setState(() {
                    isSaleEnabled = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              children: [
                20.kH,
                if (isEditing && productNetworkImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      productNetworkImage!,
                      height: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                ] else if (_pickedImage == null) ...[
                  SizedBox(
                    width: size.width * 0.4 + 10,
                    height: size.width * 0.4,
                    child: DottedBorder(
                        color: AppConsts.basicAppColor,
                        radius: const Radius.circular(12),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image_outlined,
                                size: 80,
                                color: AppConsts.basicAppColor,
                              ),
                              TextButton(
                                onPressed: () {
                                  localImagePicker();
                                },
                                child: const Text("Pick Product image"),
                              ),
                            ],
                          ),
                        )),
                  )
                ] else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(_pickedImage!.path),
                      height: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
                if (_pickedImage != null || productNetworkImage != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          localImagePicker();
                        },
                        child: const Text("Pick another image"),
                      ),
                      TextButton(
                        onPressed: () {
                          removePickedImage();
                        },
                        child: const Text(
                          "Remove image",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
                25.kH,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppConsts.backgroundAppColor)),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          hint: Text('Select a Category'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue;
                              selectedSubCategory = null;
                            });
                          },
                          items: _getCategoryItems(),
                        ),
                      ),
                      6.kH,
                      if (selectedCategory != null) ...[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppConsts.backgroundAppColor)),
                          child: DropdownButton<String>(
                            value: selectedSubCategory,
                            hint: Text('Select a Sub-Category'),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSubCategory = newValue;
                              });
                            },
                            items: _getSubCategoryItems(selectedCategory!),
                          ),
                        ),
                      ] else
                        SizedBox.shrink()
                    ],
                  ),
                ),
                25.kH,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    children: [
                      uploadFormField(const ValueKey('Title'),
                          controller: _titleController,
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
                              controller: _priceController,
                              min: 1,
                              max: 1,
                              length: 1000,
                              hint: '10',
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
                                  color: AppConsts.basicAppColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          10.kW,
                          isSaleEnabled == true
                              ? Flexible(
                                  flex: 1,
                                  child: Visibility(
                                    visible: isSaleEnabled,
                                    child: uploadFormField(
                                      const ValueKey('Sale \$'),
                                      controller: salesController,
                                      min: 1,
                                      max: 1,
                                      length: 1000,
                                      hint: '10',
                                      label: 'تخفيض',
                                      validateTitle: 'املئ خانة العرض',
                                      inputType: TextInputType.number,
                                      list: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                                        ),
                                      ],
                                      prefix: Text(
                                        "\$ ",
                                        style: TextStyle(
                                          color: AppConsts.basicAppColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          10.kW,
                          Flexible(
                            flex: 1,
                            child: uploadFormField(const ValueKey('Quantity'),
                                controller: _quantityController,
                                min: 1,
                                max: 1,
                                length: 1000,
                                hint: '10',
                                label: 'الكمية',
                                validateTitle: 'املئ خانة الكمية'),
                          ),
                        ],
                      ),
                      15.kH,
                      uploadFormField(const ValueKey('Description'),
                          controller: _descriptionController,
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
                25.kH,
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
                      function: clearForm,
                      color: Colors.white,
                      borderColor: AppConsts.basicAppColor),
                ),
                10.kW,
                Expanded(
                  child: basicButton(
                      title: isEditing ? "تعديل البيانات" : "رفع البيانات",
                      function: () {
                        if (isEditing) {
                          _editProduct();
                        } else {
                          _uploadProduct(context);
                        }
                      }),
                ),
                10.kW,
              ],
            ),
            10.kH,
          ],
        ),
      ),
    );
  }

  // List<DropdownMenuItem<dynamic>> _getSubCategoryItems(CategoriesEnum category) {
  //   switch (category) {
  //     case CategoriesEnum.winter:
  //       return WinterSubCategoriesEnum.values.map((subCategory) {
  //         return DropdownMenuItem(
  //           value: subCategory,
  //           child: Text(subCategory.name),
  //         );
  //       }).toList();
  //     case CategoriesEnum.summer:
  //       return SummerSubCategoriesEnum.values.map((subCategory) {
  //         return DropdownMenuItem(
  //           value: subCategory,
  //           child: Text(subCategory.name),
  //         );
  //       }).toList();
  //     case CategoriesEnum.suits:
  //       return SuitsSubCategoriesEnum.values.map((subCategory) {
  //         return DropdownMenuItem(
  //           value: subCategory,
  //           child: Text(subCategory.name),
  //         );
  //       }).toList();
  //     default:
  //       return [];
  //   }
  // }

  List<DropdownMenuItem<String>> _getCategoryItems() {
    // Assuming you have a list of category names
    List<String> categories = [
      AppConsts.categories[0],
      AppConsts.categories[1],
      AppConsts.categories[2]
    ];
    return categories.map((String category) {
      return DropdownMenuItem<String>(
        value: category,
        child: Text(category),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _getSubCategoryItems(String category) {
    // Assuming you have a map of sub-categories
    Map<String, List<String>> subCategories = {
      // 'Category1': ['SubCategory1-1', 'SubCategory1-2'],
      // 'Category2': ['SubCategory2-1', 'SubCategory2-2'],
      // 'Category3': ['SubCategory3-1', 'SubCategory3-2'],
      AppConsts.categories[0]: AppConsts.winterClothesSubCategories,
      AppConsts.categories[1]: AppConsts.summerClothesSubCategories,
      AppConsts.categories[2]: AppConsts.suitsClothesSubCategories,
    };
    return subCategories[category]!.map((String subCategory) {
      return DropdownMenuItem<String>(
        value: subCategory,
        child: Text(subCategory),
      );
    }).toList();
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text("Choose option"),
            ),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"),
                ),
                TextButton.icon(
                  onPressed: () {
                    removeFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text("Remove"),
                ),
              ],
            )),
          );
        });
  }
}
