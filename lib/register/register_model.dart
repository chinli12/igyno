import '/flutter_flow/flutter_flow_util.dart';
import 'register_widget.dart' show RegisterWidget;
import 'package:flutter/material.dart';

class RegisterModel extends FlutterFlowModel<RegisterWidget> {
  ///  Local state fields for this page.

  int? lengh = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for pass1 widget.
  FocusNode? pass1FocusNode;
  TextEditingController? pass1TextController;
  late bool pass1Visibility;
  String? Function(BuildContext, String?)? pass1TextControllerValidator;
  // State field(s) for pass2 widget.
  FocusNode? pass2FocusNode;
  TextEditingController? pass2TextController;
  late bool pass2Visibility;
  String? Function(BuildContext, String?)? pass2TextControllerValidator;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {
    pass1Visibility = false;
    pass2Visibility = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    emailTextController?.dispose();

    textFieldFocusNode2?.dispose();
    textController1?.dispose();

    pass1FocusNode?.dispose();
    pass1TextController?.dispose();

    pass2FocusNode?.dispose();
    pass2TextController?.dispose();
  }
}
