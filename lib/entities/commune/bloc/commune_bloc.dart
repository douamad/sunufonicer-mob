import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/commune/commune_model.dart';
import 'package:sunufoncier/entities/commune/commune_repository.dart';
import 'package:sunufoncier/entities/commune/bloc/commune_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'commune_events.dart';
part 'commune_state.dart';

class CommuneBloc extends Bloc<CommuneEvent, CommuneState> {
  final CommuneRepository _communeRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  CommuneBloc({required CommuneRepository communeRepository}) :
        _communeRepository = communeRepository,
  super(CommuneState());

  @override
  void onTransition(Transition<CommuneEvent, CommuneState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<CommuneState> mapEventToState(CommuneEvent event) async* {
    if (event is InitCommuneList) {
      yield* onInitList(event);
    } else if (event is CommuneFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadCommuneByIdForEdit) {
      yield* onLoadCommuneIdForEdit(event);
    } else if (event is DeleteCommuneById) {
      yield* onDeleteCommuneId(event);
    } else if (event is LoadCommuneByIdForView) {
      yield* onLoadCommuneIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<CommuneState> onInitList(InitCommuneList event) async* {
    yield this.state.copyWith(communeStatusUI: CommuneStatusUI.loading);
    List<Commune>? communes = await _communeRepository.getAllCommunes();
    yield this.state.copyWith(communes: communes, communeStatusUI: CommuneStatusUI.done);
  }

  Stream<CommuneState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Commune? result;
        if(this.state.editMode) {
          Commune newCommune = Commune(state.loadedCommune.id,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _communeRepository.update(newCommune);
        } else {
          Commune newCommune = Commune(null,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _communeRepository.create(newCommune);
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

  Stream<CommuneState> onLoadCommuneIdForEdit(LoadCommuneByIdForEdit? event) async* {
    yield this.state.copyWith(communeStatusUI: CommuneStatusUI.loading);
    Commune? loadedCommune = await _communeRepository.getCommune(event?.id);

    final code = CodeInput.dirty((loadedCommune!.code != null ? loadedCommune.code: '')!);
    final libelle = LibelleInput.dirty((loadedCommune.libelle != null ? loadedCommune.libelle: '')!);

    yield this.state.copyWith(loadedCommune: loadedCommune, editMode: true,
      code: code,
      libelle: libelle,
    communeStatusUI: CommuneStatusUI.done);

    codeController.text = loadedCommune.code!;
    libelleController.text = loadedCommune.libelle!;
  }

  Stream<CommuneState> onDeleteCommuneId(DeleteCommuneById event) async* {
    try {
      await _communeRepository.delete(event.id!);
      this.add(InitCommuneList());
      yield this.state.copyWith(deleteStatus: CommuneDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: CommuneDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: CommuneDeleteStatus.none);
  }

  Stream<CommuneState> onLoadCommuneIdForView(LoadCommuneByIdForView event) async* {
    yield this.state.copyWith(communeStatusUI: CommuneStatusUI.loading);
    try {
      Commune? loadedCommune = await _communeRepository.getCommune(event.id);
      yield this.state.copyWith(loadedCommune: loadedCommune, communeStatusUI: CommuneStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedCommune: null, communeStatusUI: CommuneStatusUI.error);
    }
  }


  Stream<CommuneState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<CommuneState> onLibelleChange(LibelleChanged event) async* {
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
