part of "../view.dart";

class Event {
      final String title;

      const Event(this.title);

      @override
      String toString() => title;
    }

    /// Example events.
    ///
    /// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(2020, 10, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    DateTime.now(): [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;

  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
      return kEvents[day] ?? [];
    }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }
  
  @override
  Widget build(BuildContext context) {

     print(_focusedDay);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MQuery.height(1.5, context),
          child: Column(
            children: [
              Expanded(
                flex: 18,
                child: Header(
                  content: Column(
                    children: [
                      AppBar(
                        leadingWidth: MQuery.width(0.025, context),
                        toolbarHeight: MQuery.height(0.06, context),
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.chevron_left, size: 24),
                          onPressed: (){
                            Get.back();
                          },
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MQuery.height(0.01, context)
                        ),
                        height: MQuery.height(0.55, context),
                        width: double.infinity,
                        child: TableCalendar(
                          rowHeight: MQuery.height(0.065, context),
                          eventLoader: (day) {
                            return _getEventsForDay(day);
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          onDaySelected: _onDaySelected,
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: Font.style(color: Colors.white),
                            weekendStyle: Font.style(color: Colors.white)
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: Font.style(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                          ),
                          calendarStyle: CalendarStyle(
                            markerSize: 5,
                            markersMaxCount: 1,
                            canMarkersOverflow: false,
                            defaultTextStyle: Font.style(color: Colors.white),
                            todayTextStyle: Font.style(color: Colors.white, fontWeight: FontWeight.bold),
                            todayDecoration: BoxDecoration(shape: BoxShape.circle, color: Palette.primary),
                            selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: Palette.primary),
                            markerDecoration: BoxDecoration(shape: BoxShape.circle, color: Palette.alert),
                            weekendTextStyle: Font.style(color: Palette.alert.withOpacity(0.5), fontWeight: FontWeight.bold),
                            outsideTextStyle: Font.style(color: Colors.white.withOpacity(0.5)),
                          ),
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: Container(
                  padding: EdgeInsets.all(
                    MQuery.height(0.04, context),
                  ),
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return Column(
                        children: [
                          Center(
                            child: Font.out(
                              DateFormat("dd MMMM yyyy").format(_focusedDay),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Palette.primary
                            )
                          ),
                          SizedBox(height: MQuery.height(0.04, context)),
                          value.length > 0
                            ? Container(
                                height: MQuery.height(0.5, context),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: value.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MQuery.height(0.025, context)
                                      ),
                                      child: EventTile(
                                        callback: (){
                                          Get.to(() => EventItemPage(
                                            title: value[index].title, 
                                            speaker: "Acme",
                                            platform: "Zoom",
                                            start: DateTime.now(),
                                            end: DateTime.now(),
                                          ));
                                        },
                                        title: value[index].title,
                                        end: DateTime.now(),
                                        start: DateTime.now(),
                                      ),
                                    );
                                  },
                                ),
                              )
                          : Center(
                              child: Font.out(
                                "There are no events today",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Palette.primary
                              )
                            ),
                        ],
                      );
                    },
                  ),
                )
              ),
            ]
          )
        )
      )
    );
  }
}