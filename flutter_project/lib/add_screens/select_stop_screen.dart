import 'package:flutter/material.dart';
import 'package:flutter_project/dev/dev_tools.dart';
import 'package:flutter_project/screen_arguments.dart';
import 'package:flutter_project/ptv_api_service.dart';
import 'package:flutter_project/ptv_info_classes/stop_info.dart';
import 'package:flutter_project/ptv_info_classes/route_info.dart'
    as PTRoute; // to avoid conflict with material's "Route"

class SelectStopScreen extends StatefulWidget {
  const SelectStopScreen({super.key, required this.arguments});

  // Stores user Transport details
  final ScreenArguments arguments;

  @override
  State<SelectStopScreen> createState() => _SelectStopScreenState();
}

class _SelectStopScreenState extends State<SelectStopScreen> {
  String _screenName = "SelectStop";
  List<Stop> _stops = [];
  List<PTRoute.Route> _routes = [];
  DevTools tools = DevTools();

  // Initialising State
  @override
  void initState() {
    super.initState();
    fetchStops();

    // Debug Printing
    tools.printScreenState(_screenName, widget.arguments);
  }

  // Fetch Stops            -- do tests to see if not null
  Future<void> fetchStops() async {
    String? location = widget.arguments.transport.location?.location;
    String? routeType = widget.arguments.transport.routeType?.type;

    // Fetching Data and converting to JSON
    Data data = await PtvApiService().stops(location!, routeTypes: routeType);
    Map<String, dynamic>? jsonResponse = data.response;

    // Early Exit
    if (data.response == null) {
      print("NULL DATA RESPONSE --> Improper Location Data");
      return;
    }

    // Populating Stops List
    for (var stop in jsonResponse!["stops"]) {
      for (var route in stop["routes"]) {
        if (route["route_type"].toString() !=
            widget.arguments.transport.routeType!.type) {
          continue;
        }

        String stopId = stop["stop_id"].toString();
        String stopName = stop["stop_name"];
        Stop newStop = Stop(id: stopId, name: stopName);

        String routeName = route["route_name"];
        String routeNumber = route["route_number"].toString();
        String routeId = route["route_id"].toString();
        PTRoute.Route newRoute =
            PTRoute.Route(name: routeName, number: routeNumber, id: routeId);

        _stops.add(newStop);
        _routes.add(newRoute);
      }
    }

    setState(() {});
  }

  void setStopAndRoute(index) {
    widget.arguments.transport.stop = _stops[index];
    widget.arguments.transport.route = _routes[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Stop:"),
        centerTitle: true,
      ),

      // Generates List of Stops
      body: ListView.builder(
        // old
        itemCount: _stops.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${_stops[index].name}: (${_routes[index].number})"),
            subtitle: Text(_routes[index].name),
            onTap: () {
              setStopAndRoute(index);
              Navigator.pushNamed(context, '/selectDirectionScreen',
                  arguments: ScreenArguments(widget.arguments.transport));
            },
          );
        },
      ),
    );
  }
}
