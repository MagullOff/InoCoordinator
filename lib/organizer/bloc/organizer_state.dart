part of 'organizer_bloc.dart';

class OrganizerState extends Equatable {
  late List<Page<dynamic>> pages;
  OrganizerState({required this.pages});

  OrganizerState.base() {
    pages = [const MaterialPage(child: PageWithWatermark())];
  }

  OrganizerState.addPage(OrganizerState state, Widget newPage) {
    pages = [
      ...state.pages,
      ...[MaterialPage(child: newPage)]
    ];
  }

  OrganizerState.pagePop(OrganizerState state) {
    var newPages = state.pages;
    newPages.length = newPages.isEmpty ? 0 : newPages.length - 1;
    pages = newPages;
  }

  OrganizerState.popAndAddPage(OrganizerState state, Widget newPage) {
    var newPages = state.pages;
    newPages.length = newPages.isEmpty ? 0 : newPages.length - 1;
    pages = newPages;
    pages = [
      ...state.pages,
      ...[MaterialPage(child: newPage)]
    ];
  }

  @override
  List<Object> get props => [pages];
}
