
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../vessel_repository.dart';
import 'vessel_state.dart';

class VesselCubit extends Cubit<VesselState> {
  final VesselRepository _repository;
  static const int _pageSize = 10;
  bool _isLoadingMore = false;
  Timer? _debounceTimer;
  VesselCubit({required VesselRepository repository})
      : _repository = repository,
        super(VesselInitial());

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> loadVessels({
    bool isRefresh = false,
    String? statusFilter,
    VesselSearchFilters? searchFilters,
  }) async {
    try {
      if (isRefresh || state is VesselInitial) {
        emit(VesselLoading());
      }

      final response = await _repository.getAllVessels(
        vesselId: searchFilters?.vesselId,
        imoName: searchFilters?.imoName,
        vesselName: searchFilters?.vesselName,
        status: statusFilter,
        pageIndex: 1,
        pageSize: _pageSize,
      );

      emit(VesselLoaded(
        vessels: response.vessels,
        hasMoreData: response.hasMoreData,
        hasNoRecord: response.hasNoRecord,
        currentPage: 1,
        appliedFilter: statusFilter,
        searchFilters: searchFilters ?? const VesselSearchFilters(),
      ));
    } catch (e) {
      emit(VesselError(message: e.toString()));
    }
  }

  Future<void> loadMoreVessels() async {
    final currentState = state;
    if (currentState is! VesselLoaded) return;
    if (!currentState.hasMoreData) return;
    if (_isLoadingMore) return;
    _debounceTimer?.cancel();

    // Set up new timer
    _debounceTimer = Timer(const Duration(milliseconds: 1500), () async {
    try {
      _isLoadingMore = true;
      //emit(VesselLoadingMore(currentVessels: currentState.vessels));

      final nextPage = currentState.currentPage + 1;
      final response = await _repository.getAllVessels(
        vesselId: currentState.searchFilters.vesselId,
        imoName: currentState.searchFilters.imoName,
        vesselName: currentState.searchFilters.vesselName,
        status: currentState.appliedFilter,
        pageIndex: nextPage,
        pageSize: _pageSize,
      );

      emit(currentState.copyWith(
        vessels: [...currentState.vessels, ...response.vessels],
        hasMoreData: response.hasMoreData,
        currentPage: nextPage,
      ));
    } catch (e) {
      emit(VesselError(message: e.toString()));
    }
    finally{
      _isLoadingMore = false;
    }
  });
  }

  Future<void> searchVessels({
    required String? vesselId,
    required String? imoName,
    required String? vesselName,
  }) async {
    final searchFilters = VesselSearchFilters(
      vesselId: vesselId?.trim().isEmpty == true ? null : vesselId?.trim(),
      imoName: imoName?.trim().isEmpty == true ? null : imoName?.trim(),
      vesselName: vesselName?.trim().isEmpty == true ? null : vesselName?.trim(),
    );

    String? currentStatusFilter;
    if (state is VesselLoaded) {
      currentStatusFilter = (state as VesselLoaded).appliedFilter;
    }

    await loadVessels(
      isRefresh: true,
      statusFilter: currentStatusFilter,
      searchFilters: searchFilters,
    );
  }

  Future<void> applyStatusFilter(String? statusFilter) async {
    VesselSearchFilters? currentSearchFilters;
    if (state is VesselLoaded) {
      currentSearchFilters = (state as VesselLoaded).searchFilters;
    }

    await loadVessels(
      isRefresh: true,
      statusFilter: statusFilter,
      searchFilters: currentSearchFilters,
    );
  }

  Future<void> clearFilters() async {
    await loadVessels(
      isRefresh: true,
      statusFilter: null,
      searchFilters: const VesselSearchFilters(),
    );
  }

  Future<void> refreshData() async {
    String? currentStatusFilter;
    VesselSearchFilters? currentSearchFilters;

    if (state is VesselLoaded) {
      final currentState = state as VesselLoaded;
      currentStatusFilter = currentState.appliedFilter;
      currentSearchFilters = currentState.searchFilters;
    }

    await loadVessels(
      isRefresh: true,
      statusFilter: currentStatusFilter,
      searchFilters: currentSearchFilters,
    );
  }
}