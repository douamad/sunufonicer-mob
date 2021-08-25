import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/ref_parcelaire/bloc/ref_parcelaire_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_model.dart';
import 'ref_parcelaire_route.dart';

class RefParcelaireUpdateScreen extends StatelessWidget {
  RefParcelaireUpdateScreen({Key? key}) : super(key: RefParcelaireRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefParcelaireBloc, RefParcelaireState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, RefParcelaireRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit RefParcelaires':
'Create RefParcelaires';
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
          numeroParcelleField(),
          natureParcelleField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget numeroParcelleField() {
        return BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
            buildWhen: (previous, current) => previous.numeroParcelle != current.numeroParcelle,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefParcelaireBloc>().numeroParcelleController,
                  onChanged: (value) { context.read<RefParcelaireBloc>()
                    .add(NumeroParcelleChanged(numeroParcelle:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'numeroParcelle'));
            }
        );
      }
      Widget natureParcelleField() {
        return BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
            buildWhen: (previous, current) => previous.natureParcelle != current.natureParcelle,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefParcelaireBloc>().natureParcelleController,
                  onChanged: (value) { context.read<RefParcelaireBloc>()
                    .add(NatureParcelleChanged(natureParcelle:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'natureParcelle'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(RefParcelaireState state, BuildContext context) {
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
    return BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
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
            onPressed: state.formStatus.isValidated ? () => context.read<RefParcelaireBloc>().add(RefParcelaireFormSubmitted()) : null,
          );
        }
    );
  }
}
