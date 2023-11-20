import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rapidd_technologies/Utils/model/data_model.dart';
import 'package:rapidd_technologies/Utils/text_field.dart';
import 'package:rapidd_technologies/Utils/utils.dart';
import 'package:rapidd_technologies/riverpods/data_pod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddData extends ConsumerWidget {
  AddData({this.isEdit = false, this.data, super.key});
  final bool isEdit;
  final Data? data;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isEdit) {
      nameController.text = data!.name ?? '';
      designationController.text = data!.designation ?? '';
    }
    final dataNotifier = ref.watch(dataProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          isEdit ? 'Edit' : 'Add',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TxtField(
                hint: 'Name',
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TxtField(
                hint: 'Designation',
                controller: designationController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Designation is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: 350,
                  child: RoundedLoadingButton(
                    borderRadius: 20,
                    color: Colors.blue,
                    controller: _btnController,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isEdit) {
                          Data userData = Data(
                            id: data!.id,
                            name: nameController.text,
                            designation: designationController.text.trim(),
                          );
                          dataNotifier.updateData(userData).then((value) {
                            Navigator.pop(context);

                            Utils.showToast('Data updated Successfully');
                          }).catchError((e) {
                            _btnController.reset();

                            Utils.showErrorToast('Something went wrong');
                          });
                        } else {
                          Data userData = Data(
                            name: nameController.text,
                            designation: designationController.text.trim(),
                          );
                          dataNotifier.createData(userData).then((value) {
                            Navigator.pop(context);

                            Utils.showToast('Data added Successfully');
                          }).catchError((e) {
                            _btnController.reset();
                            Utils.showErrorToast('Something went wrong');
                          });
                        }
                      } else {
                        _btnController.reset();
                      }
                    },
                    child: Text(
                      isEdit ? 'Edit' : 'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
