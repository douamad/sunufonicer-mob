import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/dossier/dossier_model.dart';
import 'package:sunufoncier/entities/dossier/dossier_repository.dart';
import 'package:sunufoncier/entities/dossier/bloc/dossier_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'dossier_events.dart';
part 'dossier_state.dart';

class DossierBloc extends Bloc<DossierEvent, DossierState> {
  final DossierRepository _dossierRepository;

  final numeroController = TextEditingController();
  final montantLoyerController = TextEditingController();
  final superficieBatieController = TextEditingController();
  final coeffCorrectifBatieController = TextEditingController();
  final valeurBatieController = TextEditingController();
  final lineaireClotureController = TextEditingController();
  final coeffClotureController = TextEditingController();
  final valeurClotureController = TextEditingController();
  final amenagementSpaciauxController = TextEditingController();
  final valeurAmenagementController = TextEditingController();
  final valeurVenaleController = TextEditingController();
  final valeurLocativController = TextEditingController();

  DossierBloc({required DossierRepository dossierRepository}) :
        _dossierRepository = dossierRepository,
  super(DossierState());

  @override
  void onTransition(Transition<DossierEvent, DossierState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<DossierState> mapEventToState(DossierEvent event) async* {
    if (event is InitDossierList) {
      yield* onInitList(event);
    } else if (event is DossierFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadDossierByIdForEdit) {
      yield* onLoadDossierIdForEdit(event);
    } else if (event is DeleteDossierById) {
      yield* onDeleteDossierId(event);
    } else if (event is LoadDossierByIdForView) {
      yield* onLoadDossierIdForView(event);
    }else if (event is NumeroChanged){
      yield* onNumeroChange(event);
    }else if (event is MontantLoyerChanged){
      yield* onMontantLoyerChange(event);
    }else if (event is SuperficieBatieChanged){
      yield* onSuperficieBatieChange(event);
    }else if (event is CoeffCorrectifBatieChanged){
      yield* onCoeffCorrectifBatieChange(event);
    }else if (event is ValeurBatieChanged){
      yield* onValeurBatieChange(event);
    }else if (event is LineaireClotureChanged){
      yield* onLineaireClotureChange(event);
    }else if (event is CoeffClotureChanged){
      yield* onCoeffClotureChange(event);
    }else if (event is ValeurClotureChanged){
      yield* onValeurClotureChange(event);
    }else if (event is AmenagementSpaciauxChanged){
      yield* onAmenagementSpaciauxChange(event);
    }else if (event is ValeurAmenagementChanged){
      yield* onValeurAmenagementChange(event);
    }else if (event is ValeurVenaleChanged){
      yield* onValeurVenaleChange(event);
    }else if (event is ValeurLocativChanged){
      yield* onValeurLocativChange(event);
    }  }

  Stream<DossierState> onInitList(InitDossierList event) async* {
    yield this.state.copyWith(dossierStatusUI: DossierStatusUI.loading);
    List<Dossier>? dossiers = await _dossierRepository.getAllDossiers();
    yield this.state.copyWith(dossiers: dossiers, dossierStatusUI: DossierStatusUI.done);
  }

  Stream<DossierState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Dossier? result;
        if(this.state.editMode) {
          Dossier newDossier = Dossier(state.loadedDossier.id,
            this.state.numero.value,
            this.state.montantLoyer.value,
            this.state.superficieBatie.value,
            this.state.coeffCorrectifBatie.value,
            this.state.valeurBatie.value,
            this.state.lineaireCloture.value,
            this.state.coeffCloture.value,
            this.state.valeurCloture.value,
            this.state.amenagementSpaciaux.value,
            this.state.valeurAmenagement.value,
            this.state.valeurVenale.value,
            this.state.valeurLocativ.value,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
          );

          result = await _dossierRepository.update(newDossier);
        } else {
          Dossier newDossier = Dossier(null,
            this.state.numero.value,
            this.state.montantLoyer.value,
            this.state.superficieBatie.value,
            this.state.coeffCorrectifBatie.value,
            this.state.valeurBatie.value,
            this.state.lineaireCloture.value,
            this.state.coeffCloture.value,
            this.state.valeurCloture.value,
            this.state.amenagementSpaciaux.value,
            this.state.valeurAmenagement.value,
            this.state.valeurVenale.value,
            this.state.valeurLocativ.value,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
          );

          result = await _dossierRepository.create(newDossier);
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

  Stream<DossierState> onLoadDossierIdForEdit(LoadDossierByIdForEdit? event) async* {
    yield this.state.copyWith(dossierStatusUI: DossierStatusUI.loading);
    Dossier? loadedDossier = await _dossierRepository.getDossier(event?.id);

    final numero = NumeroInput.dirty((loadedDossier!.numero != null ? loadedDossier.numero: '')!);
    final montantLoyer = MontantLoyerInput.dirty((loadedDossier.montantLoyer != null ? loadedDossier.montantLoyer: 0.0)!);
    final superficieBatie = SuperficieBatieInput.dirty((loadedDossier.superficieBatie != null ? loadedDossier.superficieBatie: 0.0)!);
    final coeffCorrectifBatie = CoeffCorrectifBatieInput.dirty((loadedDossier.coeffCorrectifBatie != null ? loadedDossier.coeffCorrectifBatie: 0.0)!);
    final valeurBatie = ValeurBatieInput.dirty((loadedDossier.valeurBatie != null ? loadedDossier.valeurBatie: 0.0)!);
    final lineaireCloture = LineaireClotureInput.dirty((loadedDossier.lineaireCloture != null ? loadedDossier.lineaireCloture: 0.0)!);
    final coeffCloture = CoeffClotureInput.dirty((loadedDossier.coeffCloture != null ? loadedDossier.coeffCloture: 0.0)!);
    final valeurCloture = ValeurClotureInput.dirty((loadedDossier.valeurCloture != null ? loadedDossier.valeurCloture: 0.0)!);
    final amenagementSpaciaux = AmenagementSpaciauxInput.dirty((loadedDossier.amenagementSpaciaux != null ? loadedDossier.amenagementSpaciaux: '')!);
    final valeurAmenagement = ValeurAmenagementInput.dirty((loadedDossier.valeurAmenagement != null ? loadedDossier.valeurAmenagement: 0.0)!);
    final valeurVenale = ValeurVenaleInput.dirty((loadedDossier.valeurVenale != null ? loadedDossier.valeurVenale: 0.0)!);
    final valeurLocativ = ValeurLocativInput.dirty((loadedDossier.valeurLocativ != null ? loadedDossier.valeurLocativ: '')!);

    yield this.state.copyWith(loadedDossier: loadedDossier, editMode: true,
      numero: numero,
      montantLoyer: montantLoyer,
      superficieBatie: superficieBatie,
      coeffCorrectifBatie: coeffCorrectifBatie,
      valeurBatie: valeurBatie,
      lineaireCloture: lineaireCloture,
      coeffCloture: coeffCloture,
      valeurCloture: valeurCloture,
      amenagementSpaciaux: amenagementSpaciaux,
      valeurAmenagement: valeurAmenagement,
      valeurVenale: valeurVenale,
      valeurLocativ: valeurLocativ,
    dossierStatusUI: DossierStatusUI.done);

    numeroController.text = loadedDossier.numero!;
    montantLoyerController.text = loadedDossier.montantLoyer! as String;
    superficieBatieController.text = loadedDossier.superficieBatie! as String;
    coeffCorrectifBatieController.text = loadedDossier.coeffCorrectifBatie! as String;
    valeurBatieController.text = loadedDossier.valeurBatie! as String;
    lineaireClotureController.text = loadedDossier.lineaireCloture! as String;
    coeffClotureController.text = loadedDossier.coeffCloture! as String;
    valeurClotureController.text = loadedDossier.valeurCloture! as String;
    amenagementSpaciauxController.text = loadedDossier.amenagementSpaciaux!;
    valeurAmenagementController.text = loadedDossier.valeurAmenagement! as String;
    valeurVenaleController.text = loadedDossier.valeurVenale! as String;
    valeurLocativController.text = loadedDossier.valeurLocativ!;
  }

  Stream<DossierState> onDeleteDossierId(DeleteDossierById event) async* {
    try {
      await _dossierRepository.delete(event.id!);
      this.add(InitDossierList());
      yield this.state.copyWith(deleteStatus: DossierDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: DossierDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: DossierDeleteStatus.none);
  }

  Stream<DossierState> onLoadDossierIdForView(LoadDossierByIdForView event) async* {
    yield this.state.copyWith(dossierStatusUI: DossierStatusUI.loading);
    try {
      Dossier? loadedDossier = await _dossierRepository.getDossier(event.id);
      yield this.state.copyWith(loadedDossier: loadedDossier, dossierStatusUI: DossierStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedDossier: null, dossierStatusUI: DossierStatusUI.error);
    }
  }


  Stream<DossierState> onNumeroChange(NumeroChanged event) async* {
    final numero = NumeroInput.dirty(event.numero);
    yield this.state.copyWith(
      numero: numero,
      formStatus: Formz.validate([
        numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onMontantLoyerChange(MontantLoyerChanged event) async* {
    final montantLoyer = MontantLoyerInput.dirty(event.montantLoyer);
    yield this.state.copyWith(
      montantLoyer: montantLoyer,
      formStatus: Formz.validate([
      this.state.numero,
        montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onSuperficieBatieChange(SuperficieBatieChanged event) async* {
    final superficieBatie = SuperficieBatieInput.dirty(event.superficieBatie);
    yield this.state.copyWith(
      superficieBatie: superficieBatie,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
        superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onCoeffCorrectifBatieChange(CoeffCorrectifBatieChanged event) async* {
    final coeffCorrectifBatie = CoeffCorrectifBatieInput.dirty(event.coeffCorrectifBatie);
    yield this.state.copyWith(
      coeffCorrectifBatie: coeffCorrectifBatie,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
        coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onValeurBatieChange(ValeurBatieChanged event) async* {
    final valeurBatie = ValeurBatieInput.dirty(event.valeurBatie);
    yield this.state.copyWith(
      valeurBatie: valeurBatie,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
        valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onLineaireClotureChange(LineaireClotureChanged event) async* {
    final lineaireCloture = LineaireClotureInput.dirty(event.lineaireCloture);
    yield this.state.copyWith(
      lineaireCloture: lineaireCloture,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
        lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onCoeffClotureChange(CoeffClotureChanged event) async* {
    final coeffCloture = CoeffClotureInput.dirty(event.coeffCloture);
    yield this.state.copyWith(
      coeffCloture: coeffCloture,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
        coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onValeurClotureChange(ValeurClotureChanged event) async* {
    final valeurCloture = ValeurClotureInput.dirty(event.valeurCloture);
    yield this.state.copyWith(
      valeurCloture: valeurCloture,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
        valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onAmenagementSpaciauxChange(AmenagementSpaciauxChanged event) async* {
    final amenagementSpaciaux = AmenagementSpaciauxInput.dirty(event.amenagementSpaciaux);
    yield this.state.copyWith(
      amenagementSpaciaux: amenagementSpaciaux,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
        amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onValeurAmenagementChange(ValeurAmenagementChanged event) async* {
    final valeurAmenagement = ValeurAmenagementInput.dirty(event.valeurAmenagement);
    yield this.state.copyWith(
      valeurAmenagement: valeurAmenagement,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
        valeurAmenagement,
      this.state.valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onValeurVenaleChange(ValeurVenaleChanged event) async* {
    final valeurVenale = ValeurVenaleInput.dirty(event.valeurVenale);
    yield this.state.copyWith(
      valeurVenale: valeurVenale,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
        valeurVenale,
      this.state.valeurLocativ,
      ]),
    );
  }
  Stream<DossierState> onValeurLocativChange(ValeurLocativChanged event) async* {
    final valeurLocativ = ValeurLocativInput.dirty(event.valeurLocativ);
    yield this.state.copyWith(
      valeurLocativ: valeurLocativ,
      formStatus: Formz.validate([
      this.state.numero,
      this.state.montantLoyer,
      this.state.superficieBatie,
      this.state.coeffCorrectifBatie,
      this.state.valeurBatie,
      this.state.lineaireCloture,
      this.state.coeffCloture,
      this.state.valeurCloture,
      this.state.amenagementSpaciaux,
      this.state.valeurAmenagement,
      this.state.valeurVenale,
        valeurLocativ,
      ]),
    );
  }

  @override
  Future<void> close() {
    numeroController.dispose();
    montantLoyerController.dispose();
    superficieBatieController.dispose();
    coeffCorrectifBatieController.dispose();
    valeurBatieController.dispose();
    lineaireClotureController.dispose();
    coeffClotureController.dispose();
    valeurClotureController.dispose();
    amenagementSpaciauxController.dispose();
    valeurAmenagementController.dispose();
    valeurVenaleController.dispose();
    valeurLocativController.dispose();
    return super.close();
  }

}
