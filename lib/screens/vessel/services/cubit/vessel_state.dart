// vessel_state.dart
import 'package:equatable/equatable.dart';

import '../../model/vessel_list_model.dart';

abstract class VesselState extends Equatable {
  const VesselState();

  @override
  List<Object?> get props => [];
}

class VesselInitial extends VesselState {}

class VesselLoading extends VesselState {}

class VesselLoadingMore extends VesselState {
  final List<VesselListModel> currentVessels;

  const VesselLoadingMore({required this.currentVessels});

  @override
  List<Object?> get props => [currentVessels];
}

class VesselLoaded extends VesselState {
  final List<VesselListModel> vessels;
  final bool hasMoreData;
  final bool hasNoRecord;
  final int currentPage;
  final String? appliedFilter;
  final VesselSearchFilters searchFilters;

  const VesselLoaded({
    required this.vessels,
    required this.hasMoreData,
    required this.hasNoRecord,
    required this.currentPage,
    this.appliedFilter,
    required this.searchFilters,
  });

  VesselLoaded copyWith({
    List<VesselListModel>? vessels,
    bool? hasMoreData,
    bool? hasNoRecord,
    int? currentPage,
    String? appliedFilter,
    VesselSearchFilters? searchFilters,
  }) {
    return VesselLoaded(
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

class VesselError extends VesselState {
  final String message;

  const VesselError({required this.message});

  @override
  List<Object?> get props => [message];
}

class VesselSearchFilters extends Equatable {
  final String? vesselId;
  final String? imoName;
  final String? vesselName;

  const VesselSearchFilters({
    this.vesselId,
    this.imoName,
    this.vesselName,
  });

  bool get hasFilters =>
      (vesselId?.isNotEmpty ?? false) ||
          (imoName?.isNotEmpty ?? false) ||
          (vesselName?.isNotEmpty ?? false);

  VesselSearchFilters copyWith({
    String? vesselId,
    String? imoName,
    String? vesselName,
  }) {
    return VesselSearchFilters(
      vesselId: vesselId ?? this.vesselId,
      imoName: imoName ?? this.imoName,
      vesselName: vesselName ?? this.vesselName,
    );
  }

  VesselSearchFilters clear() {
    return const VesselSearchFilters();
  }

  @override
  List<Object?> get props => [vesselId, imoName, vesselName];
}