import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_state.dart';
import 'package:a_pos_flutter/product/extension/context/context.dart';
import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:a_pos_flutter/product/theme/custom_font_style.dart';
import 'package:a_pos_flutter/product/widget/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part '../widget/restaurant_widget.dart';

class RestaurantDialogView {
  void show(BuildContext context) {
    bool isSettedController = false;
    TextEditingController? restaurantNameController;
    TextEditingController? remoteAccountController;
    TextEditingController? cityController;
    TextEditingController? stateNameController;
    TextEditingController? zipCodeController;
    TextEditingController? phone1Controller;
    TextEditingController? phone2Controller;
    TextEditingController? faxController;
    TextEditingController? emailController;
    TextEditingController? websiteController;
    TextEditingController? addressController;
    TextEditingController? message1Controller;
    TextEditingController? message2Controller;
    TextEditingController? message3Controller;
    TextEditingController? message4Controller;
    void setController(RestaurantState state) {
      restaurantNameController = TextEditingController(text: state.restaurantName);
      remoteAccountController = TextEditingController(text: state.remoteAccount);
      cityController = TextEditingController(text: state.city);
      stateNameController = TextEditingController(text: state.stateName);
      zipCodeController = TextEditingController(text: state.zipCode);
      phone1Controller = TextEditingController(text: state.phone1);
      phone2Controller = TextEditingController(text: state.phone2);
      faxController = TextEditingController(text: state.fax);
      emailController = TextEditingController(text: state.email);
      websiteController = TextEditingController(text: state.website);
      addressController = TextEditingController(text: state.address);
      message1Controller = TextEditingController(text: state.message1);
      message2Controller = TextEditingController(text: state.message2);
      message3Controller = TextEditingController(text: state.message3);
      message4Controller = TextEditingController(text: state.message4);
      isSettedController = true;
      debugPrint('isSetted inside: $isSettedController');
    }

    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        debugPrint('isSetted: $isSettedController');
        return BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            RestaurantCubit cubit = context.read<RestaurantCubit>();
            isSettedController ? null : setController(state);

            return AlertDialog(
              content: SizedBox(
                width: context.dynamicWidth(.8),
                height: context.dynamicHeight(1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Restaurant Information',
                          style: CustomFontStyle.formsTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      const _TitleWithDivider(title: 'Company Information'),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: _LeftInfoTitle(
                                          title: 'Restaurant Name',
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              // hintText: state.restaurantName,
                                              controller: restaurantNameController,
                                              isBorder: true,
                                              onChanged: (e) {
                                                restaurantNameController?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: _LeftInfoTitle(
                                          title: 'Remote Account#',
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              // hintText: state.remoteAccount,
                                              controller: remoteAccountController,

                                              isBorder: true,
                                              onChanged: (e) {
                                                remoteAccountController?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: _LeftInfoTitle(
                                          title: 'City',
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              // hintText: state.city,
                                              controller: cityController,
                                              isBorder: true,
                                              onChanged: (e) {
                                                cityController?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: _LeftInfoTitle(
                                          title: 'State',
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              // hintText: state.stateName,
                                              controller: stateNameController,
                                              isBorder: true,
                                              onChanged: (e) {
                                                stateNameController?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: _LeftInfoTitle(
                                          title: 'ZipCode',
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              //hintText: state.zipCode,
                                              controller: zipCodeController,
                                              isBorder: true,
                                              onChanged: (e) {
                                                zipCodeController?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: _LeftInfoTitle(
                                          title: 'phone1',
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              //  hintText: state.phone1,
                                              controller: phone1Controller,
                                              isPhoneNumber: true,
                                              isBorder: true,
                                              onChanged: (e) {
                                                phone1Controller?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                          flex: 1, child: _LeftInfoTitle(title: 'phone2')),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              // hintText: state.phone2,
                                              controller: phone2Controller,
                                              isPhoneNumber: true,
                                              isBorder: true,
                                              onChanged: (e) {
                                                phone2Controller?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      const Expanded(flex: 1, child: _LeftInfoTitle(title: 'fax')),
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 25,
                                            child: CustomTextField(
                                              // hintText: state.fax,
                                              controller: faxController,
                                              isBorder: true,
                                              onChanged: (e) {
                                                faxController?.text = e;
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  const _LeftInfoTitle(title: 'Company LOGO'),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: context.dynamicHeight(0.1),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: context.colorScheme.surfaceTint)),
                                    child: state.image == null || state.image?.path == ''
                                        ? null
                                        : Image.file(state.image!),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            context.read<RestaurantCubit>().getImage(
                                                  ImageSource.gallery,
                                                );
                                          },
                                          child: const _BottomButtonWidget(
                                            buttonText: 'Browse',
                                          )),
                                      const SizedBox(width: 4),
                                      InkWell(
                                          onTap: () {
                                            context.read<RestaurantCubit>().cleanImage();
                                            debugPrint(state.image?.path.toString());
                                          },
                                          child: const _BottomButtonWidget(buttonText: 'Clean')),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                        children: [
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'E-mail',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      //   hintText: state.email,
                                      controller: emailController,
                                      isBorder: true,
                                      onChanged: (e) => emailController?.text = e,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Website',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      // hintText: state.website,
                                      controller: websiteController,
                                      isBorder: true,
                                      onChanged: (e) => websiteController?.text = e,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: const Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'SMTP Host Server',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      readOnly: true,
                                      isBorder: true,
                                      hintText: 'smtp.webHost4life.com',
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: const Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'E-mail Account',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      readOnly: true,
                                      isBorder: true,
                                      hintText: 'info@aposusa.com',
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: const Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'E-mail Password',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      isBorder: true,
                                      readOnly: true,
                                      isObscure: true,
                                      hintText: '********',
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: const Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Online Delivery URL',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      isBorder: true,
                                      readOnly: true,
                                      hintText: 'www.gcsCafe.com',
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Address',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      //    hintText: state.address,
                                      controller: addressController,
                                      isBorder: true,
                                      onChanged: (e) => addressController?.text = e,
                                    )),
                              ],
                            ),
                          ),
                          const _TitleWithDivider(title: 'Message On the Receipt'),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Message 1',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      //  hintText: state.message1,
                                      controller: message1Controller,
                                      isBorder: true,
                                      onChanged: (e) => message1Controller?.text = e,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Message 2',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      //   hintText: state.message2,
                                      controller: message2Controller,
                                      isBorder: true,
                                      onChanged: (e) => message2Controller?.text = e,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Message 3',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      //  hintText: state.message3,
                                      controller: message3Controller,
                                      isBorder: true,
                                      onChanged: (e) => message3Controller?.text = e,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: _LeftInfoTitle(
                                    title: 'Message 4',
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      //   hintText: state.message4,
                                      controller: message4Controller,
                                      isBorder: true,
                                      onChanged: (e) => message4Controller?.text = e,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    cubit.saveChanges(
                      restaurantName: restaurantNameController!.text.isEmpty
                          ? state.restaurantName
                          : restaurantNameController?.text,
                      remoteAccount: remoteAccountController!.text.isEmpty
                          ? state.remoteAccount
                          : remoteAccountController!.text,
                      city: cityController!.text.isEmpty ? state.city : cityController!.text,
                      stateName: stateNameController!.text.isEmpty
                          ? state.stateName
                          : stateNameController!.text,
                      zipCode:
                          zipCodeController!.text.isEmpty ? state.zipCode : zipCodeController!.text,
                      phone1:
                          phone1Controller!.text.isEmpty ? state.phone1 : phone1Controller!.text,
                      phone2:
                          phone2Controller!.text.isEmpty ? state.phone2 : phone2Controller!.text,
                      fax: faxController!.text.isEmpty ? state.fax : faxController!.text,
                      email: emailController!.text.isEmpty ? state.email : emailController!.text,
                      website:
                          websiteController!.text.isEmpty ? state.website : websiteController!.text,
                      address:
                          addressController!.text.isEmpty ? state.address : addressController!.text,
                      message1: message1Controller!.text.isEmpty
                          ? state.message1
                          : message1Controller!.text,
                      message2: message2Controller!.text.isEmpty
                          ? state.message2
                          : message2Controller!.text,
                      message3: message3Controller!.text.isEmpty
                          ? state.message3
                          : message3Controller!.text,
                      message4: message4Controller!.text.isEmpty
                          ? state.message4
                          : message4Controller!.text,
                    );

                    Navigator.pop(context);
                  },
                  child: const _BottomButtonWidget(
                    buttonText: "Save",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const _BottomButtonWidget(
                    buttonText: "Exit",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
