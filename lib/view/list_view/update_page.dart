import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/update_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/view/widget/appbar_title.dart';
import 'package:studentapp/view/widget/bottombar.dart';

class UpdataUser extends StatelessWidget {
  final String name;
  final String roll;
  final String stand;
  final String image;
  final dynamic id;
  UpdataUser(
      {super.key,
      required this.name,
      required this.roll,
      required this.stand,
      required this.image,
      required this.id});
  @override
  Widget build(BuildContext context) {
    print(roll);
    print(id);
    print(name);
    print(stand);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final updateData = Provider.of<UpdateController>(context, listen: false);
    updateData.nameController.text = name;
    updateData.rollController.text = roll;
    updateData.selectedDivison = stand;
    updateData.id = id;

    // final updataController = Provider.of<UpdateController>(context);
    //updateData.imageUrl = image;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: AppBarTitile(firstName: 'Edit', secondName: "Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Consumer<UpdateController>(
                builder: (context, controller, child) {
                  controller.imageUrl = image;
                  if (controller.imageFile == null &&
                      controller.imageUrl.isEmpty) {
                    return Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 300,
                        color: Colors.grey.shade200,
                        child: const Text('Image not found!'));
                  } else {
                    return InkWell(
                      onTap: () async {
                        await controller.pickImage();
                      },
                      child: controller.imageFile != null
                          ? Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 300,
                              color: Colors.grey.shade100,
                              child: Image.file(controller.imageFile!,
                                  fit: BoxFit.fitWidth),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 300,
                              color: Colors.grey.shade100,
                              child: Image.network(controller.imageUrl,
                                  fit: BoxFit.fitWidth),
                            ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              updateData.imageFile == null
                  ? Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors()
                                    .darkshade), // Set your desired color
                          ),
                          onPressed: () async {
                            await updateData.pickImage();
                          },
                          child: Text(
                            'PICK IMAGE',
                            style: TextStyle(color: AppColors().primarytheme),
                          )),
                    )
                  : const Center(
                      child: Text(
                      'tap to change image ',
                      style: TextStyle(color: Colors.white),
                    )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: updateData.nameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: updateData.rollController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'roll no'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'roll number is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: 290,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonFormField(
                    focusColor: Colors.white,
                    value: updateData.selectedDivison,
                    decoration: const InputDecoration(
                      label: Text(
                        'Select Standard',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    items: updateData.divistions
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )))
                        .toList(),
                    onChanged: (val) {
                      updateData.selectedDivison = val as String?;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a division';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().darkshade,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors().primarytheme),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        updateData.uploadImage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBar(),
                            ));
                      }
                    },
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
