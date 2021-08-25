import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/representant/representant_model.dart';
import 'package:sunufoncier/entities/representant/representant_repository.dart';
import 'package:sunufoncier/entities/representant/bloc/representant_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'representant_events.dart';
part 'representant_state.dart';

class RepresentantBloc extends Bloc<RepresentantEvent, RepresentantState> {
  final RepresentantRepository _representantRepository;

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

  RepresentantBloc({required RepresentantRepository representantRepository}) :
        _representantRepository = representantRepository,
  super(RepresentantState());

  @override
  void onTransition(Transition<RepresentantEvent, RepresentantState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<RepresentantState> mapEventToState(RepresentantEvent event) async* {
    if (event is InitRepresentantList) {
      yield* onInitList(event);
    } else if (event is RepresentantFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadRepresentantByIdForEdit) {
      yield* onLoadRepresentantIdForEdit(event);
    } else if (event is DeleteRepresentantById) {
      yield* onDeleteRepresentantId(event);
    } else if (event is LoadRepresentantByIdForView) {
      yield* onLoadRepresentantIdForView(event);
    }else if (event is PrenomChanged){
      yield* onPrenomChange(event);
    }else if (event is NomChanged){
      yield* onNomChange(event);
    }else if (event is ActifChanged){
      yield* onActifChange(event);
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

  Stream<RepresentantState> onInitList(InitRepresentantList event) async* {
    yield this.state.copyWith(representantStatusUI: RepresentantStatusUI.loading);
    List<Representant>? representants = await _representantRepository.getAllRepresentants();
    yield this.state.copyWith(representants: representants, representantStatusUI: RepresentantStatusUI.done);
  }

  Stream<RepresentantState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Representant? result;
        if(this.state.editMode) {
          Representant newRepresentant = Representant(state.loadedRepresentant.id,
            this.state.prenom.value,
            this.state.nom.value,
            this.state.actif.value,
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
            null,
          );

          result = await _representantRepository.update(newRepresentant);
        } else {
          Representant newRepresentant = Representant(null,
            this.state.prenom.value,
            this.state.nom.value,
            this.state.actif.value,
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
            null,
          );

          result = await _representantRepository.create(newRepresentant);
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

  Stream<RepresentantState> onLoadRepresentantIdForEdit(LoadRepresentantByIdForEdit? event) async* {
    yield this.state.copyWith(representantStatusUI: RepresentantStatusUI.loading);
    Representant? loadedRepresentant = await _representantRepository.getRepresentant(event?.id);

    final prenom = PrenomInput.dirty((loadedRepresentant!.prenom != null ? loadedRepresentant.prenom: '')!);
    final nom = NomInput.dirty((loadedRepresentant.nom != null ? loadedRepresentant.nom: '')!);
    final actif = ActifInput.dirty((loadedRepresentant.actif != null ? loadedRepresentant.actif: false)!);
    final raisonSocial = RaisonSocialInput.dirty((loadedRepresentant.raisonSocial != null ? loadedRepresentant.raisonSocial: '')!);
    final personneMorale = PersonneMoraleInput.dirty((loadedRepresentant.personneMorale != null ? loadedRepresentant.personneMorale: false)!);
    final dateNaiss = DateNaissInput.dirty((loadedRepresentant.dateNaiss != null ? loadedRepresentant.dateNaiss: null)!);
    final lieuNaissance = LieuNaissanceInput.dirty((loadedRepresentant.lieuNaissance != null ? loadedRepresentant.lieuNaissance: '')!);
    final numCNI = NumCNIInput.dirty((loadedRepresentant.numCNI != null ? loadedRepresentant.numCNI: '')!);
    final ninea = NineaInput.dirty((loadedRepresentant.ninea != null ? loadedRepresentant.ninea: '')!);
    final adresse = AdresseInput.dirty((loadedRepresentant.adresse != null ? loadedRepresentant.adresse: '')!);
    final email = EmailInput.dirty((loadedRepresentant.email != null ? loadedRepresentant.email: '')!);
    final telephone = TelephoneInput.dirty((loadedRepresentant.telephone != null ? loadedRepresentant.telephone: '')!);
    final telephone2 = Telephone2Input.dirty((loadedRepresentant.telephone2 != null ? loadedRepresentant.telephone2: '')!);
    final telephone3 = Telephone3Input.dirty((loadedRepresentant.telephone3 != null ? loadedRepresentant.telephone3: '')!);
    final aquisition = AquisitionInput.dirty((loadedRepresentant.aquisition != null ? loadedRepresentant.aquisition: '')!);
    final statutPersoneStructure = StatutPersoneStructureInput.dirty((loadedRepresentant.statutPersoneStructure != null ? loadedRepresentant.statutPersoneStructure: '')!);
    final typeStructure = TypeStructureInput.dirty((loadedRepresentant.typeStructure != null ? loadedRepresentant.typeStructure: null)!);

    yield this.state.copyWith(loadedRepresentant: loadedRepresentant, editMode: true,
      prenom: prenom,
      nom: nom,
      actif: actif,
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
    representantStatusUI: RepresentantStatusUI.done);

    prenomController.text = loadedRepresentant.prenom!;
    nomController.text = loadedRepresentant.nom!;
    raisonSocialController.text = loadedRepresentant.raisonSocial!;
    dateNaissController.text = DateFormat.yMMMMd('en').format(loadedRepresentant.dateNaiss!);
    lieuNaissanceController.text = loadedRepresentant.lieuNaissance!;
    numCNIController.text = loadedRepresentant.numCNI!;
    nineaController.text = loadedRepresentant.ninea!;
    adresseController.text = loadedRepresentant.adresse!;
    emailController.text = loadedRepresentant.email!;
    telephoneController.text = loadedRepresentant.telephone!;
    telephone2Controller.text = loadedRepresentant.telephone2!;
    telephone3Controller.text = loadedRepresentant.telephone3!;
    aquisitionController.text = loadedRepresentant.aquisition!;
    statutPersoneStructureController.text = loadedRepresentant.statutPersoneStructure!;
  }

  Stream<RepresentantState> onDeleteRepresentantId(DeleteRepresentantById event) async* {
    try {
      await _representantRepository.delete(event.id!);
      this.add(InitRepresentantList());
      yield this.state.copyWith(deleteStatus: RepresentantDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: RepresentantDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: RepresentantDeleteStatus.none);
  }

  Stream<RepresentantState> onLoadRepresentantIdForView(LoadRepresentantByIdForView event) async* {
    yield this.state.copyWith(representantStatusUI: RepresentantStatusUI.loading);
    try {
      Representant? loadedRepresentant = await _representantRepository.getRepresentant(event.id);
      yield this.state.copyWith(loadedRepresentant: loadedRepresentant, representantStatusUI: RepresentantStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedRepresentant: null, representantStatusUI: RepresentantStatusUI.error);
    }
  }


  Stream<RepresentantState> onPrenomChange(PrenomChanged event) async* {
    final prenom = PrenomInput.dirty(event.prenom);
    yield this.state.copyWith(
      prenom: prenom,
      formStatus: Formz.validate([
        prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onNomChange(NomChanged event) async* {
    final nom = NomInput.dirty(event.nom);
    yield this.state.copyWith(
      nom: nom,
      formStatus: Formz.validate([
      this.state.prenom,
        nom,
      this.state.actif,
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
  Stream<RepresentantState> onActifChange(ActifChanged event) async* {
    final actif = ActifInput.dirty(event.actif);
    yield this.state.copyWith(
      actif: actif,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
        actif,
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
  Stream<RepresentantState> onRaisonSocialChange(RaisonSocialChanged event) async* {
    final raisonSocial = RaisonSocialInput.dirty(event.raisonSocial);
    yield this.state.copyWith(
      raisonSocial: raisonSocial,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onPersonneMoraleChange(PersonneMoraleChanged event) async* {
    final personneMorale = PersonneMoraleInput.dirty(event.personneMorale);
    yield this.state.copyWith(
      personneMorale: personneMorale,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onDateNaissChange(DateNaissChanged event) async* {
    final dateNaiss = DateNaissInput.dirty(event.dateNaiss);
    yield this.state.copyWith(
      dateNaiss: dateNaiss,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onLieuNaissanceChange(LieuNaissanceChanged event) async* {
    final lieuNaissance = LieuNaissanceInput.dirty(event.lieuNaissance);
    yield this.state.copyWith(
      lieuNaissance: lieuNaissance,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onNumCNIChange(NumCNIChanged event) async* {
    final numCNI = NumCNIInput.dirty(event.numCNI);
    yield this.state.copyWith(
      numCNI: numCNI,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onNineaChange(NineaChanged event) async* {
    final ninea = NineaInput.dirty(event.ninea);
    yield this.state.copyWith(
      ninea: ninea,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onAdresseChange(AdresseChanged event) async* {
    final adresse = AdresseInput.dirty(event.adresse);
    yield this.state.copyWith(
      adresse: adresse,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onEmailChange(EmailChanged event) async* {
    final email = EmailInput.dirty(event.email);
    yield this.state.copyWith(
      email: email,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onTelephoneChange(TelephoneChanged event) async* {
    final telephone = TelephoneInput.dirty(event.telephone);
    yield this.state.copyWith(
      telephone: telephone,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onTelephone2Change(Telephone2Changed event) async* {
    final telephone2 = Telephone2Input.dirty(event.telephone2);
    yield this.state.copyWith(
      telephone2: telephone2,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onTelephone3Change(Telephone3Changed event) async* {
    final telephone3 = Telephone3Input.dirty(event.telephone3);
    yield this.state.copyWith(
      telephone3: telephone3,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onAquisitionChange(AquisitionChanged event) async* {
    final aquisition = AquisitionInput.dirty(event.aquisition);
    yield this.state.copyWith(
      aquisition: aquisition,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onStatutPersoneStructureChange(StatutPersoneStructureChanged event) async* {
    final statutPersoneStructure = StatutPersoneStructureInput.dirty(event.statutPersoneStructure);
    yield this.state.copyWith(
      statutPersoneStructure: statutPersoneStructure,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
  Stream<RepresentantState> onTypeStructureChange(TypeStructureChanged event) async* {
    final typeStructure = TypeStructureInput.dirty(event.typeStructure);
    yield this.state.copyWith(
      typeStructure: typeStructure,
      formStatus: Formz.validate([
      this.state.prenom,
      this.state.nom,
      this.state.actif,
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
