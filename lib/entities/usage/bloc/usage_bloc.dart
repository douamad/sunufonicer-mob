import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:sunufoncier/entities/usage/usage_model.dart';
import 'package:sunufoncier/entities/usage/usage_repository.dart';
import 'package:sunufoncier/entities/usage/bloc/usage_form_model.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'usage_events.dart';
part 'usage_state.dart';

class UsageBloc extends Bloc<UsageEvent, UsageState> {
  final UsageRepository _usageRepository;

  final codeController = TextEditingController();
  final libelleController = TextEditingController();

  UsageBloc({required UsageRepository usageRepository}) :
        _usageRepository = usageRepository,
  super(UsageState());

  @override
  void onTransition(Transition<UsageEvent, UsageState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<UsageState> mapEventToState(UsageEvent event) async* {
    if (event is InitUsageList) {
      yield* onInitList(event);
    } else if (event is UsageFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadUsageByIdForEdit) {
      yield* onLoadUsageIdForEdit(event);
    } else if (event is DeleteUsageById) {
      yield* onDeleteUsageId(event);
    } else if (event is LoadUsageByIdForView) {
      yield* onLoadUsageIdForView(event);
    }else if (event is CodeChanged){
      yield* onCodeChange(event);
    }else if (event is LibelleChanged){
      yield* onLibelleChange(event);
    }  }

  Stream<UsageState> onInitList(InitUsageList event) async* {
    yield this.state.copyWith(usageStatusUI: UsageStatusUI.loading);
    List<Usage>? usages = await _usageRepository.getAllUsages();
    yield this.state.copyWith(usages: usages, usageStatusUI: UsageStatusUI.done);
  }

  Stream<UsageState> onSubmit() async* {
    if (this.state.formStatus.isValidated) {
      yield this.state.copyWith(formStatus: FormzStatus.submissionInProgress);
      try {
        Usage? result;
        if(this.state.editMode) {
          Usage newUsage = Usage(state.loadedUsage.id,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _usageRepository.update(newUsage);
        } else {
          Usage newUsage = Usage(null,
            this.state.code.value,
            this.state.libelle.value,
          );

          result = await _usageRepository.create(newUsage);
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

  Stream<UsageState> onLoadUsageIdForEdit(LoadUsageByIdForEdit? event) async* {
    yield this.state.copyWith(usageStatusUI: UsageStatusUI.loading);
    Usage? loadedUsage = await _usageRepository.getUsage(event?.id);

    final code = CodeInput.dirty((loadedUsage!.code != null ? loadedUsage.code: '')!);
    final libelle = LibelleInput.dirty((loadedUsage.libelle != null ? loadedUsage.libelle: '')!);

    yield this.state.copyWith(loadedUsage: loadedUsage, editMode: true,
      code: code,
      libelle: libelle,
    usageStatusUI: UsageStatusUI.done);

    codeController.text = loadedUsage.code!;
    libelleController.text = loadedUsage.libelle!;
  }

  Stream<UsageState> onDeleteUsageId(DeleteUsageById event) async* {
    try {
      await _usageRepository.delete(event.id!);
      this.add(InitUsageList());
      yield this.state.copyWith(deleteStatus: UsageDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: UsageDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: UsageDeleteStatus.none);
  }

  Stream<UsageState> onLoadUsageIdForView(LoadUsageByIdForView event) async* {
    yield this.state.copyWith(usageStatusUI: UsageStatusUI.loading);
    try {
      Usage? loadedUsage = await _usageRepository.getUsage(event.id);
      yield this.state.copyWith(loadedUsage: loadedUsage, usageStatusUI: UsageStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedUsage: null, usageStatusUI: UsageStatusUI.error);
    }
  }


  Stream<UsageState> onCodeChange(CodeChanged event) async* {
    final code = CodeInput.dirty(event.code);
    yield this.state.copyWith(
      code: code,
      formStatus: Formz.validate([
        code,
      this.state.libelle,
      ]),
    );
  }
  Stream<UsageState> onLibelleChange(LibelleChanged event) async* {
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
