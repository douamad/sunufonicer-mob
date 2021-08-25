import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/departement/departement_model.dart';
import 'package:sunufoncier/entities/departement/departement_repository.dart';
import 'package:sunufoncier/entities/departement/bloc/departement_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'departement_events.dart';
part 'departement_state.dart';

class DepartementBloc extends Bloc<DepartementEvent, DepartementState> {
  final DepartementRepository _departementRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  DepartementBloc({required DepartementRepository departementRepository}) :
        _departementRepository = departementRepository,
  super(DepartementState());

  @override
  void onTransition(Transition<DepartementEvent, DepartementState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<DepartementState> mapEventToState(DepartementEvent event) async* {
    if (event is InitDepartementList) {
      yield* onInitList(event);
    } else if (event is DepartementFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadDepartementByIdForEdit) {
      yield* onLoadDepartementIdForEdit(event);
    } else if (event is DeleteDepartementById) {
      yield* onDeleteDepartementId(event);
    } else if (event is LoadDepartementByIdForView) {
      yield* onLoadDepartementIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<DepartementState> onInitList(InitDepartementList event) async* {
    yield this.state.copyWith(departementStatusUI: DepartementStatusUI.loading);
    List<Departement>? departements = await _departementRepository.getAllDepartements();
    yield this.state.copyWith(departements: departements, departementStatusUI: DepartementStatusUI.done);
  }

  Stream<DepartementState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Departement? result;
        if(this.state.editMode) {
          Departement newDepartement = Departement(state.loadedDepartement.id,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _departementRepository.update(newDepartement);
        } else {
          Departement newDepartement = Departement(null,
            this.state.code.value,
            this.state.libelle.value,
            null,
          );

          result = await _departementRepository.create(newDepartement);
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

  Stream<DepartementState> onLoadDepartementIdForEdit(LoadDepartementByIdForEdit? event) async* {
    yield this.state.copyWith(departementStatusUI: DepartementStatusUI.loading);
    Departement? loadedDepartement = await _departementRepository.getDepartement(event?.id);

    final code = CodeInput.dirty((loadedDepartement!.code != null ? loadedDepartement.code: '')!);
    final libelle = LibelleInput.dirty((loadedDepartement.libelle != null ? loadedDepartement.libelle: '')!);

    yield this.state.copyWith(loadedDepartement: loadedDepartement, editMode: true,
      code: code,
      libelle: libelle,
    departementStatusUI: DepartementStatusUI.done);

    codeController.text = loadedDepartement.code!;
    libelleController.text = loadedDepartement.libelle!;
  }

  Stream<DepartementState> onDeleteDepartementId(DeleteDepartementById event) async* {
    try {
      await _departementRepository.delete(event.id!);
      this.add(InitDepartementList());
      yield this.state.copyWith(deleteStatus: DepartementDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: DepartementDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: DepartementDeleteStatus.none);
  }

  Stream<DepartementState> onLoadDepartementIdForView(LoadDepartementByIdForView event) async* {
    yield this.state.copyWith(departementStatusUI: DepartementStatusUI.loading);
    try {
      Departement? loadedDepartement = await _departementRepository.getDepartement(event.id);
      yield this.state.copyWith(loadedDepartement: loadedDepartement, departementStatusUI: DepartementStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedDepartement: null, departementStatusUI: DepartementStatusUI.error);
    }
  }


  Stream<DepartementState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<DepartementState> onLibelleChange(LibelleChanged event) async* {
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
