import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/proprietaire/bloc/proprietaire_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/proprietaire/proprietaire_model.dart';
import 'proprietaire_route.dart';

class ProprietaireUpdateScreen extends StatelessWidget {
  ProprietaireUpdateScreen({Key? key}) : super(key: ProprietaireRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProprietaireBloc, ProprietaireState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, ProprietaireRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<ProprietaireBloc, ProprietaireState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Proprietaires':
'Create Proprietaires';
                 return Text(title);
                }
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[settingsForm(context)]),
          ),
      ),
    );
  }

  Widget settingsForm(BuildContext context) {
    return Form(
      child: Wrap(runSpacing: 15, children: <Widget>[
          prenomField(),
          nomField(),
          situationField(),
          raisonSocialField(),
          personneMoraleField(),
          dateNaissField(),
          lieuNaissanceField(),
          numCNIField(),
          nineaField(),
          adresseField(),
          emailField(),
          telephoneField(),
          telephone2Field(),
          telephone3Field(),
          aquisitionField(),
          statutPersoneStructureField(),
          typeStructureField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget prenomField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.prenom != current.prenom,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().prenomController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(PrenomChanged(prenom:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'prenom'));
            }
        );
      }
      Widget nomField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.nom != current.nom,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().nomController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(NomChanged(nom:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nom'));
            }
        );
      }
      Widget situationField() {
        return BlocBuilder<ProprietaireBloc,ProprietaireState>(
            buildWhen: (previous, current) => previous.situation != current.situation,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('situation', style: Theme.of(context).textTheme.bodyText1,),
                    DropdownButton<SituationProprietaire>(
                        value: state.situation.value,
                        onChanged: (value) { context.read<ProprietaireBloc>().add(SituationChanged(situation: value!)); },
                        items: createDropdownSituationProprietaireItems(SituationProprietaire.values)),
                  ],
                ),
              );
            });
      }
      Widget raisonSocialField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.raisonSocial != current.raisonSocial,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().raisonSocialController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(RaisonSocialChanged(raisonSocial:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'raisonSocial'));
            }
        );
      }
        Widget personneMoraleField() {
          return BlocBuilder<ProprietaireBloc,ProprietaireState>(
              buildWhen: (previous, current) => previous.personneMorale != current.personneMorale,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('personneMorale', style: Theme.of(context).textTheme.bodyText1,),
                      Switch(
                          value: state.personneMorale.value,
                          onChanged: (value) { context.read<ProprietaireBloc>().add(PersonneMoraleChanged(personneMorale: value)); },
                          activeColor: Theme.of(context).primaryColor,),
                    ],
                  ),
                );
              });
        }
      Widget dateNaissField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.dateNaiss != current.dateNaiss,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<ProprietaireBloc>().dateNaissController,
                onChanged: (value) { context.read<ProprietaireBloc>().add(DateNaissChanged(dateNaiss: value!)); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'dateNaiss',),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      locale: Locale('en'),
                      context: context,
                      firstDate: DateTime(1950),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2050));
                },
              );
            }
        );
      }
      Widget lieuNaissanceField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.lieuNaissance != current.lieuNaissance,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().lieuNaissanceController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(LieuNaissanceChanged(lieuNaissance:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'lieuNaissance'));
            }
        );
      }
      Widget numCNIField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.numCNI != current.numCNI,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().numCNIController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(NumCNIChanged(numCNI:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'numCNI'));
            }
        );
      }
      Widget nineaField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.ninea != current.ninea,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().nineaController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(NineaChanged(ninea:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'ninea'));
            }
        );
      }
      Widget adresseField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.adresse != current.adresse,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().adresseController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(AdresseChanged(adresse:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'adresse'));
            }
        );
      }
      Widget emailField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().emailController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(EmailChanged(email:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'email'));
            }
        );
      }
      Widget telephoneField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.telephone != current.telephone,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().telephoneController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(TelephoneChanged(telephone:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telephone'));
            }
        );
      }
      Widget telephone2Field() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.telephone2 != current.telephone2,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().telephone2Controller,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(Telephone2Changed(telephone2:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telephone2'));
            }
        );
      }
      Widget telephone3Field() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.telephone3 != current.telephone3,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().telephone3Controller,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(Telephone3Changed(telephone3:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telephone3'));
            }
        );
      }
      Widget aquisitionField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.aquisition != current.aquisition,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().aquisitionController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(AquisitionChanged(aquisition:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'aquisition'));
            }
        );
      }
      Widget statutPersoneStructureField() {
        return BlocBuilder<ProprietaireBloc, ProprietaireState>(
            buildWhen: (previous, current) => previous.statutPersoneStructure != current.statutPersoneStructure,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProprietaireBloc>().statutPersoneStructureController,
                  onChanged: (value) { context.read<ProprietaireBloc>()
                    .add(StatutPersoneStructureChanged(statutPersoneStructure:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'statutPersoneStructure'));
            }
        );
      }
      Widget typeStructureField() {
        return BlocBuilder<ProprietaireBloc,ProprietaireState>(
            buildWhen: (previous, current) => previous.typeStructure != current.typeStructure,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('typeStructure', style: Theme.of(context).textTheme.bodyText1,),
                    DropdownButton<TypeStructure>(
                        value: state.typeStructure.value,
                        onChanged: (value) { context.read<ProprietaireBloc>().add(TypeStructureChanged(typeStructure: value!)); },
                        items: createDropdownTypeStructureItems(TypeStructure.values)),
                  ],
                ),
              );
            });
      }

      List<DropdownMenuItem<SituationProprietaire>> createDropdownSituationProprietaireItems(List<SituationProprietaire> situations) {
        List<DropdownMenuItem<SituationProprietaire>> situationDropDown = [];

        for (SituationProprietaire situation in situations) {
          DropdownMenuItem<SituationProprietaire> dropdown = DropdownMenuItem<SituationProprietaire>(
              value: situation, child: Text(situation.toString()));
              situationDropDown.add(dropdown);
        }

        return situationDropDown;
      }
      List<DropdownMenuItem<TypeStructure>> createDropdownTypeStructureItems(List<TypeStructure> typeStructures) {
        List<DropdownMenuItem<TypeStructure>> typeStructureDropDown = [];

        for (TypeStructure typeStructure in typeStructures) {
          DropdownMenuItem<TypeStructure> dropdown = DropdownMenuItem<TypeStructure>(
              value: typeStructure, child: Text(typeStructure.toString()));
              typeStructureDropDown.add(dropdown);
        }

        return typeStructureDropDown;
      }

  Widget validationZone() {
    return BlocBuilder<ProprietaireBloc, ProprietaireState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(ProprietaireState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;

    if (state.generalNotificationKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).errorColor;
    } else if (state.generalNotificationKey.toString().compareTo(HttpUtils.badRequestServerKey) == 0) {
      notificationTranslated ='Something wrong happened with the received data';
      notificationColors = Theme.of(context).errorColor;
    }

    return Text(
      notificationTranslated,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
          color: notificationColors),
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<ProprietaireBloc, ProprietaireState>(
        buildWhen: (previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          String buttonLabel = state.editMode == true ?
'Edit':
'Create';
          return RaisedButton(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Visibility(
                    replacement: CircularProgressIndicator(value: null),
                    visible: !state.formStatus.isSubmissionInProgress,
                    child: Text(buttonLabel),
                  ),
                )),
            onPressed: state.formStatus.isValidated ? () => context.read<ProprietaireBloc>().add(ProprietaireFormSubmitted()) : null,
          );
        }
    );
  }
}
