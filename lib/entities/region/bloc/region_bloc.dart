import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/region/region_model.dart';
import 'package:sunufoncier/entities/region/region_repository.dart';
import 'package:sunufoncier/entities/region/bloc/region_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'region_events.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final RegionRepository _regionRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  RegionBloc({required RegionRepository regionRepository}) :
        _regionRepository = regionRepository,
  super(RegionState());

  @override
  void onTransition(Transition<RegionEvent, RegionState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<RegionState> mapEventToState(RegionEvent event) async* {
    if (event is InitRegionList) {
      yield* onInitList(event);
    } else if (event is RegionFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadRegionByIdForEdit) {
      yield* onLoadRegionIdForEdit(event);
    } else if (event is DeleteRegionById) {
      yield* onDeleteRegionId(event);
    } else if (event is LoadRegionByIdForView) {
      yield* onLoadRegionIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<RegionState> onInitList(InitRegionList event) async* {
    yield this.state.copyWith(regionStatusUI: RegionStatusUI.loading);
    List<Region>? regions = await _regionRepository.getAllRegions();
    yield this.state.copyWith(regions: regions, regionStatusUI: RegionStatusUI.done);
  }

  Stream<RegionState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Region? result;
        if(this.state.editMode) {
          Region newRegion = Region(state.loadedRegion.id,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _regionRepository.update(newRegion);
        } else {
          Region newRegion = Region(null,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _regionRepository.create(newRegion);
        }

        if (result == null) {
          yield this.state.copyWith(formStatus: FormzStatus.submissionFailure,
              generalNotificationKey: HttpUtils.badRequestServerKey);
        } else {
          yield this.state.copyWith(formStatus: FormzStatus.submissionSuccess,
              generalNotificationKey: HttpUtils.successResult);
        }
      } catch (e) {
        yield this.state.copyWith(formStatus: FormzStatus.submissionFailure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<RegionState> onLoadRegionIdForEdit(LoadRegionByIdForEdit? event) async* {
    yield this.state.copyWith(regionStatusUI: RegionStatusUI.loading);
    Region? loadedRegion = await _regionRepository.getRegion(event?.id);

    final code = CodeInput.dirty((loadedRegion!.code != null ? loadedRegion.code: '')!);
    final libelle = LibelleInput.dirty((loadedRegion.libelle != null ? loadedRegion.libelle: '')!);

    yield this.state.copyWith(loadedRegion: loadedRegion, editMode: true,
      code: code,
      libelle: libelle,
    regionStatusUI: RegionStatusUI.done);

    codeController.text = loadedRegion.code!;
    libelleController.text = loadedRegion.libelle!;
  }

  Stream<RegionState> onDeleteRegionId(DeleteRegionById event) async* {
    try {
      await _regionRepository.delete(event.id!);
      this.add(InitRegionList());
      yield this.state.copyWith(deleteStatus: RegionDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: RegionDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: RegionDeleteStatus.none);
  }

  Stream<RegionState> onLoadRegionIdForView(LoadRegionByIdForView event) async* {
    yield this.state.copyWith(regionStatusUI: RegionStatusUI.loading);
    try {
      Region? loadedRegion = await _regionRepository.getRegion(event.id);
      yield this.state.copyWith(loadedRegion: loadedRegion, regionStatusUI: RegionStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedRegion: null, regionStatusUI: RegionStatusUI.error);
    }
  }


  Stream<RegionState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<RegionState> onLibelleChange(LibelleChanged event) async* {
    final libelle = LibelleInput.dirty(event.libelle);
    yield this.state.copyWith(
      libelle: libelle,
      formStatus: Formz.validate([
      this.state.code,
        libelle,
      ]),
    );
  }

  @override
  Future<void> close() {
    codeController.dispose();
    libelleController.dispose();
    return super.close();
  }

}
