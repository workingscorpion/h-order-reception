import 'package:flutter/material.dart';
import 'package:h_order_reception/app.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'navigationStore.g.dart';

class NavigationStore extends NavigationStoreBase with _$NavigationStore {
  static final Lazy<NavigationStore> _lazy =
      Lazy<NavigationStore>(() => new NavigationStore());

  static NavigationStore get instance => _lazy.value;
}

abstract class NavigationStoreBase with Store {
  final appKey = GlobalKey<AppState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  @observable
  TabController tabController;

  @observable
  TabController collectionTabController;

  @observable
  int tabIndex = 0;

  // @observable
  // NotificationData launchNotification;

  @action
  applyNotification() async {
    // if (launchNotification == null) {
    //   return;
    // }

    try {
      // await FCMManger.instance.openNotification(launchNotification);
    } finally {
      // launchNotification = null;
    }
  }
}
