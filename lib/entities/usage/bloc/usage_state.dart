part of 'usage_bloc.dart';

enum UsageStatusUI {init, loading, error, done}
enum UsageDeleteStatus {ok, ko, none}

class UsageState extends Equatable {
  final List<Usage> usages;
  final Usage loadedUsage;
  final bool editMode;
  final UsageDeleteStatus deleteStatus;
  final UsageStatusUI usageStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  UsageState({
    this.usages = const [],
    this.usageStatusUI = UsageStatusUI.init,
    this.loadedUsage = const Usage(0,'','',),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = UsageDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  UsageState copyWith({
    List<Usage>? usages,
    UsageStatusUI? usageStatusUI,
    bool? editMode,
    UsageDeleteStatus? deleteStatus,
    Usage? loadedUsage,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return UsageState(
      usages: usages ?? this.usages,
      usageStatusUI: usageStatusUI ?? this.usageStatusUI,
      loadedUsage: loadedUsage ?? this.loadedUsage,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [usages, usageStatusUI,
     loadedUsage, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
