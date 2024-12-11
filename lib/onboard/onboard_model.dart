import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'onboard_widget.dart' show OnboardWidget;
import 'package:flutter/material.dart';

class OnboardModel extends FlutterFlowModel<OnboardWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  DateTime? datePicked;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for HealthInformation widget.
  FormFieldController<List<String>>? healthInformationValueController;
  String? get healthInformationValue =>
      healthInformationValueController?.value?.firstOrNull;
  set healthInformationValue(String? val) =>
      healthInformationValueController?.value = val != null ? [val] : [];
  // State field(s) for Lifestyle widget.
  FormFieldController<List<String>>? lifestyleValueController;
  String? get lifestyleValue => lifestyleValueController?.value?.firstOrNull;
  set lifestyleValue(String? val) =>
      lifestyleValueController?.value = val != null ? [val] : [];
  // State field(s) for Goals widget.
  FormFieldController<List<String>>? goalsValueController;
  String? get goalsValue => goalsValueController?.value?.firstOrNull;
  set goalsValue(String? val) =>
      goalsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  UserAnalyRecord? useranalysis;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();
  }
}
