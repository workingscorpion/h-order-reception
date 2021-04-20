// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigationStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavigationStore on NavigationStoreBase, Store {
  final _$tabControllerAtom = Atom(name: 'NavigationStoreBase.tabController');

  @override
  TabController get tabController {
    _$tabControllerAtom.reportRead();
    return super.tabController;
  }

  @override
  set tabController(TabController value) {
    _$tabControllerAtom.reportWrite(value, super.tabController, () {
      super.tabController = value;
    });
  }

  final _$collectionTabControllerAtom =
      Atom(name: 'NavigationStoreBase.collectionTabController');

  @override
  TabController get collectionTabController {
    _$collectionTabControllerAtom.reportRead();
    return super.collectionTabController;
  }

  @override
  set collectionTabController(TabController value) {
    _$collectionTabControllerAtom
        .reportWrite(value, super.collectionTabController, () {
      super.collectionTabController = value;
    });
  }

  final _$tabIndexAtom = Atom(name: 'NavigationStoreBase.tabIndex');

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  final _$applyNotificationAsyncAction =
      AsyncAction('NavigationStoreBase.applyNotification');

  @override
  Future applyNotification() {
    return _$applyNotificationAsyncAction.run(() => super.applyNotification());
  }

  @override
  String toString() {
    return '''
tabController: ${tabController},
collectionTabController: ${collectionTabController},
tabIndex: ${tabIndex}
    ''';
  }
}
