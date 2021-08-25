import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/representant/bloc/representant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/representant/representant_model.dart';
import 'representant_route.dart';

class RepresentantUpdateScreen extends StatelessWidget {
  RepresentantUpdateScreen({Key? key}) : super(key: RepresentantRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RepresentantBloc, RepresentantState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, RepresentantRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<RepresentantBloc, RepresentantState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Representants':
'Create Representants';
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
          actifField(),
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
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.prenom != current.prenom,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().prenomController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(PrenomChanged(prenom:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'prenom'));
            }
        );
      }
      Widget nomField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.nom != current.nom,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().nomController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(NomChanged(nom:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nom'));
            }
        );
      }
        Widget actifField() {
          return BlocBuilder<RepresentantBloc,RepresentantState>(
              buildWhen: (previous, current) => previous.actif != current.actif,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('actif', style: Theme.of(context).textTheme.bodyText1,),
                      Switch(
                          value: state.actif.value,
                          onChanged: (value) { context.read<RepresentantBloc>().add(ActifChanged(actif: value)); },
                          activeColor: Theme.of(context).primaryColor,),
                    ],
                  ),
                );
              });
        }
      Widget raisonSocialField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.raisonSocial != current.raisonSocial,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().raisonSocialController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(RaisonSocialChanged(raisonSocial:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'raisonSocial'));
            }
        );
      }
        Widget personneMoraleField() {
          return BlocBuilder<RepresentantBloc,RepresentantState>(
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
                          onChanged: (value) { context.read<RepresentantBloc>().add(PersonneMoraleChanged(personneMorale: value)); },
                          activeColor: Theme.of(context).primaryColor,),
                    ],
                  ),
                );
              });
        }
      Widget dateNaissField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.dateNaiss != current.dateNaiss,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<RepresentantBloc>().dateNaissController,
                onChanged: (value) { context.read<RepresentantBloc>().add(DateNaissChanged(dateNaiss: value!)); },
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
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.lieuNaissance != current.lieuNaissance,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().lieuNaissanceController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(LieuNaissanceChanged(lieuNaissance:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'lieuNaissance'));
            }
        );
      }
      Widget numCNIField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.numCNI != current.numCNI,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().numCNIController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(NumCNIChanged(numCNI:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'numCNI'));
            }
        );
      }
      Widget nineaField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.ninea != current.ninea,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().nineaController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(NineaChanged(ninea:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'ninea'));
            }
        );
      }
      Widget adresseField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.adresse != current.adresse,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().adresseController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(AdresseChanged(adresse:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'adresse'));
            }
        );
      }
      Widget emailField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().emailController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(EmailChanged(email:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'email'));
            }
        );
      }
      Widget telephoneField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.telephone != current.telephone,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().telephoneController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(TelephoneChanged(telephone:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telephone'));
            }
        );
      }
      Widget telephone2Field() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.telephone2 != current.telephone2,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().telephone2Controller,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(Telephone2Changed(telephone2:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telephone2'));
            }
        );
      }
      Widget telephone3Field() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.telephone3 != current.telephone3,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().telephone3Controller,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(Telephone3Changed(telephone3:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telephone3'));
            }
        );
      }
      Widget aquisitionField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.aquisition != current.aquisition,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().aquisitionController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(AquisitionChanged(aquisition:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'aquisition'));
            }
        );
      }
      Widget statutPersoneStructureField() {
        return BlocBuilder<RepresentantBloc, RepresentantState>(
            buildWhen: (previous, current) => previous.statutPersoneStructure != current.statutPersoneStructure,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RepresentantBloc>().statutPersoneStructureController,
                  onChanged: (value) { context.read<RepresentantBloc>()
                    .add(StatutPersoneStructureChanged(statutPersoneStructure:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'statutPersoneStructure'));
            }
        );
      }
      Widget typeStructureField() {
        return BlocBuilder<RepresentantBloc,RepresentantState>(
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
                        onChanged: (value) { context.read<RepresentantBloc>().add(TypeStructureChanged(typeStructure: value!)); },
                        items: createDropdownTypeStructureItems(TypeStructure.values)),
                  ],
                ),
              );
            });
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
    return BlocBuilder<RepresentantBloc, RepresentantState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(RepresentantState state, BuildContext context) {
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
    return BlocBuilder<RepresentantBloc, RepresentantState>(
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
            onPressed: state.formStatus.isValidated ? () => context.read<RepresentantBloc>().add(RepresentantFormSubmitted()) : null,
          );
        }
    );
  }
}
