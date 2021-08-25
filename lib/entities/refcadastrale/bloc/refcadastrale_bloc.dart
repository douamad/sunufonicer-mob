import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/refcadastrale/refcadastrale_model.dart';
import 'package:sunufoncier/entities/refcadastrale/refcadastrale_repository.dart';
import 'package:sunufoncier/entities/refcadastrale/bloc/refcadastrale_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'refcadastrale_events.dart';
part 'refcadastrale_state.dart';

class RefcadastraleBloc extends Bloc<RefcadastraleEvent, RefcadastraleState> {
  final RefcadastraleRepository _refcadastraleRepository;

  final codeSectionController = TextEditingController();
  final codeParcelleController = TextEditingController();
  final nicadController = TextEditingController();
  final superficiController = TextEditingController();
  final titreMereController = TextEditingController();
  final titreCreeController = TextEditingController();
  final numeroRequisitionController = TextEditingController();
  final dateBornageController = TextEditingController();

  RefcadastraleBloc({required RefcadastraleRepository refcadastraleRepository}) :
        _refcadastraleRepository = refcadastraleRepository,
  super(RefcadastraleState());

  @override
  void onTransition(Transition<RefcadastraleEvent, RefcadastraleState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<RefcadastraleState> mapEventToState(RefcadastraleEvent event) async* {
    if (event is InitRefcadastraleList) {
      yield* onInitList(event);
    } else if (event is RefcadastraleFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadRefcadastraleByIdForEdit) {
      yield* onLoadRefcadastraleIdForEdit(event);
    } else if (event is DeleteRefcadastraleById) {
      yield* onDeleteRefcadastraleId(event);
    } else if (event is LoadRefcadastraleByIdForView) {
      yield* onLoadRefcadastraleIdForView(event);
    }else if (event is CodeSectionChanged){
      yield* onCodeSectionChange(event);
    }else if (event is CodeParcelleChanged){
      yield* onCodeParcelleChange(event);
    }else if (event is NicadChanged){
      yield* onNicadChange(event);
    }else if (event is SuperficiChanged){
      yield* onSuperficiChange(event);
    }else if (event is TitreMereChanged){
      yield* onTitreMereChange(event);
    }else if (event is TitreCreeChanged){
      yield* onTitreCreeChange(event);
    }else if (event is NumeroRequisitionChanged){
      yield* onNumeroRequisitionChange(event);
    }else if (event is DateBornageChanged){
      yield* onDateBornageChange(event);
    }  }

  Stream<RefcadastraleState> onInitList(InitRefcadastraleList event) async* {
    yield this.state.copyWith(refcadastraleStatusUI: RefcadastraleStatusUI.loading);
    List<Refcadastrale>? refcadastrales = await _refcadastraleRepository.getAllRefcadastrales();
    yield this.state.copyWith(refcadastrales: refcadastrales, refcadastraleStatusUI: RefcadastraleStatusUI.done);
  }

  Stream<RefcadastraleState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Refcadastrale? result;
        if(this.state.editMode) {
          Refcadastrale newRefcadastrale = Refcadastrale(state.loadedRefcadastrale.id,
            this.state.codeSection.value,
            this.state.codeParcelle.value,
            this.state.nicad.value,
            this.state.superfici.value,
            this.state.titreMere.value,
            this.state.titreCree.value,
            this.state.numeroRequisition.value,
            this.state.dateBornage.value,
          );

          result = await _refcadastraleRepository.update(newRefcadastrale);
        } else {
          Refcadastrale newRefcadastrale = Refcadastrale(null,
            this.state.codeSection.value,
            this.state.codeParcelle.value,
            this.state.nicad.value,
            this.state.superfici.value,
            this.state.titreMere.value,
            this.state.titreCree.value,
            this.state.numeroRequisition.value,
            this.state.dateBornage.value,
          );

          result = await _refcadastraleRepository.create(newRefcadastrale);
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

  Stream<RefcadastraleState> onLoadRefcadastraleIdForEdit(LoadRefcadastraleByIdForEdit? event) async* {
    yield this.state.copyWith(refcadastraleStatusUI: RefcadastraleStatusUI.loading);
    Refcadastrale? loadedRefcadastrale = await _refcadastraleRepository.getRefcadastrale(event?.id);

    final codeSection = CodeSectionInput.dirty((loadedRefcadastrale!.codeSection != null ? loadedRefcadastrale.codeSection: '')!);
    final codeParcelle = CodeParcelleInput.dirty((loadedRefcadastrale.codeParcelle != null ? loadedRefcadastrale.codeParcelle: '')!);
    final nicad = NicadInput.dirty((loadedRefcadastrale.nicad != null ? loadedRefcadastrale.nicad: '')!);
    final superfici = SuperficiInput.dirty((loadedRefcadastrale.superfici != null ? loadedRefcadastrale.superfici: 0.0)!);
    final titreMere = TitreMereInput.dirty((loadedRefcadastrale.titreMere != null ? loadedRefcadastrale.titreMere: '')!);
    final titreCree = TitreCreeInput.dirty((loadedRefcadastrale.titreCree != null ? loadedRefcadastrale.titreCree: '')!);
    final numeroRequisition = NumeroRequisitionInput.dirty((loadedRefcadastrale.numeroRequisition != null ? loadedRefcadastrale.numeroRequisition: '')!);
    final dateBornage = DateBornageInput.dirty((loadedRefcadastrale.dateBornage != null ? loadedRefcadastrale.dateBornage: null)!);

    yield this.state.copyWith(loadedRefcadastrale: loadedRefcadastrale, editMode: true,
      codeSection: codeSection,
      codeParcelle: codeParcelle,
      nicad: nicad,
      superfici: superfici,
      titreMere: titreMere,
      titreCree: titreCree,
      numeroRequisition: numeroRequisition,
      dateBornage: dateBornage,
    refcadastraleStatusUI: RefcadastraleStatusUI.done);

    codeSectionController.text = loadedRefcadastrale.codeSection!;
    codeParcelleController.text = loadedRefcadastrale.codeParcelle!;
    nicadController.text = loadedRefcadastrale.nicad!;
    superficiController.text = loadedRefcadastrale.superfici! as String;
    titreMereController.text = loadedRefcadastrale.titreMere!;
    titreCreeController.text = loadedRefcadastrale.titreCree!;
    numeroRequisitionController.text = loadedRefcadastrale.numeroRequisition!;
    dateBornageController.text = DateFormat.yMMMMd('en').format(loadedRefcadastrale.dateBornage!);
  }

  Stream<RefcadastraleState> onDeleteRefcadastraleId(DeleteRefcadastraleById event) async* {
    try {
      await _refcadastraleRepository.delete(event.id!);
      this.add(InitRefcadastraleList());
      yield this.state.copyWith(deleteStatus: RefcadastraleDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: RefcadastraleDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: RefcadastraleDeleteStatus.none);
  }

  Stream<RefcadastraleState> onLoadRefcadastraleIdForView(LoadRefcadastraleByIdForView event) async* {
    yield this.state.copyWith(refcadastraleStatusUI: RefcadastraleStatusUI.loading);
    try {
      Refcadastrale? loadedRefcadastrale = await _refcadastraleRepository.getRefcadastrale(event.id);
      yield this.state.copyWith(loadedRefcadastrale: loadedRefcadastrale, refcadastraleStatusUI: RefcadastraleStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedRefcadastrale: null, refcadastraleStatusUI: RefcadastraleStatusUI.error);
    }
  }


  Stream<RefcadastraleState> onCodeSectionChange(CodeSectionChanged event) async* {
    final codeSection = CodeSectionInput.dirty(event.codeSection);
    yield this.state.copyWith(
      codeSection: codeSection,
      formStatus: Formz.validate([
        codeSection,
      this.state.codeParcelle,
      this.state.nicad,
      this.state.superfici,
      this.state.titreMere,
      this.state.titreCree,
      this.state.numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onCodeParcelleChange(CodeParcelleChanged event) async* {
    final codeParcelle = CodeParcelleInput.dirty(event.codeParcelle);
    yield this.state.copyWith(
      codeParcelle: codeParcelle,
      formStatus: Formz.validate([
      this.state.codeSection,
        codeParcelle,
      this.state.nicad,
      this.state.superfici,
      this.state.titreMere,
      this.state.titreCree,
      this.state.numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onNicadChange(NicadChanged event) async* {
    final nicad = NicadInput.dirty(event.nicad);
    yield this.state.copyWith(
      nicad: nicad,
      formStatus: Formz.validate([
      this.state.codeSection,
      this.state.codeParcelle,
        nicad,
      this.state.superfici,
      this.state.titreMere,
      this.state.titreCree,
      this.state.numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onSuperficiChange(SuperficiChanged event) async* {
    final superfici = SuperficiInput.dirty(event.superfici);
    yield this.state.copyWith(
      superfici: superfici,
      formStatus: Formz.validate([
      this.state.codeSection,
      this.state.codeParcelle,
      this.state.nicad,
        superfici,
      this.state.titreMere,
      this.state.titreCree,
      this.state.numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onTitreMereChange(TitreMereChanged event) async* {
    final titreMere = TitreMereInput.dirty(event.titreMere);
    yield this.state.copyWith(
      titreMere: titreMere,
      formStatus: Formz.validate([
      this.state.codeSection,
      this.state.codeParcelle,
      this.state.nicad,
      this.state.superfici,
        titreMere,
      this.state.titreCree,
      this.state.numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onTitreCreeChange(TitreCreeChanged event) async* {
    final titreCree = TitreCreeInput.dirty(event.titreCree);
    yield this.state.copyWith(
      titreCree: titreCree,
      formStatus: Formz.validate([
      this.state.codeSection,
      this.state.codeParcelle,
      this.state.nicad,
      this.state.superfici,
      this.state.titreMere,
        titreCree,
      this.state.numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onNumeroRequisitionChange(NumeroRequisitionChanged event) async* {
    final numeroRequisition = NumeroRequisitionInput.dirty(event.numeroRequisition);
    yield this.state.copyWith(
      numeroRequisition: numeroRequisition,
      formStatus: Formz.validate([
      this.state.codeSection,
      this.state.codeParcelle,
      this.state.nicad,
      this.state.superfici,
      this.state.titreMere,
      this.state.titreCree,
        numeroRequisition,
      this.state.dateBornage,
      ]),
    );
  }
  Stream<RefcadastraleState> onDateBornageChange(DateBornageChanged event) async* {
    final dateBornage = DateBornageInput.dirty(event.dateBornage);
    yield this.state.copyWith(
      dateBornage: dateBornage,
      formStatus: Formz.validate([
      this.state.codeSection,
      this.state.codeParcelle,
      this.state.nicad,
      this.state.superfici,
      this.state.titreMere,
      this.state.titreCree,
      this.state.numeroRequisition,
        dateBornage,
      ]),
    );
  }

  @override
  Future<void> close() {
    codeSectionController.dispose();
    codeParcelleController.dispose();
    nicadController.dispose();
    superficiController.dispose();
    titreMereController.dispose();
    titreCreeController.dispose();
    numeroRequisitionController.dispose();
    dateBornageController.dispose();
    return super.close();
  }

}
