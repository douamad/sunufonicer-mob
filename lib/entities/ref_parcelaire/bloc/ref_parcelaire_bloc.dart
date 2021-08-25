import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_model.dart';
import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_repository.dart';
import 'package:sunufoncier/entities/ref_parcelaire/bloc/ref_parcelaire_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'ref_parcelaire_events.dart';
part 'ref_parcelaire_state.dart';

class RefParcelaireBloc extends Bloc<RefParcelaireEvent, RefParcelaireState> {
  final RefParcelaireRepository _refParcelaireRepository;

  final numeroParcelleController = TextEditingController();
  final natureParcelleController = TextEditingController();

  RefParcelaireBloc({required RefParcelaireRepository refParcelaireRepository}) :
        _refParcelaireRepository = refParcelaireRepository,
  super(RefParcelaireState());

  @override
  void onTransition(Transition<RefParcelaireEvent, RefParcelaireState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<RefParcelaireState> mapEventToState(RefParcelaireEvent event) async* {
    if (event is InitRefParcelaireList) {
      yield* onInitList(event);
    } else if (event is RefParcelaireFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadRefParcelaireByIdForEdit) {
      yield* onLoadRefParcelaireIdForEdit(event);
    } else if (event is DeleteRefParcelaireById) {
      yield* onDeleteRefParcelaireId(event);
    } else if (event is LoadRefParcelaireByIdForView) {
      yield* onLoadRefParcelaireIdForView(event);
    }else if (event is NumeroParcelleChanged){
      yield* onNumeroParcelleChange(event);
    }else if (event is NatureParcelleChanged){
      yield* onNatureParcelleChange(event);
    }  }

  Stream<RefParcelaireState> onInitList(InitRefParcelaireList event) async* {
    yield this.state.copyWith(refParcelaireStatusUI: RefParcelaireStatusUI.loading);
    List<RefParcelaire>? refParcelaires = await _refParcelaireRepository.getAllRefParcelaires();
    yield this.state.copyWith(refParcelaires: refParcelaires, refParcelaireStatusUI: RefParcelaireStatusUI.done);
  }

  Stream<RefParcelaireState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        RefParcelaire? result;
        if(this.state.editMode) {
          RefParcelaire newRefParcelaire = RefParcelaire(state.loadedRefParcelaire.id,
            this.state.numeroParcelle.value,
            this.state.natureParcelle.value,
          );

          result = await _refParcelaireRepository.update(newRefParcelaire);
        } else {
          RefParcelaire newRefParcelaire = RefParcelaire(null,
            this.state.numeroParcelle.value,
            this.state.natureParcelle.value,
          );

          result = await _refParcelaireRepository.create(newRefParcelaire);
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

  Stream<RefParcelaireState> onLoadRefParcelaireIdForEdit(LoadRefParcelaireByIdForEdit? event) async* {
    yield this.state.copyWith(refParcelaireStatusUI: RefParcelaireStatusUI.loading);
    RefParcelaire? loadedRefParcelaire = await _refParcelaireRepository.getRefParcelaire(event?.id);

    final numeroParcelle = NumeroParcelleInput.dirty((loadedRefParcelaire!.numeroParcelle != null ? loadedRefParcelaire.numeroParcelle: '')!);
    final natureParcelle = NatureParcelleInput.dirty((loadedRefParcelaire.natureParcelle != null ? loadedRefParcelaire.natureParcelle: '')!);

    yield this.state.copyWith(loadedRefParcelaire: loadedRefParcelaire, editMode: true,
      numeroParcelle: numeroParcelle,
      natureParcelle: natureParcelle,
    refParcelaireStatusUI: RefParcelaireStatusUI.done);

    numeroParcelleController.text = loadedRefParcelaire.numeroParcelle!;
    natureParcelleController.text = loadedRefParcelaire.natureParcelle!;
  }

  Stream<RefParcelaireState> onDeleteRefParcelaireId(DeleteRefParcelaireById event) async* {
    try {
      await _refParcelaireRepository.delete(event.id!);
      this.add(InitRefParcelaireList());
      yield this.state.copyWith(deleteStatus: RefParcelaireDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: RefParcelaireDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: RefParcelaireDeleteStatus.none);
  }

  Stream<RefParcelaireState> onLoadRefParcelaireIdForView(LoadRefParcelaireByIdForView event) async* {
    yield this.state.copyWith(refParcelaireStatusUI: RefParcelaireStatusUI.loading);
    try {
      RefParcelaire? loadedRefParcelaire = await _refParcelaireRepository.getRefParcelaire(event.id);
      yield this.state.copyWith(loadedRefParcelaire: loadedRefParcelaire, refParcelaireStatusUI: RefParcelaireStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedRefParcelaire: null, refParcelaireStatusUI: RefParcelaireStatusUI.error);
    }
  }


  Stream<RefParcelaireState> onNumeroParcelleChange(NumeroParcelleChanged event) async* {
    final numeroParcelle = NumeroParcelleInput.dirty(event.numeroParcelle);
    yield this.state.copyWith(
      numeroParcelle: numeroParcelle,
      formStatus: Formz.validate([
        numeroParcelle,
      this.state.natureParcelle,
      ]),
    );
  }
  Stream<RefParcelaireState> onNatureParcelleChange(NatureParcelleChanged event) async* {
    final natureParcelle = NatureParcelleInput.dirty(event.natureParcelle);
    yield this.state.copyWith(
      natureParcelle: natureParcelle,
      formStatus: Formz.validate([
      this.state.numeroParcelle,
        natureParcelle,
      ]),
    );
  }

  @override
  Future<void> close() {
    numeroParcelleController.dispose();
    natureParcelleController.dispose();
    return super.close();
  }

}
