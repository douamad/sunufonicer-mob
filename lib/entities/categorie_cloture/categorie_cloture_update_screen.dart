import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/categorie_cloture/bloc/categorie_cloture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_model.dart';
import 'categorie_cloture_route.dart';

class CategorieClotureUpdateScreen extends StatelessWidget {
  CategorieClotureUpdateScreen({Key? key}) : super(key: CategorieClotureRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategorieClotureBloc, CategorieClotureState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, CategorieClotureRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit CategorieClotures':
'Create CategorieClotures';
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
          libelleField(),
          prixMetreCareField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget libelleField() {
        return BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
            buildWhen: (previous, current) => previous.libelle != current.libelle,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<CategorieClotureBloc>().libelleController,
                  onChanged: (value) { context.read<CategorieClotureBloc>()
                    .add(LibelleChanged(libelle:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'libelle'));
            }
        );
      }
      Widget prixMetreCareField() {
        return BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
            buildWhen: (previous, current) => previous.prixMetreCare != current.prixMetreCare,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<CategorieClotureBloc>().prixMetreCareController,
                  onChanged: (value) { context.read<CategorieClotureBloc>()
                    .add(PrixMetreCareChanged(prixMetreCare:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'prixMetreCare'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(CategorieClotureState state, BuildContext context) {
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
    return BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
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
            onPressed: state.formStatus.isValidated ? () => context.read<CategorieClotureBloc>().add(CategorieClotureFormSubmitted()) : null,
          );
        }
    );
  }
}
