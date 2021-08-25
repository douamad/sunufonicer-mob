part of 'ref_parcelaire_bloc.dart';

enum RefParcelaireStatusUI {init, loading, error, done}
enum RefParcelaireDeleteStatus {ok, ko, none}

class RefParcelaireState extends Equatable {
  final List<RefParcelaire> refParcelaires;
  final RefParcelaire loadedRefParcelaire;
  final bool editMode;
  final RefParcelaireDeleteStatus deleteStatus;
  final RefParcelaireStatusUI refParcelaireStatusUI;

  final FormzStatus formStatus;
  final String generalNotificationKey;

  final NumeroParcelleInput numeroParcelle;
  final NatureParcelleInput natureParcelle;


  RefParcelaireState({
    this.refParcelaires = const [],
    this.refParcelaireStatusUI = RefParcelaireStatusUI.init,
    this.loadedRefParcelaire = const RefParcelaire(0,'','',),
    this.editMode = false,
    this.formStatus = FormzStatus.pure,
    this.generalNotificationKey = '',
    this.deleteStatus = RefParcelaireDeleteStatus.none,
    this.numeroParcelle = const NumeroParcelleInput.pure(),
    this.natureParcelle = const NatureParcelleInput.pure(),
  });

  RefParcelaireState copyWith({
    List<RefParcelaire>? refParcelaires,
    RefParcelaireStatusUI? refParcelaireStatusUI,
    bool? editMode,
    RefParcelaireDeleteStatus? deleteStatus,
    RefParcelaire? loadedRefParcelaire,
    FormzStatus? formStatus,
    String? generalNotificationKey,
    NumeroParcelleInput? numeroParcelle,
    NatureParcelleInput? natureParcelle,
  }) {
    return RefParcelaireState(
      refParcelaires: refParcelaires ?? this.refParcelaires,
      refParcelaireStatusUI: refParcelaireStatusUI ?? this.refParcelaireStatusUI,
      loadedRefParcelaire: loadedRefParcelaire ?? this.loadedRefParcelaire,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      numeroParcelle: numeroParcelle ?? this.numeroParcelle,
      natureParcelle: natureParcelle ?? this.natureParcelle,
    );
  }

  @override
  List<Object> get props => [refParcelaires, refParcelaireStatusUI,
     loadedRefParcelaire, editMode, deleteStatus, formStatus, generalNotificationKey,
numeroParcelle,natureParcelle,];

  @override
  bool get stringify => true;
}
