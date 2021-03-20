import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yummer/presentation/core/authentication/authentication.dart';
import 'package:yummer/domain/user_detail/user_detail.dart';
import 'package:yummer/presentation/core/internet_connectivity/internet_connectivity.dart';
import 'package:yummer/presentation/features/feature.dart';
import 'package:formz/formz.dart';

part 'create_user_detail_state.dart';

class CreateUserDetailCubit extends Cubit<CreateUserDetailState> {
  final UserDetailRepository _userDetailRepository;
  final AuthenticationBloc _authenticationBloc;
  final InternetConnectivityCubit _internetConnectivityCubit;

  CreateUserDetailCubit({
    @required UserDetailRepository userDetailRepository,
    @required AuthenticationBloc authenticationBloc,
    @required InternetConnectivityCubit internetConnectivityCubit,
  })  : assert(userDetailRepository != null),
        assert(authenticationBloc != null),
        assert(internetConnectivityCubit != null),
        _userDetailRepository = userDetailRepository,
        _authenticationBloc = authenticationBloc,
        _internetConnectivityCubit = internetConnectivityCubit,
        super(const CreateUserDetailState());

  void nameChanged(String value) {
    final name = NameValueObject.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.email]),
    ));
  }

  void emailChanged(String value) {
    final email = EmailModel.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.name]),
    ));
  }

  Future<void> createUserDetails() async {
    if (_internetConnectivityCubit.state is InternetConnected == false) {
      emit(
        state.copyWith(errorMessage: "No internet connection."),
      );
      return;
    }

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
       // formSubmitted: true,
      ),
    );
    print("STARTED CREATION USER");
    if (!state.status.isValidated ||
        state.name.invalid ||
        state.email.invalid) {
            print("Faield validation");
      emit(state.copyWith(
        formSubmitted: true,
        status: Formz.validate([state.name, state.email]),
      ));
      return;
    }

    try {
      final String phoneNumber = _authenticationBloc.state.user.phoneNumber;
      if (phoneNumber == null || phoneNumber.isEmpty) {
        throw Exception(
            "Your session expired. Please log out and log back in.");
      }

      final userDetailModel = UserDetailModel(
        phoneNumber: phoneNumber,
        email: state.email.value,
        name: state.name.value,
      );

      await _userDetailRepository.createUserDetail(
        userDetailModel: userDetailModel,
      );

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e != null && e.toString().isNotEmpty
                ? e.toString()
                : "Failed to create user. Please try again."),
      );
    }
  }
}
