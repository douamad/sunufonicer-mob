import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/refcadastrale/bloc/refcadastrale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:sunufoncier/entities/refcadastrale/refcadastrale_model.dart';
import 'refcadastrale_route.dart';

class RefcadastraleUpdateScreen extends StatelessWidget {
  RefcadastraleUpdateScreen({Key? key}) : super(key: RefcadastraleRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefcadastraleBloc, RefcadastraleState>(
      listener: (context, state) {
        if(state.formStatus.isSubmissionSuccess){
          Navigator.pushNamed(context, RefcadastraleRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Refcadastrales':
'Create Refcadastrales';
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
          codeSectionField(),
          codeParcelleField(),
          nicadField(),
          superficiField(),
          titreMereField(),
          titreCreeField(),
          numeroRequisitionField(),
          dateBornageField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget codeSectionField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.codeSection != current.codeSection,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().codeSectionController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(CodeSectionChanged(codeSection:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'codeSection'));
            }
        );
      }
      Widget codeParcelleField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.codeParcelle != current.codeParcelle,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().codeParcelleController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(CodeParcelleChanged(codeParcelle:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'codeParcelle'));
            }
        );
      }
      Widget nicadField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.nicad != current.nicad,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().nicadController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(NicadChanged(nicad:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nicad'));
            }
        );
      }
      Widget superficiField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.superfici != current.superfici,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().superficiController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(SuperficiChanged(superfici:double.parse(value))); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'superfici'));
            }
        );
      }
      Widget titreMereField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.titreMere != current.titreMere,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().titreMereController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(TitreMereChanged(titreMere:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'titreMere'));
            }
        );
      }
      Widget titreCreeField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.titreCree != current.titreCree,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().titreCreeController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(TitreCreeChanged(titreCree:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'titreCree'));
            }
        );
      }
      Widget numeroRequisitionField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.numeroRequisition != current.numeroRequisition,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<RefcadastraleBloc>().numeroRequisitionController,
                  onChanged: (value) { context.read<RefcadastraleBloc>()
                    .add(NumeroRequisitionChanged(numeroRequisition:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'numeroRequisition'));
            }
        );
      }
      Widget dateBornageField() {
        return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
            buildWhen: (previous, current) => previous.dateBornage != current.dateBornage,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<RefcadastraleBloc>().dateBornageController,
                onChanged: (value) { context.read<RefcadastraleBloc>().add(DateBornageChanged(dateBornage: value!)); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'dateBornage',),
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


  Widget validationZone() {
    return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isSubmissionFailure ||  state.formStatus.isSubmissionSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(RefcadastraleState state, BuildContext context) {
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
    return BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
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
            onPressed: state.formStatus.isValidated ? () => context.read<RefcadastraleBloc>().add(RefcadastraleFormSubmitted()) : null,
          );
        }
    );
  }
}
