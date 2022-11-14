import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/approval_screen.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/shared/buttons/button_widget.dart';
import '../../../../../data/controller/user_management_controller/user_details_controller.dart';
import '../../../../../storage/sherd_perf.dart';
import '../../../verification/id_verification/id_verification_screen.dart';

class DisapprovalScreen extends StatefulWidget {
  const DisapprovalScreen({required this.type, super.key});
  final String type;

  @override
  State<DisapprovalScreen> createState() => _DisapprovalScreenState();
}

class _DisapprovalScreenState extends State<DisapprovalScreen> {
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormFieldState> noteKey = GlobalKey();
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsController>(
        builder: (context, userDetails, child) => Scaffold(
              appBar: CustomAppBarWidget(
                  title:
                      '${widget.type == "id" ? "ID" : "Address"} Disapproval'),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for Disapproval',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                    ),
                    PopUpVerificationWidget(
                      documentType: userDetails.resonDisapproval,
                      onSelected: (value) {
                        userDetails.setSelected(value);
                      },
                      selected: userDetails.selected ?? '',
                      title: '',
                    ),
                    addVerticalSpace(20),
                    TextFormField(
                      key: noteKey,
                      maxLines: 4,
                      controller: noteController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          hintText:
                              'Write down other reasons or add describtion'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required data';
                        }
                      },
                    ),
                    addVerticalSpace(60),
                    ButtonWidget(
                        text: 'Submit',
                        visible: false,
                        onPressed: () {
                          if (noteKey.currentState!.validate()) {
                            userDetails.userDisapproval(
                                token: SharedPrefController()
                                    .getUser()
                                    .accessToken,
                                id: userDetails.userDetailsInfo!.id,
                                type: widget.type,
                                note: noteController.text,
                                reason: userDetails.selected ?? 'defulat');
                          }
                        })
                  ],
                ),
              ),
            ));
  }
}
