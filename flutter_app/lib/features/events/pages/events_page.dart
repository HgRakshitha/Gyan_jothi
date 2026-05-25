import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/navigation/go_to_app_home.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/app_asset_image.dart';
import '../../../shared/widgets/quiz_header.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _selectedTab = 0; // 0 = Upcoming, 1 = Past Events

  static const _upcomingEvents = <_EventCardData>[
    _EventCardData(
      title: 'Annual Sports Day',
      description: 'Join us for a fun filled day of sports and games!',
      date: '15-03-2026',
      time: '10:00 AM',
      backgroundColor: Color(0xFFD2DDFB),
      imagePath: AppAssets.eventSports,
      isRegistered: false,
    ),
    _EventCardData(
      title: 'Science Exhibition',
      description: 'Explore amazing science experiments and projects.',
      date: '17-03-2026',
      time: '11:00 AM',
      backgroundColor: Color(0xFFFFE7C2),
      imagePath: AppAssets.eventSciExhibition,
      isRegistered: true,
    ),
    _EventCardData(
      title: 'Art Competition',
      description: 'Show your creativity! Best drawings will win prizes.',
      date: '15-03-2026',
      time: '12:00 PM',
      backgroundColor: Color(0xFFFFCEFB),
      imagePath: AppAssets.eventArtComp,
      isRegistered: false,
    ),
    _EventCardData(
      title: 'Cultural Fest',
      description: 'Join us for a vibrant day of music, dance, and celebration!',
      date: '20-03-2026',
      time: '10:00 AM',
      backgroundColor: Color(0xFFFADEDE),
      imagePath: AppAssets.eventCultural,
      isRegistered: false,
    ),
  ];

  static const _pastEvents = <_EventCardData>[
    _EventCardData(
      title: 'Republic day Celebrations',
      description: '',
      date: '26-01-2026',
      time: '',
      backgroundColor: Color(0xFFFFCADA),
      imagePath: AppAssets.eventRepublic,
      isRegistered: false,
    ),
    _EventCardData(
      title: 'Dance Fest',
      description: '',
      date: '15-02-2026',
      time: '',
      backgroundColor: Color(0xFFFFCEFB),
      imagePath: AppAssets.eventDance,
      isRegistered: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final events = _selectedTab == 0 ? _upcomingEvents : _pastEvents;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizHeader(
                title: 'Events',
                onBack: () => popOrGoToAppHome(context),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(padH, 20, padH, padB),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxContentW ?? double.infinity,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SegmentControl(
                            selectedIndex: _selectedTab,
                            onChanged: (i) => setState(() => _selectedTab = i),
                          ),
                          const SizedBox(height: 20),
                          if (events.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Text(
                                  'No past events yet.',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            )
                          else
                            ...List.generate(
                              events.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: index == events.length - 1 ? 0 : 18,
                                ),
                                child: _EventCard(data: events[index]),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _SegmentControl({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const highlightColorStart = Color(0xFFF5F250);
    const highlightColorEnd = Color(0xFFFBFBA8);
    const unselectedColor = Color(0xFFFFFDE7);
    final tabLabelStyle = AppTextStyles.labelSmall.copyWith(
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 16,
      height: 1.2,
    );
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: unselectedColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: selectedIndex == 0
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [highlightColorStart, highlightColorEnd],
                        )
                      : null,
                  color: selectedIndex == 0 ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: selectedIndex == 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.6),
                            blurRadius: 2,
                            offset: const Offset(0, -1),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Upcoming',
                  style: tabLabelStyle,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: selectedIndex == 1
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [highlightColorStart, highlightColorEnd],
                        )
                      : null,
                  color: selectedIndex == 1 ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: selectedIndex == 1
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.6),
                            blurRadius: 2,
                            offset: const Offset(0, -1),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Past Events',
                  style: tabLabelStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTimeBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DateTimeBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.7),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: Colors.black87,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final _EventCardData data;

  const _EventCard({required this.data});

  bool get _isPastEvent => data.description.isEmpty && data.time.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _isPastEvent ? 136 : 168,
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (data.isRegistered)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFC8E6C9),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 14,
                        color: Color(0xFF2E7D32),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Registered',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFF2E7D32),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.titleMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (!_isPastEvent) ...[
                          const SizedBox(height: 3),
                          Text(
                            data.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: const Color(0xFF000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              _DateTimeBadge(
                                icon: Icons.calendar_month_outlined,
                                text: data.date,
                              ),
                              const SizedBox(width: 8),
                              _DateTimeBadge(
                                icon: Icons.schedule_outlined,
                                text: data.time,
                              ),
                            ],
                          ),
                        ] else ...[
                          const SizedBox(height: 6),
                          _DateTimeBadge(
                            icon: Icons.calendar_month_outlined,
                            text: data.date,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: _isPastEvent ? 100 : 116,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppAssetImage(
                      assetPath: data.imagePath,
                      width: _isPastEvent ? 88 : 112,
                      height: _isPastEvent ? 88 : 112,
                      fallback: Icon(
                        Icons.event_rounded,
                        size: 74,
                        color: Colors.black.withValues(alpha: 0.42),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCardData {
  final String title;
  final String description;
  final String date;
  final String time;
  final Color backgroundColor;
  final String imagePath;
  final bool isRegistered;

  const _EventCardData({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.backgroundColor,
    required this.imagePath,
    this.isRegistered = false,
  });
}
