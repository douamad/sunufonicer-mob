part of 'region_bloc.dart';

enum RegionStatusUI {init, loading, error, done}
enum RegionDeleteStatus {ok, ko, none}

class RegionState extends Equatable {
  final List<Region> regions;
  final Region loadedRegion;
  final bool editMode;
  final RegionDeleteStatus deleteStatus;
  final RegionStatusUI regionStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final CodeInput code;
  final LibelleInput libelle;


  RegionState({
    this.regions = const [],
    this.regionStatusUI = RegionStatusUI.init,
    this.loadedRegion = const Region(0,'','',),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = RegionDeleteStatus.none,
    this.code = const CodeInput.pure(),
    this.libelle = const LibelleInput.pure(),
  });

  RegionState copyWith({
    List<Region>? regions,
    RegionStatusUI? regionStatusUI,
    bool? editMode,
    RegionDeleteStatus? deleteStatus,
    Region? loadedRegion,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    CodeInput? code,
    LibelleInput? libelle,
  }) {
    return RegionState(
      regions: regions ?? this.regions,
      regionStatusUI: regionStatusUI ?? this.regionStatusUI,
      loadedRegion: loadedRegion ?? this.loadedRegion,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
    );
  }

  @override
  List<Object> get props => [regions, regionStatusUI,
     loadedRegion, editMode, deleteStatus, formStatus, generalNotificationKey,
code,libelle,];

  @override
  bool get stringify => true;
}
