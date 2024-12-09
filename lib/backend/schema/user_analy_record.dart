import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserAnalyRecord extends FirestoreRecord {
  UserAnalyRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "symptom" field.
  List<String>? _symptom;
  List<String> get symptom => _symptom ?? const [];
  bool hasSymptom() => _symptom != null;

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  void _initializeFields() {
    _symptom = getDataList(snapshotData['symptom']);
    _owner = snapshotData['owner'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userAnaly');

  static Stream<UserAnalyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserAnalyRecord.fromSnapshot(s));

  static Future<UserAnalyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserAnalyRecord.fromSnapshot(s));

  static UserAnalyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserAnalyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserAnalyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserAnalyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserAnalyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserAnalyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserAnalyRecordData({
  DocumentReference? owner,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'owner': owner,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserAnalyRecordDocumentEquality implements Equality<UserAnalyRecord> {
  const UserAnalyRecordDocumentEquality();

  @override
  bool equals(UserAnalyRecord? e1, UserAnalyRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.symptom, e2?.symptom) &&
        e1?.owner == e2?.owner;
  }

  @override
  int hash(UserAnalyRecord? e) =>
      const ListEquality().hash([e?.symptom, e?.owner]);

  @override
  bool isValidKey(Object? o) => o is UserAnalyRecord;
}
