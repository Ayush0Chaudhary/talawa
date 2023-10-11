import 'package:flutter/material.dart';
import 'package:talawa/enums/enums.dart';
import 'package:talawa/locator.dart';
import 'package:talawa/utils/app_localization.dart';
import 'package:talawa/view_model/after_auth_view_models/add_post_view_models/add_post_view_model.dart';
import 'package:talawa/views/base_view.dart';

/// Add Post View Model.
late AddPostViewModel model;

/// AddPost returns a widget to add(upload) the post.
class AddPost extends StatelessWidget {
  const AddPost({super.key, this.drawerKey});

  /// DrawerKey.
  final GlobalKey<ScaffoldState>? drawerKey;

  @override
  Widget build(BuildContext context) {
    // final Uint8List imageBytes = base64Decode(sampleBase64Image);
    // final Uint8List bytes = BASE64.decode(_base64);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // header for the widget
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.9,
        centerTitle: true,
        // header title
        title: Text(
          AppLocalizations.of(context)!.strictTranslate('Share News'),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
        ),
        leading: IconButton(
          //TODO: showing the null pointer exception
          key: const Key('add_post_icon_button1'),
          color: Theme.of(context).iconTheme.color,
          icon: const Icon(Icons.menu),
          onPressed: () => drawerKey!.currentState!.openDrawer(),
        ),
        // button to upload the post.
        actions: [
          TextButton(
            key: const Key('add_post_text_btn1'),
            onPressed: () {
              model.uploadPost();
              // convertImageToBase64(sampleBase64Image);
            },
            child: Text(
              AppLocalizations.of(context)!.strictTranslate("Post"),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          // Image.memory(imageBytes)
        ],
      ),
      body: BaseView<AddPostViewModel>(
        onModelReady: (m) {
          m.initialise();
          model = m;
        },
        builder: (context, model, child) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(radius: 25),
                title: Text(model.userName),
                subtitle: Text(
                  AppLocalizations.of(context)!.strictTranslate(model.orgName),
                ),
              ),
              // renders icon button to upload post files.
              Row(
                children: <Widget>[
                  // button to select the photo from gallery.
                  IconButton(
                    key: const Key('add_post_icon_button2'),
                    onPressed: () => model.getImageFromGallery(),
                    icon: const Icon(Icons.photo),
                  ),
                  // button to capture the image.
                  IconButton(
                    key: const Key('add_post_icon_button3'),
                    onPressed: () => model.getImageFromGallery(camera: true),
                    icon: const Icon(Icons.camera_alt),
                  ),
                  // button to add hastags to the post.
                  TextButton(
                    key: const Key('add_post_text_btn2'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Enter the Tag"),
                            content: TextField(
                              controller: model.textHashTagController,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  navigationService.showTalawaErrorSnackBar(
                                    "The tag was added",
                                    MessageType.info,
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Add"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      model.textHashTagController.text == ""
                          ? '# ${AppLocalizations.of(context)!.strictTranslate("Add tag")}'
                          : model.textHashTagController.text,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: model.titleController,
                  // input field to write the description of the post.
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.strictTranslate(
                      "Enter the title of your post",
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.strictTranslate(
                        "Title",
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: model.controller,
                  maxLines: null,
                  // input field to write the description of the post.
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.strictTranslate(
                      "Write here what do you want to share",
                    ),
                  ),
                ),
              ),
              // if the image for the post is added then render button to remove it.
              model.imageFile != null
                  // ignore: sized_box_for_whitespace
                  ? Container(
                      height: 230,
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          // Image.file(
                          //   model.imageFile!,
                          //   fit: BoxFit.cover,
                          //   width: MediaQuery.of(context).size.width,
                          // ),
                          Image.file(model.imageFile!),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: IconButton(
                              onPressed: () => model.removeImage(),
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
