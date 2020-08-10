import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class ReusableQuestionCard extends StatefulWidget {
  ReusableQuestionCard({@required this.question, @required this.choices});
  final String question;
  final List choices;
  _ReusableQuestionCardState state;

  List<String> getResult(){
    return state.getResult();
  }

  @override
  _ReusableQuestionCardState createState() => this.state = _ReusableQuestionCardState();
}

class _ReusableQuestionCardState extends State<ReusableQuestionCard> {
  List _userAnswers;
  String _userAnswersResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userAnswers = [];
    _userAnswersResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _userAnswersResult = _userAnswers.toString();
      });
    }
  }

  List<String> getResult(){
    return this._userAnswers.cast<String>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    titleText: widget.question,
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please make selection';
                      } else {
                        _saveForm();
                      }
                      return null;
                    },
                    dataSource: widget.choices,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    // required: true,
                    hintText: 'Please choose one or more',
                    initialValue: _userAnswers,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _userAnswers = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
