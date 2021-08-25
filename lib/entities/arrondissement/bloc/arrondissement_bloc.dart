import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/arrondissement/arrondissement_model.dart';
import 'package:sunufoncier/entities/arrondissement/arrondissement_repository.dart';
import 'package:sunufoncier/entities/arrondissement/bloc/arrondissement_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'arrondissement_events.dart';
part 'arrondissement_state.dart';

class ArrondissementBloc extends Bloc<ArrondissementEvent, ArrondissementState> {
  final ArrondissementRepository _arrondissementRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  ArrondissementBloc({required ArrondissementRepository arrondissementRepository}) :
        _arrondissementRepository = arrondissementRepository,
  super(ArrondissementState());

  @override
  void onTransition(Transition<ArrondissementEvent, ArrondissementState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ArrondissementState> mapEventToState(ArrondissementEvent event) async* {
    if (event is InitArrondissementList) {
      yield* onInitList(event);
    } else if (event is ArrondissementFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadArrondissementByIdForEdit) {
      yield* onLoadArrondissementIdForEdit(event);
    } else if (event is DeleteArrondissementById) {
      yield* onDeleteArrondissementId(event);
    } else if (event is LoadArrondissementByIdForView) {
      yield* onLoadArrondissementIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<ArrondissementState> onInitList(InitArrondissementList event) async* {
    yield this.state.copyWith(arrondissementStatusUI: ArrondissementStatusUI.loading);
    List<Arrondissement>? arrondissements = await _arrondissementRepository.getAllArrondissements();
    yield this.state.copyWith(arrondissements: arrondissements, arrondissementStatusUI: ArrondissementStatusUI.done);
  }

  Stream<ArrondissementState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Arrondissement? result;
        if(this.state.editMode) {
          Arrondissement newArrondissement = Arrondissement(state.loadedArrondissement.id,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _arrondissementRepository.update(newArrondissement);
        } else {
          Arrondissement newArrondissement = Arrondissement(null,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _arrondissementRepository.create(newArrondissement);
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

  Stream<ArrondissementState> onLoadArrondissementIdForEdit(LoadArrondissementByIdForEdit? event) async* {
    yield this.state.copyWith(arrondissementStatusUI: ArrondissementStatusUI.loading);
    Arrondissement? loadedArrondissement = await _arrondissementRepository.getArrondissement(event?.id);

    final code = CodeInput.dirty((loadedArrondissement!.code != null ? loadedArrondissement.code: '')!);
    final libelle = LibelleInput.dirty((loadedArrondissement.libelle != null ? loadedArrondissement.libelle: '')!);

    yield this.state.copyWith(loadedArrondissement: loadedArrondissement, editMode: true,
      code: code,
      libelle: libelle,
    arrondissementStatusUI: ArrondissementStatusUI.done);

    codeController.text = loadedArrondissement.code!;
    libelleController.text = loadedArrondissement.libelle!;
  }

  Stream<ArrondissementState> onDeleteArrondissementId(DeleteArrondissementById event) async* {
    try {
      await _arrondissementRepository.delete(event.id!);
      this.add(InitArrondissementList());
      yield this.state.copyWith(deleteStatus: ArrondissementDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ArrondissementDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ArrondissementDeleteStatus.none);
  }

  Stream<ArrondissementState> onLoadArrondissementIdForView(LoadArrondissementByIdForView event) async* {
    yield this.state.copyWith(arrondissementStatusUI: ArrondissementStatusUI.loading);
    try {
      Arrondissement? loadedArrondissement = await _arrondissementRepository.getArrondissement(event.id);
      yield this.state.copyWith(loadedArrondissement: loadedArrondissement, arrondissementStatusUI: ArrondissementStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedArrondissement: null, arrondissementStatusUI: ArrondissementStatusUI.error);
    }
  }


  Stream<ArrondissementState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<ArrondissementState> onLibelleChange(LibelleChanged event) async* {
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
