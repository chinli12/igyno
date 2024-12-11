import '/flutter_flow/flutter_flow_util.dart';
import 'perioddate_widget.dart' show PerioddateWidget;
import 'package:flutter/material.dart';

class PerioddateModel extends FlutterFlowModel<PerioddateWidget> {
  ///  Local state fields for this component.

  int periodlength = 0;

  int cycle = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for periodLenght widget.
  FocusNode? periodLenghtFocusNode;
  TextEditingController? periodLenghtTextController;
  String? Function(BuildContext, String?)? periodLenghtTextControllerValidator;
  DateTime? datePicked;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    periodLenghtFocusNode?.dispose();
    periodLenghtTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();
  }
}
