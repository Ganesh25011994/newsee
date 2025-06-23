// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'land_holding_bloc.dart';

enum SaveState { initial, loading, success, failure }

class LandHoldingState extends Equatable {
  final SaveState? status;
  final List<Lov>? lovlist;
  final List<LandData>? landData;
  final String? errorMessage;
  final LandData? selectedLandData;

  const LandHoldingState({
    this.status,
    this.lovlist,
    this.landData,
    this.errorMessage,
    this.selectedLandData,
  });

  LandHoldingState copyWith({
    SaveState? status,
    List<Lov>? lovlist,
    List<LandData>? landData,
    String? errorMessage,
    LandData? selectedLandData,
  }) {
    return LandHoldingState(
      status: status ?? this.status,
      lovlist: lovlist ?? this.lovlist,
      landData: landData ?? this.landData,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedLandData: selectedLandData ?? this.selectedLandData,
    );
  }

  factory LandHoldingState.init() => const LandHoldingState(
    status: SaveState.initial,
    lovlist: [],
    landData: [],
    errorMessage: null,
    selectedLandData: null,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status?.name,
      'lovlist': lovlist?.map((lov) => lov.toMap()).toList(),
      'landData': landData?.map((x) => x.toMap()).toList(),
      'errorMessage': errorMessage,
      'selectedLandData': selectedLandData?.toMap(),
    };
  }

  factory LandHoldingState.fromMap(Map<String, dynamic> map) {
    return LandHoldingState(
      status: SaveState.values.byName(map['status']),
      lovlist:
          (map['lovlist'] as List<dynamic>?)
              ?.map((x) => Lov.fromMap(x as Map<String, dynamic>))
              .toList(),
      landData:
          (map['landData'] as List<dynamic>?)
              ?.map((x) => LandData.fromMap(x as Map<String, dynamic>))
              .toList(),
      errorMessage: map['errorMessage'] as String?,
      selectedLandData:
          map['selectedLandData'] != null
              ? LandData.fromMap(map['selectedLandData'])
              : null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    lovlist,
    landData,
    errorMessage,
    selectedLandData,
  ];
}
