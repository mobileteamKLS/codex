// vessel_state.dart
import 'package:equatable/equatable.dart';
import '../../../../vessel/model/vessel_list_model.dart';
import '../../model/departureListModel.dart';

abstract class DepartureState extends Equatable {
  const DepartureState();

  @override
  List<Object?> get props => [];
}

class DepartureInitial extends DepartureState {}

class DepartureLoading extends DepartureState {}

class DepartureLoadingMore extends DepartureState {
  final List<DepartureListModel> currentVessels;

  const DepartureLoadingMore({required this.currentVessels});

  @override
  List<Object?> get props => [currentVessels];
}

class DepartureLoaded extends DepartureState {
  final List<DepartureListModel> vessels;
  final bool hasMoreData;
  final bool hasNoRecord;
  final int currentPage;
  final int? appliedFilter;
  final VesselSearchFilters searchFilters;

  const DepartureLoaded({
    required this.vessels,
    required this.hasMoreData,
    required this.hasNoRecord,
    required this.currentPage,
    this.appliedFilter,
    required this.searchFilters,
  });

  DepartureLoaded copyWith({
    List<DepartureListModel>? vessels,
    bool? hasMoreData,
    bool? hasNoRecord,
    int? currentPage,
    int? appliedFilter,
    VesselSearchFilters? searchFilters,
  }) {
    return DepartureLoaded(
      vessels: vessels ?? this.vessels,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      hasNoRecord: hasNoRecord ?? this.hasNoRecord,
      currentPage: currentPage ?? this.currentPage,
      appliedFilter: appliedFilter ?? this.appliedFilter,
      searchFilters: searchFilters ?? this.searchFilters,
    );
  }

  @override
  List<Object?> get props => [
    vessels,
    hasMoreData,
    hasNoRecord,
    currentPage,
    appliedFilter,
    searchFilters,
  ];
}

class VesselError extends DepartureState {
  final String message;

  const VesselError({required this.message});

  @override
  List<Object?> get props => [message];
}

class VesselSearchFilters extends Equatable {
  final String? vesselId;
  final String? scn;
  final String? imoName;
  final String? vesselName;

  const VesselSearchFilters({
    this.vesselId,
    this.scn,
    this.imoName,
    this.vesselName,
  });

  bool get hasFilters =>
      (vesselId?.isNotEmpty ?? false) ||
          (scn?.isNotEmpty ?? false) ||
          (imoName?.isNotEmpty ?? false) ||
          (vesselName?.isNotEmpty ?? false);

  VesselSearchFilters copyWith({
    String? vesselId,
    String? imoName,
    String? vesselName,
    String? scn,
  }) {
    return VesselSearchFilters(
      vesselId: vesselId ?? this.vesselId,
      imoName: imoName ?? this.imoName,
      vesselName: vesselName ?? this.vesselName,
      scn: vesselName ?? this.scn,
    );
  }

  VesselSearchFilters clear() {
    return const VesselSearchFilters();
  }

  @override
  List<Object?> get props => [vesselId, imoName, vesselName,scn];
}