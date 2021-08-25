import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/activite/activite_model.dart';
import 'package:sunufoncier/entities/activite/activite_repository.dart';
import 'package:sunufoncier/entities/activite/bloc/activite_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'activite_events.dart';
part 'activite_state.dart';

class ActiviteBloc extends Bloc<ActiviteEvent, ActiviteState> {
  final ActiviteRepository _activiteRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  ActiviteBloc({required ActiviteRepository activiteRepository}) :
        _activiteRepository = activiteRepository,
  super(ActiviteState());

  @override
  void onTransition(Transition<ActiviteEvent, ActiviteState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ActiviteState> mapEventToState(ActiviteEvent event) async* {
    if (event is InitActiviteList) {
      yield* onInitList(event);
    } else if (event is ActiviteFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadActiviteByIdForEdit) {
      yield* onLoadActiviteIdForEdit(event);
    } else if (event is DeleteActiviteById) {
      yield* onDeleteActiviteId(event);
    } else if (event is LoadActiviteByIdForView) {
      yield* onLoadActiviteIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<ActiviteState> onInitList(InitActiviteList event) async* {
    yield this.state.copyWith(activiteStatusUI: ActiviteStatusUI.loading);
    List<Activite>? activites = await _activiteRepository.getAllActivites();
    yield this.state.copyWith(activites: activites, activiteStatusUI: ActiviteStatusUI.done);
  }

  Stream<ActiviteState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Activite? result;
        if(this.state.editMode) {
          Activite newActivite = Activite(state.loadedActivite.id,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _activiteRepository.update(newActivite);
        } else {
          Activite newActivite = Activite(null,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _activiteRepository.create(newActivite);
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

  Stream<ActiviteState> onLoadActiviteIdForEdit(LoadActiviteByIdForEdit? event) async* {
    yield this.state.copyWith(activiteStatusUI: ActiviteStatusUI.loading);
    Activite? loadedActivite = await _activiteRepository.getActivite(event?.id);

    final code = CodeInput.dirty((loadedActivite!.code != null ? loadedActivite.code: '')!);
    final libelle = LibelleInput.dirty((loadedActivite.libelle != null ? loadedActivite.libelle: '')!);

    yield this.state.copyWith(loadedActivite: loadedActivite, editMode: true,
      code: code,
      libelle: libelle,
    activiteStatusUI: ActiviteStatusUI.done);

    codeController.text = loadedActivite.code!;
    libelleController.text = loadedActivite.libelle!;
  }

  Stream<ActiviteState> onDeleteActiviteId(DeleteActiviteById event) async* {
    try {
      await _activiteRepository.delete(event.id!);
      this.add(InitActiviteList());
      yield this.state.copyWith(deleteStatus: ActiviteDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ActiviteDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ActiviteDeleteStatus.none);
  }

  Stream<ActiviteState> onLoadActiviteIdForView(LoadActiviteByIdForView event) async* {
    yield this.state.copyWith(activiteStatusUI: ActiviteStatusUI.loading);
    try {
      Activite? loadedActivite = await _activiteRepository.getActivite(event.id);
      yield this.state.copyWith(loadedActivite: loadedActivite, activiteStatusUI: ActiviteStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedActivite: null, activiteStatusUI: ActiviteStatusUI.error);
    }
  }


  Stream<ActiviteState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<ActiviteState> onLibelleChange(LibelleChanged event) async* {
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
