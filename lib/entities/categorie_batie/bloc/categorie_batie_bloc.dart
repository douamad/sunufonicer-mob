import 'dart:async';
import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/categorie_batie/categorie_batie_model.dart';
import 'package:sunufoncier/entities/categorie_batie/categorie_batie_repository.dart';
import 'package:sunufoncier/entities/categorie_batie/bloc/categorie_batie_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'categorie_batie_events.dart';
part 'categorie_batie_state.dart';

class CategorieBatieBloc extends Bloc<CategorieBatieEvent, CategorieBatieState> {
  final CategorieBatieRepository _categorieBatieRepository;

  final libelleController = TextEditingController();
  final prixMetreCareController = TextEditingController();

  CategorieBatieBloc({required CategorieBatieRepository categorieBatieRepository}) :
        _categorieBatieRepository = categorieBatieRepository,
  super(CategorieBatieState());

  @override
  void onTransition(Transition<CategorieBatieEvent, CategorieBatieState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<CategorieBatieState> mapEventToState(CategorieBatieEvent event) async* {
    if (event is InitCategorieBatieList) {
      yield* onInitList(event);
    } else if (event is CategorieBatieFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadCategorieBatieByIdForEdit) {
      yield* onLoadCategorieBatieIdForEdit(event);
    } else if (event is DeleteCategorieBatieById) {
      yield* onDeleteCategorieBatieId(event);
    } else if (event is LoadCategorieBatieByIdForView) {
      yield* onLoadCategorieBatieIdForView(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }else if (event is PrixMetreCareChanged){
      yield* onPrixMetreCareChange(event);
    }  }

  Stream<CategorieBatieState> onInitList(InitCategorieBatieList event) async* {
    yield this.state.copyWith(categorieBatieStatusUI: CategorieBatieStatusUI.loading);
    List<CategorieBatie>? categorieBaties = await _categorieBatieRepository.getAllCategorieBaties();
    yield this.state.copyWith(categorieBaties: categorieBaties, categorieBatieStatusUI: CategorieBatieStatusUI.done);
  }

  Stream<CategorieBatieState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        CategorieBatie? result;
        if(this.state.editMode) {
          CategorieBatie newCategorieBatie = CategorieBatie(state.loadedCategorieBatie.id,
            this.state.libelle.value,
            this.state.prixMetreCare.value,
            null,
          );

          result = await _categorieBatieRepository.update(newCategorieBatie);
        } else {
          CategorieBatie newCategorieBatie = CategorieBatie(null,
            this.state.libelle.value,
            this.state.prixMetreCare.value,
            null,
          );

          result = await _categorieBatieRepository.create(newCategorieBatie);
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

  Stream<CategorieBatieState> onLoadCategorieBatieIdForEdit(LoadCategorieBatieByIdForEdit? event) async* {
    yield this.state.copyWith(categorieBatieStatusUI: CategorieBatieStatusUI.loading);
    CategorieBatie? loadedCategorieBatie = await _categorieBatieRepository.getCategorieBatie(event?.id);

    final libelle = LibelleInput.dirty((loadedCategorieBatie!.libelle != null ? loadedCategorieBatie.libelle: '')!);
    final prixMetreCare = PrixMetreCareInput.dirty((loadedCategorieBatie.prixMetreCare != null ? loadedCategorieBatie!.prixMetreCare: null));

    yield this.state.copyWith(loadedCategorieBatie: loadedCategorieBatie, editMode: true,
      libelle: libelle,
      prixMetreCare: prixMetreCare,
    categorieBatieStatusUI: CategorieBatieStatusUI.done);

    libelleController.text = loadedCategorieBatie.libelle!;
    prixMetreCareController.text = loadedCategorieBatie.prixMetreCare! as String;
  }

  Stream<CategorieBatieState> onDeleteCategorieBatieId(DeleteCategorieBatieById event) async* {
    try {
      await _categorieBatieRepository.delete(event.id!);
      this.add(InitCategorieBatieList());
      yield this.state.copyWith(deleteStatus: CategorieBatieDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: CategorieBatieDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: CategorieBatieDeleteStatus.none);
  }

  Stream<CategorieBatieState> onLoadCategorieBatieIdForView(LoadCategorieBatieByIdForView event) async* {
    yield this.state.copyWith(categorieBatieStatusUI: CategorieBatieStatusUI.loading);
    try {
      CategorieBatie? loadedCategorieBatie = await _categorieBatieRepository.getCategorieBatie(event.id);
      yield this.state.copyWith(loadedCategorieBatie: loadedCategorieBatie, categorieBatieStatusUI: CategorieBatieStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedCategorieBatie: null, categorieBatieStatusUI: CategorieBatieStatusUI.error);
    }
  }


  Stream<CategorieBatieState> onLibelleChange(LibelleChanged event) async* {
    final libelle = LibelleInput.dirty(event.libelle);
    yield this.state.copyWith(
      libelle: libelle,
      formStatus: Formz.validate([
        libelle,
      this.state.prixMetreCare,
      ]),
    );
  }
  Stream<CategorieBatieState> onPrixMetreCareChange(PrixMetreCareChanged event) async* {
    final prixMetreCare = PrixMetreCareInput.dirty(event.prixMetreCare);
    yield this.state.copyWith(
      prixMetreCare: prixMetreCare,
      formStatus: Formz.validate([
      this.state.libelle,
        prixMetreCare,
      ]),
    );
  }

  @override
  Future<void> close() {
    libelleController.dispose();
    prixMetreCareController.dispose();
    return super.close();
  }

}
