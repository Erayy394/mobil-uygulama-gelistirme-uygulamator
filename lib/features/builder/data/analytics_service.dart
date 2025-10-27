/// Basit analytics servisi
class AnalyticsService {
  static final AnalyticsService instance = AnalyticsService._();
  AnalyticsService._();

  final Map<String, int> _events = {};

  void trackEvent(String eventName) {
    _events[eventName] = (_events[eventName] ?? 0) + 1;
    print('[Analytics] $eventName: ${_events[eventName]}');
  }

  int getEventCount(String eventName) => _events[eventName] ?? 0;

  Map<String, int> getAllEvents() => Map.from(_events);
}

/// Bildirim sistemi
class NotificationService {
  static final NotificationService instance = NotificationService._();
  NotificationService._();

  List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void addNotification(String title, String body) {
    _notifications.insert(0,
        NotificationItem(title: title, body: body, createdAt: DateTime.now()));
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();
}

/// Search service
class SearchService {
  static final SearchService instance = SearchService._();
  SearchService._();

  List<String> searchHistory = [];

  List<String> search(String query, List<Map<String, dynamic>> items) {
    if (query.isEmpty) return [];

    searchHistory.add(query);

    return items
        .where((item) =>
            item['name'].toString().toLowerCase().contains(query.toLowerCase()))
        .map((item) => item['name'].toString())
        .toList();
  }
}

/// Mock data service
class MockDataService {
  static final MockDataService instance = MockDataService._();
  MockDataService._();

  List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'Ürün 1',
      'price': 99.99,
      'image': '🎁',
      'category': 'Elektronik'
    },
    {
      'id': '2',
      'name': 'Ürün 2',
      'price': 149.99,
      'image': '🛍️',
      'category': 'Giyim'
    },
    {
      'id': '3',
      'name': 'Ürün 3',
      'price': 199.99,
      'image': '📱',
      'category': 'Elektronik'
    },
    {
      'id': '4',
      'name': 'Ürün 4',
      'price': 79.99,
      'image': '🍔',
      'category': 'Yiyecek'
    },
    {
      'id': '5',
      'name': 'Ürün 5',
      'price': 299.99,
      'image': '🎮',
      'category': 'Oyuncak'
    },
  ];

  List<Map<String, dynamic>> getFeatured() => products.take(3).toList();

  List<Map<String, dynamic>> getByCategory(String category) {
    return products.where((p) => p['category'] == category).toList();
  }
}
