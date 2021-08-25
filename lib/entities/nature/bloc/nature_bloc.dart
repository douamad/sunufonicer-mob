import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/nature/nature_model.dart';
import 'package:sunufoncier/entities/nature/nature_repository.dart';
import 'package:sunufoncier/entities/nature/bloc/nature_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'nature_events.dart';
part 'nature_state.dart';

class NatureBloc extends Bloc<NatureEvent, NatureState> {
  final NatureRepository _natureRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  NatureBloc({required NatureRepository natureRepository}) :
        _natureRepository = natureRepository,
  super(NatureState());

  @override
  void onTransition(Transition<NatureEvent, NatureState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<NatureState> mapEventToState(NatureEvent event) async* {
    if (event is InitNatureList) {
      yield* onInitList(event);
    } else if (event is NatureFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadNatureByIdForEdit) {
      yield* onLoadNatureIdForEdit(event);
    } else if (event is DeleteNatureById) {
      yield* onDeleteNatureId(event);
    } else if (event is LoadNatureByIdForView) {
      yield* onLoadNatureIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<NatureState> onInitList(InitNatureList event) async* {
    yield this.state.copyWith(natureStatusUI: NatureStatusUI.loading);
    List<Nature>? natures = await _natureRepository.getAllNatures();
    yield this.state.copyWith(natures: natures, natureStatusUI: NatureStatusUI.done);
  }

  Stream<NatureState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Nature? result;
        if(this.state.editMode) {
          Nature newNature = Nature(state.loadedNature.id,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _natureRepository.update(newNature);
        } else {
          Nature newNature = Nature(null,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _natureRepository.create(newNature);
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

  Stream<NatureState> onLoadNatureIdForEdit(LoadNatureByIdForEdit? event) async* {
    yield this.state.copyWith(natureStatusUI: NatureStatusUI.loading);
    Nature? loadedNature = await _natureRepository.getNature(event?.id);

    final code = CodeInput.dirty((loadedNature!.code != null ? loadedNature.code: '')!);
    final libelle = LibelleInput.dirty((loadedNature.libelle != null ? loadedNature.libelle: '')!);

    yield this.state.copyWith(loadedNature: loadedNature, editMode: true,
      code: code,
      libelle: libelle,
    natureStatusUI: NatureStatusUI.done);

    codeController.text = loadedNature.code!;
    libelleController.text = loadedNature.libelle!;
  }

  Stream<NatureState> onDeleteNatureId(DeleteNatureById event) async* {
    try {
      await _natureRepository.delete(event.id!);
      this.add(InitNatureList());
      yield this.state.copyWith(deleteStatus: NatureDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: NatureDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: NatureDeleteStatus.none);
  }

  Stream<NatureState> onLoadNatureIdForView(LoadNatureByIdForView event) async* {
    yield this.state.copyWith(natureStatusUI: NatureStatusUI.loading);
    try {
      Nature? loadedNature = await _natureRepository.getNature(event.id);
      yield this.state.copyWith(loadedNature: loadedNature, natureStatusUI: NatureStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedNature: null, natureStatusUI: NatureStatusUI.error);
    }
  }


  Stream<NatureState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<NatureState> onLibelleChange(LibelleChanged event) async* {
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
