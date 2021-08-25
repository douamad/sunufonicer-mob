import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_model.dart';
import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_repository.dart';
import 'package:sunufoncier/entities/categorie_cloture/bloc/categorie_cloture_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'categorie_cloture_events.dart';
part 'categorie_cloture_state.dart';

class CategorieClotureBloc extends Bloc<CategorieClotureEvent, CategorieClotureState> {
  final CategorieClotureRepository _categorieClotureRepository;

  final libelleController = TextEditingController();
  final prixMetreCareController = TextEditingController();

  CategorieClotureBloc({required CategorieClotureRepository categorieClotureRepository}) :
        _categorieClotureRepository = categorieClotureRepository,
  super(CategorieClotureState());

  @override
  void onTransition(Transition<CategorieClotureEvent, CategorieClotureState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<CategorieClotureState> mapEventToState(CategorieClotureEvent event) async* {
    if (event is InitCategorieClotureList) {
      yield* onInitList(event);
    } else if (event is CategorieClotureFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadCategorieClotureByIdForEdit) {
      yield* onLoadCategorieClotureIdForEdit(event);
    } else if (event is DeleteCategorieClotureById) {
      yield* onDeleteCategorieClotureId(event);
    } else if (event is LoadCategorieClotureByIdForView) {
      yield* onLoadCategorieClotureIdForView(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }else if (event is PrixMetreCareChanged){
      yield* onPrixMetreCareChange(event);
    }  }

  Stream<CategorieClotureState> onInitList(InitCategorieClotureList event) async* {
    yield this.state.copyWith(categorieClotureStatusUI: CategorieClotureStatusUI.loading);
    List<CategorieCloture>? categorieClotures = await _categorieClotureRepository.getAllCategorieClotures();
    yield this.state.copyWith(categorieClotures: categorieClotures, categorieClotureStatusUI: CategorieClotureStatusUI.done);
  }

  Stream<CategorieClotureState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        CategorieCloture? result;
        if(this.state.editMode) {
          CategorieCloture newCategorieCloture = CategorieCloture(state.loadedCategorieCloture.id,
            this.state.libelle.value,
            this.state.prixMetreCare.value,
            null,
          );

          result = await _categorieClotureRepository.update(newCategorieCloture);
        } else {
          CategorieCloture newCategorieCloture = CategorieCloture(null,
            this.state.libelle.value,
            this.state.prixMetreCare.value,
            null,
          );

          result = await _categorieClotureRepository.create(newCategorieCloture);
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

  Stream<CategorieClotureState> onLoadCategorieClotureIdForEdit(LoadCategorieClotureByIdForEdit? event) async* {
    yield this.state.copyWith(categorieClotureStatusUI: CategorieClotureStatusUI.loading);
    CategorieCloture? loadedCategorieCloture = await _categorieClotureRepository.getCategorieCloture(event?.id);

    final libelle = LibelleInput.dirty((loadedCategorieCloture!.libelle != null ? loadedCategorieCloture.libelle: '')!);
    final prixMetreCare = PrixMetreCareInput.dirty((loadedCategorieCloture.prixMetreCare != null ? loadedCategorieCloture.prixMetreCare: 0.0)!);

    yield this.state.copyWith(loadedCategorieCloture: loadedCategorieCloture, editMode: true,
      libelle: libelle,
      prixMetreCare: prixMetreCare,
    categorieClotureStatusUI: CategorieClotureStatusUI.done);

    libelleController.text = loadedCategorieCloture.libelle!;
    prixMetreCareController.text = loadedCategorieCloture.prixMetreCare! as String;
  }

  Stream<CategorieClotureState> onDeleteCategorieClotureId(DeleteCategorieClotureById event) async* {
    try {
      await _categorieClotureRepository.delete(event.id!);
      this.add(InitCategorieClotureList());
      yield this.state.copyWith(deleteStatus: CategorieClotureDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: CategorieClotureDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: CategorieClotureDeleteStatus.none);
  }

  Stream<CategorieClotureState> onLoadCategorieClotureIdForView(LoadCategorieClotureByIdForView event) async* {
    yield this.state.copyWith(categorieClotureStatusUI: CategorieClotureStatusUI.loading);
    try {
      CategorieCloture? loadedCategorieCloture = await _categorieClotureRepository.getCategorieCloture(event.id);
      yield this.state.copyWith(loadedCategorieCloture: loadedCategorieCloture, categorieClotureStatusUI: CategorieClotureStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedCategorieCloture: null, categorieClotureStatusUI: CategorieClotureStatusUI.error);
    }
  }


  Stream<CategorieClotureState> onLibelleChange(LibelleChanged event) async* {
    final libelle = LibelleInput.dirty(event.libelle);
    yield this.state.copyWith(
      libelle: libelle,
      formStatus: Formz.validate([
        libelle,
      this.state.prixMetreCare,
      ]),
    );
  }
  Stream<CategorieClotureState> onPrixMetreCareChange(PrixMetreCareChanged event) async* {
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
