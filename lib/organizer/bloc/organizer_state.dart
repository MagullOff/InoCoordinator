part of 'organizer_bloc.dart';

class OrganizerState extends Equatable {
  final List<Page<dynamic>> pages;
  const OrganizerState({required this.pages});

  OrganizerState.base()
      : this(pages: [const MaterialPage(child: PageWithWatermark())]);

  OrganizerState.addPage(OrganizerState state, Widget newPage)
      : this(pages: [
          ...state.pages,
          ...[MaterialPage(child: newPage)]
        ]);

  OrganizerState.pagePop(OrganizerState state)
      : this(pages: state.pages..removeLast());

  @override
  List<Object> get props => [pages];
}
