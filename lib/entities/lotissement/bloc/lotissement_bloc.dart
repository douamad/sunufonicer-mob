import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/lotissement/lotissement_model.dart';
import 'package:sunufoncier/entities/lotissement/lotissement_repository.dart';
import 'package:sunufoncier/entities/lotissement/bloc/lotissement_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'lotissement_events.dart';
part 'lotissement_state.dart';

class LotissementBloc extends Bloc<LotissementEvent, LotissementState> {
  final LotissementRepository _lotissementRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  LotissementBloc({required LotissementRepository lotissementRepository}) :
        _lotissementRepository = lotissementRepository,
  super(LotissementState());

  @override
  void onTransition(Transition<LotissementEvent, LotissementState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<LotissementState> mapEventToState(LotissementEvent event) async* {
    if (event is InitLotissementList) {
      yield* onInitList(event);
    } else if (event is LotissementFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadLotissementByIdForEdit) {
      yield* onLoadLotissementIdForEdit(event);
    } else if (event is DeleteLotissementById) {
      yield* onDeleteLotissementId(event);
    } else if (event is LoadLotissementByIdForView) {
      yield* onLoadLotissementIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<LotissementState> onInitList(InitLotissementList event) async* {
    yield this.state.copyWith(lotissementStatusUI: LotissementStatusUI.loading);
    List<Lotissement>? lotissements = await _lotissementRepository.getAllLotissements();
    yield this.state.copyWith(lotissements: lotissements, lotissementStatusUI: LotissementStatusUI.done);
  }

  Stream<LotissementState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Lotissement? result;
        if(this.state.editMode) {
          Lotissement newLotissement = Lotissement(state.loadedLotissement.id,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _lotissementRepository.update(newLotissement);
        } else {
          Lotissement newLotissement = Lotissement(null,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _lotissementRepository.create(newLotissement);
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

  Stream<LotissementState> onLoadLotissementIdForEdit(LoadLotissementByIdForEdit? event) async* {
    yield this.state.copyWith(lotissementStatusUI: LotissementStatusUI.loading);
    Lotissement? loadedLotissement = await _lotissementRepository.getLotissement(event?.id);

    final code = CodeInput.dirty((loadedLotissement!.code != null ? loadedLotissement.code: '')!);
    final libelle = LibelleInput.dirty((loadedLotissement.libelle != null ? loadedLotissement.libelle: '')!);

    yield this.state.copyWith(loadedLotissement: loadedLotissement, editMode: true,
      code: code,
      libelle: libelle,
    lotissementStatusUI: LotissementStatusUI.done);

    codeController.text = loadedLotissement.code!;
    libelleController.text = loadedLotissement.libelle!;
  }

  Stream<LotissementState> onDeleteLotissementId(DeleteLotissementById event) async* {
    try {
      await _lotissementRepository.delete(event.id!);
      this.add(InitLotissementList());
      yield this.state.copyWith(deleteStatus: LotissementDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: LotissementDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: LotissementDeleteStatus.none);
  }

  Stream<LotissementState> onLoadLotissementIdForView(LoadLotissementByIdForView event) async* {
    yield this.state.copyWith(lotissementStatusUI: LotissementStatusUI.loading);
    try {
      Lotissement? loadedLotissement = await _lotissementRepository.getLotissement(event.id);
      yield this.state.copyWith(loadedLotissement: loadedLotissement, lotissementStatusUI: LotissementStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedLotissement: null, lotissementStatusUI: LotissementStatusUI.error);
    }
  }


  Stream<LotissementState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<LotissementState> onLibelleChange(LibelleChanged event) async* {
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
