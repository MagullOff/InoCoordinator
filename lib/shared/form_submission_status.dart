import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FormSubmissionStatus extends Equatable {
  const FormSubmissionStatus();

  @override
  List<Object?> get props => [];
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exception;

  SubmissionFailed(this.exception);
}
