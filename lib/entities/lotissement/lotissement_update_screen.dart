import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/lotissement/bloc/lotissement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/lotissement/lotissement_model.dart';
import 'lotissement_route.dart';

class LotissementUpdateScreen extends StatelessWidget {
  LotissementUpdateScreen({Key? key}) : super(key: LotissementRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LotissementBloc, LotissementState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, LotissementRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<LotissementBloc, LotissementState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Lotissements':
'Create Lotissements';
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
          codeField(),
          libelleField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget codeField() {
        return BlocBuilder<LotissementBloc, LotissementState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<LotissementBloc>().codeController,
                  onChanged: (value) { context.read<LotissementBloc>()
                    .add(CodeChanged(code:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'code'));
            }
        );
      }
      Widget libelleField() {
        return BlocBuilder<LotissementBloc, LotissementState>(
            buildWhen: (previous, current) => previous.libelle != current.libelle,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<LotissementBloc>().libelleController,
                  onChanged: (value) { context.read<LotissementBloc>()
                    .add(LibelleChanged(libelle:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'libelle'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<LotissementBloc, LotissementState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(LotissementState state, BuildContext context) {
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
    return BlocBuilder<LotissementBloc, LotissementState>(
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
            onPressed: state.formStatus.isValidated ? () => context.read<LotissementBloc>().add(LotissementFormSubmitted()) : null,
          );
        }
    );
  }
}
