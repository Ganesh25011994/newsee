import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsee/AppData/app_api_constants.dart';
import 'package:newsee/Utils/shared_preference_utils.dart';
import 'package:newsee/feature/auth/domain/model/user_details.dart';
import 'package:newsee/feature/leadInbox/domain/modal/lead_request.dart';
import 'package:newsee/feature/proposal_inbox/data/repository/proposal_inbox_repository_impl.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/group_proposal_inbox.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/proposal_inbox_request.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/proposal_inbox_responce_model.dart';
import 'package:newsee/feature/proposal_inbox/domain/repository/proposal_inbox_repository.dart';

part 'proposal_inbox_event.dart';
part 'proposal_inbox_state.dart';

class ProposalInboxBloc extends Bloc<ProposalInboxEvent, ProposalInboxState> {
  final ProposalInboxRepository proposalInboxRepository;

  ProposalInboxBloc({ProposalInboxRepository? repository})
    : proposalInboxRepository = repository ?? ProposalInboxRepositoryImpl(),
      super(ProposalInboxState()) {
    on<SearchProposalInboxEvent>(onSearchProposalInbox);
  }

  Future<void> onSearchProposalInbox(
    SearchProposalInboxEvent event,
    Emitter<ProposalInboxState> emit,
  ) async {
    emit(state.copyWith(status: ProposalInboxStatus.loading));
    UserDetails? userDetails = await loadUser();
    LeadInboxRequest request = LeadInboxRequest(
      userid: userDetails!.LPuserID,
      token: ApiConstants.api_qa_token,
      pageNo: event.request.pageNo,
      pageCount: event.request.pageCount,
    );

    final response = await proposalInboxRepository.searchProposalInbox(request);
    // check if response i success and contains valid data , success status is emitted

    if (response.isRight()) {
      emit(
        state.copyWith(
          status: ProposalInboxStatus.success,
          proposalResponseModel: response.right,
          currentPage: event.request.pageNo,
        ),
      );
    } else {
      print('Proposal failure response.left');
      emit(
        state.copyWith(
          status: ProposalInboxStatus.failure,
          errorMessage: response.left.message,
        ),
      );
    }
  }
}
