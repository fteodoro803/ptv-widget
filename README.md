# PTV Widget
This application gives users features for easy access to information on PTV. 

The functionality here is a template, which should be converted to the programming language of whichever Operating System contains the widget.

### Setup
For the program to work, paste your User/Developer ID and API Key in the *config.ini* file. 

### Dependencies
- python 3.10
- requests 2.31.0
- pytest 8.1.1

### Notes
- Changes to config.ini __*must*__ not be pushed
- Time from Departures API is in UTC, so it has to be converted to the timezone of the user's device
  - Case: if user's device's time is incorrect
    - match it to the user's device and not actual time;
    - show how many minutes until it arrives, and maybe the time as a subtext (the correct time)
- Flow:
  - Select location
  - Get stops (and transport options) from a Location
    - Select Stop (stop contains tram numbers, name)
  - Choose Direction of Travel
  - Final Selection
- How to:
  - use _stops_ to get the tram name and number (route_id)
  - use _departure_ to show direction
    - direction is matched with route ids from _stops_ via _directions_
- LucidChart:
  - https://lucid.app/lucidchart/82b010cd-4cd5-42c0-8c19-f3066488b55a/edit?viewport_loc=-1937%2C-126%2C4157%2C2105%2C0_0&invitationId=inv_6c5333c9-7546-45d1-8473-e3fdb2c4135c

### To-Do
- Priority: 
  - Trams based on Location, and Direction
  - Selecting 1 form of PTV and getting information on that to Widget:
    1. Big Widget (saving a stop)
       1. ![tram_sample_screen.jpg](images%2Ftram_sample_screen.jpg)
    2. Small Widget (saving a tram)
       1. just one of the above
- Continuous Integration and Development
  - Github Actions
  - https://www.youtube.com/watch?v=scEDHsr3APg
- PTV Colour Palette
  - https://www.righttoknow.org.au/request/5149/response/13973/attach/4/PTVH2977%20MSG%202018%202.4%20Colour%20v10%20PA%20v2.pdf
- PTV Icons
  - https://melbournesptgallery.weebly.com/melbourne-tram-sides.html
- Figure out Disruption and their IDs
  - Particularly in Disruptions
- Calendar Integration
  - ex: I want to take a tram to get to X Location, to arrive at Y time. Add a Notification/Calendar Alert for when they should leave
- API Calls / Data Collection
  - Stops within Distance --> route (id, name, number, type)
    - Get unique PTV Numbers (Tram Numbers, Train, Etc)
  - If I do multiple calls, such as looping to get directions for each Tram Route, does that count as spamming the API? Any way I can minimise calls?
    - Maybe I can create a little text file storing directions for routes, like a cache
- Ideas
  - For direction, maybe something like "Flinders -> North Coburg"
  - Notification for Disruptions?
    - A way of notifying that a Tram is going to the depot/stops early
    - Cancellation?

### Testing
- PyTest
- apiTests.py
  - Can't really do tests on valid/invalid URLS, since that's done by the API, but include these responses as tests maybe???
  - Maybe some tests for, if the site is down or something
