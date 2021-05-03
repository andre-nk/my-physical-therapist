part of "../view.dart";

class Event {
  final String title;
  final String media;
  final String speaker;
  final String description;
  final DateTime start;
  final DateTime end;
  const Event({
    required this.title,
    required this.media,
    required this.speaker,
    required this.description,
    required this.start,
    required this.end
  });
}

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final eventProvider = watch(eventListProvider);

        List<Event> kEvent = [];
        late final ValueNotifier<List<Event>> _selectedEvents;
        
        eventProvider.whenData((value){
          value.forEach((element) {
            kEvent.add(Event(
              title: element.title,
              start: element.start,
              end: element.end,
              speaker: element.speaker,
              description: element.description,
              media: element.media
            ));
          });
        });

        List<Event> _getEventsForDay(DateTime day) {
          List<Event> out = [];

          kEvent.forEach((element) {
            if(element.start.toString().substring(0, 10) == day.toString().substring(0,10)){
              out.add(element);
            }
          });

          return out;
        }

        _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));

        print(_focusedDay);

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MQuery.height(1.5, context),
              child: Column(children: [
                Expanded(
                  flex: 18,
                  child: Header(
                    content: Column(
                      children: [
                        AppBar(
                            leadingWidth: MQuery.width(0.025, context),
                            toolbarHeight: MQuery.height(0.06, context),
                            leading: IconButton(
                              icon:
                                  Icon(CupertinoIcons.chevron_left, size: 24),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                        Container(
                          padding: EdgeInsets.only(
                              top: MQuery.height(0.01, context)),
                          height: MQuery.height(0.55, context),
                          width: double.infinity,
                          child: TableCalendar(
                            rowHeight: MQuery.height(0.065, context),
                            eventLoader: (day) {
                              return _getEventsForDay(day);
                            },
                            selectedDayPredicate: (day) {
                              return isSameDay(_focusedDay, day);
                            },
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            onDaySelected: (a, b){
                              if(isSameDay(_focusedDay, a) == false){
                                setState(() {
                                  _focusedDay = a;                                  
                                });
                                _selectedEvents.value = _getEventsForDay(a);
                              }
                            },
                            daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: Font.style(color: Colors.white),
                                weekendStyle:
                                    Font.style(color: Colors.white)),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: Font.style(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              rightChevronIcon: Icon(Icons.chevron_right,
                                  color: Colors.white),
                              leftChevronIcon: Icon(Icons.chevron_left,
                                  color: Colors.white),
                            ),
                            calendarStyle: CalendarStyle(
                              markerSize: 5,
                              markersMaxCount: 1,
                              canMarkersOverflow: false,
                              defaultTextStyle:
                                  Font.style(color: Colors.white),
                              todayTextStyle: Font.style(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              todayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.secondaryBorder),
                              selectedDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.primary),
                              markerDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.alert),
                              weekendTextStyle: Font.style(
                                  color: Palette.alert.withOpacity(0.5),
                                  fontWeight: FontWeight.bold),
                              outsideTextStyle: Font.style(
                                  color: Colors.white.withOpacity(0.5)),
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
                                      DateFormat("dd MMMM yyyy")
                                          .format(_focusedDay),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.primary)),
                              SizedBox(height: MQuery.height(0.01, context)),
                              value.length > 0
                                  ? Container(
                                      height: MQuery.height(0.5, context),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: value.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MQuery.height(
                                                    0.025, context)),
                                            child: EventTile(
                                              callback: () {
                                                Get.to(() => EventItemPage(
                                                  title: value[index].title,
                                                  speaker: value[index].speaker,
                                                  platform: value[index].media,
                                                  end: value[index].end,
                                                  start: value[index].start,
                                                  description: value[index].description,
                                                ));
                                              },
                                              title: value[index].title,
                                              end: value[index].end,
                                              start: value[index].start,
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
                                          color: Palette.primary)),
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
    );
  }
}
