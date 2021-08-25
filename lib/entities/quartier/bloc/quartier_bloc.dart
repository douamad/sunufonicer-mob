import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/quartier/quartier_model.dart';
import 'package:sunufoncier/entities/quartier/quartier_repository.dart';
import 'package:sunufoncier/entities/quartier/bloc/quartier_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'quartier_events.dart';
part 'quartier_state.dart';

class QuartierBloc extends Bloc<QuartierEvent, QuartierState> {
  final QuartierRepository _quartierRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  QuartierBloc({required QuartierRepository quartierRepository}) :
        _quartierRepository = quartierRepository,
  super(QuartierState());

  @override
  void onTransition(Transition<QuartierEvent, QuartierState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<QuartierState> mapEventToState(QuartierEvent event) async* {
    if (event is InitQuartierList) {
      yield* onInitList(event);
    } else if (event is QuartierFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadQuartierByIdForEdit) {
      yield* onLoadQuartierIdForEdit(event);
    } else if (event is DeleteQuartierById) {
      yield* onDeleteQuartierId(event);
    } else if (event is LoadQuartierByIdForView) {
      yield* onLoadQuartierIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<QuartierState> onInitList(InitQuartierList event) async* {
    yield this.state.copyWith(quartierStatusUI: QuartierStatusUI.loading);
    List<Quartier>? quartiers = await _quartierRepository.getAllQuartiers();
    yield this.state.copyWith(quartiers: quartiers, quartierStatusUI: QuartierStatusUI.done);
  }

  Stream<QuartierState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Quartier? result;
        if(this.state.editMode) {
          Quartier newQuartier = Quartier(state.loadedQuartier.id,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _quartierRepository.update(newQuartier);
        } else {
          Quartier newQuartier = Quartier(null,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _quartierRepository.create(newQuartier);
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

  Stream<QuartierState> onLoadQuartierIdForEdit(LoadQuartierByIdForEdit? event) async* {
    yield this.state.copyWith(quartierStatusUI: QuartierStatusUI.loading);
    Quartier? loadedQuartier = await _quartierRepository.getQuartier(event?.id);

    final code = CodeInput.dirty((loadedQuartier!.code != null ? loadedQuartier.code: '')!);
    final libelle = LibelleInput.dirty((loadedQuartier.libelle != null ? loadedQuartier.libelle: '')!);

    yield this.state.copyWith(loadedQuartier: loadedQuartier, editMode: true,
      code: code,
      libelle: libelle,
    quartierStatusUI: QuartierStatusUI.done);

    codeController.text = loadedQuartier.code!;
    libelleController.text = loadedQuartier.libelle!;
  }

  Stream<QuartierState> onDeleteQuartierId(DeleteQuartierById event) async* {
    try {
      await _quartierRepository.delete(event.id!);
      this.add(InitQuartierList());
      yield this.state.copyWith(deleteStatus: QuartierDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: QuartierDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: QuartierDeleteStatus.none);
  }

  Stream<QuartierState> onLoadQuartierIdForView(LoadQuartierByIdForView event) async* {
    yield this.state.copyWith(quartierStatusUI: QuartierStatusUI.loading);
    try {
      Quartier? loadedQuartier = await _quartierRepository.getQuartier(event.id);
      yield this.state.copyWith(loadedQuartier: loadedQuartier, quartierStatusUI: QuartierStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedQuartier: null, quartierStatusUI: QuartierStatusUI.error);
    }
  }


  Stream<QuartierState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<QuartierState> onLibelleChange(LibelleChanged event) async* {
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
