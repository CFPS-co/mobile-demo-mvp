import 'package:bloc/bloc.dart';
import 'package:cfps/domain/entities/tariff_entity.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'tariff_state.dart';
part 'tariff_cubit.freezed.dart';

@injectable
class TariffCubit extends Cubit<TariffState> {
  TariffCubit() : super(const TariffState.initial()) {
    loadMockList();
  }

  void loadMockList() {
    final List<TariffEntity> itemsTariff = mockList
        .map((e) => TariffEntity(
              label: e["label"],
              value: e["value"],
            ))
        .toList();
    emit(TariffState.success(itemsTariff));
  }
}

List<Map> mockList = [
  {"label": "Subscription fee", "value": "0"},
  {"label": "Open account", "value": "0"},
  {"label": "Card", "value": "0"},
  {"label": "1st Physical card", "value": "0"},
  {"label": "Open account", "value": "0"},
  {"label": "Virtual card", "value": "0"},
  {"label": "1st card Delivery charge", "value": "0"},
  {"label": "ATM", "value": "0"},
  {"label": "ATM Withdrawals\n (domestic SEPA)", "value": "2+1.5%"},
  {"label": "ATM Withdrawals\n (outside SEPA)", "value": "2+2.5%"},
  {"label": "ATM Withdrawals\n (International)", "value": "0.5"},
  {"label": "ATM Balance Enquiry", "value": "0.5"},
  {"label": "ATM PIN Change", "value": "0.5"},
  {"label": "ATM Decline Fee", "value": "0"},
  {"label": "Transfers", "value": "0"},
  {"label": "SWIFT in", "value": "8"},
  {"label": "SWIFT out", "value": "23"},
  {"label": "SEPA Receiving", "value": "0"},
  {"label": "SEPA Sending", "value": "0.4"},
  {"label": "SEPA Credit Receiving", "value": "0"},
  {"label": "SEPA Credit Sending", "value": "0.4"},
  {"label": "SEPA Instant Receiving", "value": "0"},
  {"label": "SEPA Instant Sending", "value": "0.4"},
  {"label": "Account to Account Transfer\n within the CFPS", "value": "0"}
];
