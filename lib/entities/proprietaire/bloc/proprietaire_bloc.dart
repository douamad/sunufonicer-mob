import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/proprietaire/proprietaire_model.dart';
import 'package:sunufoncier/entities/proprietaire/proprietaire_repository.dart';
import 'package:sunufoncier/entities/proprietaire/bloc/proprietaire_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'proprietaire_events.dart';
part 'proprietaire_state.dart';

class ProprietaireBloc extends Bloc<ProprietaireEvent, ProprietaireState> {
  final ProprietaireRepository _proprietaireRepository;

  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final raisonSocialController = TextEditingController();
  final dateNaissController = TextEditingController();
  final lieuNaissanceController = TextEditingController();
  final numCNIController = TextEditingController();
  final nineaController = TextEditingController();
  final adresseController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();
  final telephone2Controller = TextEditingController();
  final telephone3Controller = TextEditingController();
  final aquisitionController = TextEditingController();
  final statutPersoneStructureController = TextEditingController();

  ProprietaireBloc({required ProprietaireRepository proprietaireRepository}) :
        _proprietaireRepository = proprietaireRepository,
  super(ProprietaireState());

  @override
  void onTransition(Transition<ProprietaireEvent, ProprietaireState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ProprietaireState> mapEventToState(ProprietaireEvent event) async* {
    if (event is InitProprietaireList) {
      yield* onInitList(event);
    } else if (event is ProprietaireFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadProprietaireByIdForEdit) {
      yield* onLoadProprietaireIdForEdit(event);
    } else if (event is DeleteProprietaireById) {
      yield* onDeleteProprietaireId(event);
    } else if (event is LoadProprietaireByIdForView) {
      yield* onLoadProprietaireIdForView(event);
    }else if (event is PrenomChanged){
      yield* onPrenomChange(event);
    }else if (event is NomChanged){
      yield* onNomChange(event);
    }else if (event is SituationChanged){
      yield* onSituationChange(event);
    }else if (event is RaisonSocialChanged){
      yield* onRaisonSocialChange(event);
    }else if (event is PersonneMoraleChanged){
      yield* onPersonneMoraleChange(event);
    }else if (event is DateNaissChanged){
      yield* onDateNaissChange(event);
    }else if (event is LieuNaissanceChanged){
      yield* onLieuNaissanceChange(event);
    }else if (event is NumCNIChanged){
      yield* onNumCNIChange(event);
    }else if (event is NineaChanged){
      yield* onNineaChange(event);
    }else if (event is AdresseChanged){
      yield* onAdresseChange(event);
    }else if (event is EmailChanged){
      yield* onEmailChange(event);
    }else if (event is TelephoneChanged){
      yield* onTelephoneChange(event);
    }else if (event is Telephone2Changed){
      yield* onTelephone2Change(event);
    }else if (event is Telephone3Changed){
      yield* onTelephone3Change(event);
    }else if (event is AquisitionChanged){
      yield* onAquisitionChange(event);
    }else if (event is StatutPersoneStructureChanged){
      yield* onStatutPersoneStructureChange(event);
    }else if (event is TypeStructureChanged){
      yield* onTypeStructureChange(event);
    }  }

  Stream<ProprietaireState> onInitList(InitProprietaireList event) async* {
    yield this.state.copyWith(proprietaireStatusUI: ProprietaireStatusUI.loading);
    List<Proprietaire>? proprietaires = await _proprietaireRepository.getAllProprietaires();
    yield this.state.copyWith(proprietaires: proprietaires, proprietaireStatusUI: ProprietaireStatusUI.done);
  }

  Stream<ProprietaireState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Proprietaire? result;
        if(this.state.editMode) {
          Proprietaire newProprietaire = Proprietaire(state.loadedProprietaire.id,
            this.state.prenom.value,
            this.state.nom.value,
            this.state.situation.value,
            this.state.raisonSocial.value,
            this.state.personneMorale.value,
            this.state.dateNaiss.value,
            this.state.lieuNaissance.value,
            this.state.numCNI.value,
            this.state.ninea.value,
            this.state.adresse.value,
            this.state.email.value,
            this.state.telephone.value,
            this.state.telephone2.value,
            this.state.telephone3.value,
            this.state.aquisition.value,
            this.state.statutPersoneStructure.value,
            this.state.typeStructure.value,
          );

          result = await _proprietaireRepository.update(newProprietaire);
        } else {
          Proprietaire newProprietaire = Proprietaire(null,
            this.state.prenom.value,
            this.state.nom.value,
            this.state.situation.value,
            this.state.raisonSocial.value,
            this.state.personneMorale.value,
            this.state.dateNaiss.value,
            this.state.lieuNaissance.value,
            this.state.numCNI.value,
            this.state.ninea.value,
            this.state.adresse.value,
            this.state.email.value,
            this.state.telephone.value,
            this.state.telephone2.value,
            this.state.telephone3.value,
            this.state.aquisition.value,
            this.state.statutPersoneStructure.value,
            this.state.typeStructure.value,
          );

          result = await _proprietaireRepository.create(newProprietaire);
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

  Stream<ProprietaireState> onLoadProprietaireIdForEdit(LoadProprietaireByIdForEdit? event) async* {
    yield this.state.copyWith(proprietaireStatusUI: ProprietaireStatusUI.loading);
    Proprietaire? loadedProprietaire = await _proprietaireRepository.getProprietaire(event?.id);

    final prenom = PrenomInput.dirty((loadedProprietaire!.prenom != null ? loadedProprietaire.prenom: '')!);
    final nom = NomInput.dirty((loadedProprietaire.nom != null ? loadedProprietaire.nom: '')!);
    final situation = SituationInput.dirty((loadedProprietaire.situation != null ? loadedProprietaire.situation: null)!);
    final raisonSocial = RaisonSocialInput.dirty((loadedProprietaire.raisonSocial != null ? loadedProprietaire.raisonSocial: '')!);
    final personneMorale = PersonneMoraleInput.dirty((loadedProprietaire.personneMorale != null ? loadedProprietaire.personneMorale: false)!);
    final dateNaiss = DateNaissInput.dirty((loadedProprietaire.dateNaiss != null ? loadedProprietaire.dateNaiss: null)!);
    final lieuNaissance = LieuNaissanceInput.dirty((loadedProprietaire.lieuNaissance != null ? loadedProprietaire.lieuNaissance: '')!);
    final numCNI = NumCNIInput.dirty((loadedProprietaire.numCNI != null ? loadedProprietaire.numCNI: '')!);
    final ninea = NineaInput.dirty((loadedProprietaire.ninea != null ? loadedProprietaire.ninea: '')!);
    final adresse = AdresseInput.dirty((loadedProprietaire.adresse != null ? loadedProprietaire.adresse: '')!);
    final email = EmailInput.dirty((loadedProprietaire.email != null ? loadedProprietaire.email: '')!);
    final telephone = TelephoneInput.dirty((loadedProprietaire.telephone != null ? loadedProprietaire.telephone: '')!);
    final telephone2 = Telephone2Input.dirty((loadedProprietaire.telephone2 != null ? loadedProprietaire.telephone2: '')!);
    final telephone3 = Telephone3Input.dirty((loadedProprietaire.telephone3 != null ? loadedProprietaire.telephone3: '')!);
    final aquisition = AquisitionInput.dirty((loadedProprietaire.aquisition != null ? loadedProprietaire.aquisition: '')!);
    final statutPersoneStructure = StatutPersoneStructureInput.dirty((loadedProprietaire.statutPersoneStructure != null ? loadedProprietaire.statutPersoneStructure: '')!);
    final typeStructure = TypeStructureInput.dirty((loadedProprietaire.typeStructure != null ? loadedProprietaire.typeStructure: null)!);

    yield this.state.copyWith(loadedProprietaire: loadedProprietaire, editMode: true,
      prenom: prenom,
      nom: nom,
      situation: situation,
      raisonSocial: raisonSocial,
      personneMorale: personneMorale,
      dateNaiss: dateNaiss,
      lieuNaissance: lieuNaissance,
      numCNI: numCNI,
      ninea: ninea,
      adresse: adresse,
      email: email,
      telephone: telephone,
      telephone2: telephone2,
      telephone3: telephone3,
      aquisition: aquisition,
      statutPersoneStructure: statutPersoneStructure,
      typeStructure: typeStructure,
    proprietaireStatusUI: ProprietaireStatusUI.done);

    prenomController.text = loadedProprietaire.prenom!;
    nomController.text = loadedProprietaire.nom!;
    raisonSocialController.text = loadedProprietaire.raisonSocial!;
    dateNaissController.text = DateFormat.yMMMMd('en').format(loadedProprietaire.dateNaiss!);
    lieuNaissanceController.text = loadedProprietaire.lieuNaissance!;
    numCNIController.text = loadedProprietaire.numCNI!;
    nineaController.text = loadedProprietaire.ninea!;
    adresseController.text = loadedProprietaire.adresse!;
    emailController.text = loadedProprietaire.email!;
    telephoneController.text = loadedProprietaire.telephone!;
    telephone2Controller.text = loadedProprietaire.telephone2!;
    telephone3Controller.text = loadedProprietaire.telephone3!;
    aquisitionController.text = loadedProprietaire.aquisition!;
    statutPersoneStructureController.text = loadedProprietaire.statutPersoneStructure!;
  }

  Stream<ProprietaireState> onDeleteProprietaireId(DeleteProprietaireById event) async* {
    try {
      await _proprietaireRepository.delete(event.id!);
      this.add(InitProprietaireList());
      yield this.state.copyWith(deleteStatus: ProprietaireDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ProprietaireDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ProprietaireDeleteStatus.none);
  }

  Stream<ProprietaireState> onLoadProprietaireIdForView(LoadProprietaireByIdForView event) async* {
    yield this.state.copyWith(proprietaireStatusUI: ProprietaireStatusUI.loading);
    try {
      Proprietaire? loadedProprietaire = await _proprietaireRepository.getProprietaire(event.id);
      yield this.state.copyWith(loadedProprietaire: loadedProprietaire, proprietaireStatusUI: ProprietaireStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedProprietaire: null, proprietaireStatusUI: ProprietaireStatusUI.error);
    }
  }


  Stream<ProprietaireState> onPrenomChange(PrenomChanged event) async* {
    final prenom = PrenomInput.dirty(event.prenom);
    yield this.state.copyWith(
      prenom: prenom,
      formStatus: Formz.validate([
        prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onNomChange(NomChanged event) async* {
    final nom = NomInput.dirty(event.nom);
    yield this.state.copyWith(
      nom: nom,
      formStatus: Formz.validate([
      this.state.prenom,
        nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onSituationChange(SituationChanged event) async* {
    final situation = SituationInput.dirty(event.situation);
    yield this.state.copyWith(
      situation: situation,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
        situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onRaisonSocialChange(RaisonSocialChanged event) async* {
    final raisonSocial = RaisonSocialInput.dirty(event.raisonSocial);
    yield this.state.copyWith(
      raisonSocial: raisonSocial,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
        raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onPersonneMoraleChange(PersonneMoraleChanged event) async* {
    final personneMorale = PersonneMoraleInput.dirty(event.personneMorale);
    yield this.state.copyWith(
      personneMorale: personneMorale,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
        personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onDateNaissChange(DateNaissChanged event) async* {
    final dateNaiss = DateNaissInput.dirty(event.dateNaiss);
    yield this.state.copyWith(
      dateNaiss: dateNaiss,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
        dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onLieuNaissanceChange(LieuNaissanceChanged event) async* {
    final lieuNaissance = LieuNaissanceInput.dirty(event.lieuNaissance);
    yield this.state.copyWith(
      lieuNaissance: lieuNaissance,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
        lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onNumCNIChange(NumCNIChanged event) async* {
    final numCNI = NumCNIInput.dirty(event.numCNI);
    yield this.state.copyWith(
      numCNI: numCNI,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
        numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onNineaChange(NineaChanged event) async* {
    final ninea = NineaInput.dirty(event.ninea);
    yield this.state.copyWith(
      ninea: ninea,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
        ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onAdresseChange(AdresseChanged event) async* {
    final adresse = AdresseInput.dirty(event.adresse);
    yield this.state.copyWith(
      adresse: adresse,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
        adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onEmailChange(EmailChanged event) async* {
    final email = EmailInput.dirty(event.email);
    yield this.state.copyWith(
      email: email,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
        email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onTelephoneChange(TelephoneChanged event) async* {
    final telephone = TelephoneInput.dirty(event.telephone);
    yield this.state.copyWith(
      telephone: telephone,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
        telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onTelephone2Change(Telephone2Changed event) async* {
    final telephone2 = Telephone2Input.dirty(event.telephone2);
    yield this.state.copyWith(
      telephone2: telephone2,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
        telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onTelephone3Change(Telephone3Changed event) async* {
    final telephone3 = Telephone3Input.dirty(event.telephone3);
    yield this.state.copyWith(
      telephone3: telephone3,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
        telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onAquisitionChange(AquisitionChanged event) async* {
    final aquisition = AquisitionInput.dirty(event.aquisition);
    yield this.state.copyWith(
      aquisition: aquisition,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
        aquisition,
      this.state.statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onStatutPersoneStructureChange(StatutPersoneStructureChanged event) async* {
    final statutPersoneStructure = StatutPersoneStructureInput.dirty(event.statutPersoneStructure);
    yield this.state.copyWith(
      statutPersoneStructure: statutPersoneStructure,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
        statutPersoneStructure,
      this.state.typeStructure,
      ]),
    );
  }
  Stream<ProprietaireState> onTypeStructureChange(TypeStructureChanged event) async* {
    final typeStructure = TypeStructureInput.dirty(event.typeStructure);
    yield this.state.copyWith(
      typeStructure: typeStructure,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.situation,
      this.state.raisonSocial,
      this.state.personneMorale,
      this.state.dateNaiss,
      this.state.lieuNaissance,
      this.state.numCNI,
      this.state.ninea,
      this.state.adresse,
      this.state.email,
      this.state.telephone,
      this.state.telephone2,
      this.state.telephone3,
      this.state.aquisition,
      this.state.statutPersoneStructure,
        typeStructure,
      ]),
    );
  }

  @override
  Future<void> close() {
    prenomController.dispose();
    nomController.dispose();
    raisonSocialController.dispose();
    dateNaissController.dispose();
    lieuNaissanceController.dispose();
    numCNIController.dispose();
    nineaController.dispose();
    adresseController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    telephone2Controller.dispose();
    telephone3Controller.dispose();
    aquisitionController.dispose();
    statutPersoneStructureController.dispose();
    return super.close();
  }

}
