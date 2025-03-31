import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "contract_create_page_event.dart";

part "contract_create_page_state.dart";

class ContractCreatePageBloc
    extends Bloc<ContractCreatePageEvent, ContractCreatePageState> {
  ContractCreatePageBloc() : super(ContractCreatePageStateInitial());
}
