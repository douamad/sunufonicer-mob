import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/dossier/bloc/dossier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/dossier/dossier_model.dart';
import 'dossier_route.dart';

class DossierUpdateScreen extends StatelessWidget {
  DossierUpdateScreen({Key? key}) : super(key: DossierRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DossierBloc, DossierState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, DossierRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<DossierBloc, DossierState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Dossiers':
'Create Dossiers';
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
          numeroField(),
          montantLoyerField(),
          superficieBatieField(),
          coeffCorrectifBatieField(),
          valeurBatieField(),
          lineaireClotureField(),
          coeffClotureField(),
          valeurClotureField(),
          amenagementSpaciauxField(),
          valeurAmenagementField(),
          valeurVenaleField(),
          valeurLocativField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget numeroField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.numero != current.numero,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().numeroController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(NumeroChanged(numero:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'numero'));
            }
        );
      }
      Widget montantLoyerField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.montantLoyer != current.montantLoyer,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().montantLoyerController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(MontantLoyerChanged(montantLoyer:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'montantLoyer'));
            }
        );
      }
      Widget superficieBatieField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.superficieBatie != current.superficieBatie,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().superficieBatieController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(SuperficieBatieChanged(superficieBatie:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'superficieBatie'));
            }
        );
      }
      Widget coeffCorrectifBatieField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.coeffCorrectifBatie != current.coeffCorrectifBatie,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().coeffCorrectifBatieController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(CoeffCorrectifBatieChanged(coeffCorrectifBatie:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'coeffCorrectifBatie'));
            }
        );
      }
      Widget valeurBatieField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.valeurBatie != current.valeurBatie,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().valeurBatieController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(ValeurBatieChanged(valeurBatie:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valeurBatie'));
            }
        );
      }
      Widget lineaireClotureField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.lineaireCloture != current.lineaireCloture,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().lineaireClotureController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(LineaireClotureChanged(lineaireCloture:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'lineaireCloture'));
            }
        );
      }
      Widget coeffClotureField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.coeffCloture != current.coeffCloture,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().coeffClotureController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(CoeffClotureChanged(coeffCloture:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'coeffCloture'));
            }
        );
      }
      Widget valeurClotureField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.valeurCloture != current.valeurCloture,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().valeurClotureController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(ValeurClotureChanged(valeurCloture:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valeurCloture'));
            }
        );
      }
      Widget amenagementSpaciauxField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.amenagementSpaciaux != current.amenagementSpaciaux,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().amenagementSpaciauxController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(AmenagementSpaciauxChanged(amenagementSpaciaux:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'amenagementSpaciaux'));
            }
        );
      }
      Widget valeurAmenagementField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.valeurAmenagement != current.valeurAmenagement,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().valeurAmenagementController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(ValeurAmenagementChanged(valeurAmenagement:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valeurAmenagement'));
            }
        );
      }
      Widget valeurVenaleField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.valeurVenale != current.valeurVenale,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().valeurVenaleController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(ValeurVenaleChanged(valeurVenale:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valeurVenale'));
            }
        );
      }
      Widget valeurLocativField() {
        return BlocBuilder<DossierBloc, DossierState>(
            buildWhen: (previous, current) => previous.valeurLocativ != current.valeurLocativ,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DossierBloc>().valeurLocativController,
                  onChanged: (value) { context.read<DossierBloc>()
                    .add(ValeurLocativChanged(valeurLocativ:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valeurLocativ'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<DossierBloc, DossierState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(DossierState state, BuildContext context) {
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
    return BlocBuilder<DossierBloc, DossierState>(
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
            onPressed: state.formStatus.isValidated ? () => context.read<DossierBloc>().add(DossierFormSubmitted()) : null,
          );
        }
    );
  }
}
