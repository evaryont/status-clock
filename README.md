# Status Clock

This is the Status Clock, a school project to recreate the Weasley's family
clock from Harry Potter.

<iframe width="480" height="360" src="//www.youtube-nocookie.com/embed/YRWMdjvVUF4?rel=0" frameborder="0" allowfullscreen></iframe>

## Design

There are 3 major components:

- Raspberry Pi, requesting updates from the website and driving the Arduino.
- Arduino UNO, controlling the servos and LCD screens
- Website, containing all state data and configuration for a clock. Connects to
  Google+ to dynamically update a person's status based on their public
  check-ins. (*NB: During development, we originally targeted Google Latitude,
  which was sunsetted. We began migration to using Google+, but did not have
  enough time before final report.*)

### Raspberry Pi

This is also known as the "host computer" in the documentation. It's purpose is
to act as the network bridge to the Arduino. It runs a recurring task (every 15
seconds) to request the JSON output of a clock face from the website, and
communicates any changes to the Arduino over serial.

Code: **TBD**.

### Arduino UNO

Serial driver for the servos and LCDs. Takes a command from serial and either
updates the text on an LCD or moves a hand (to point at an LCD) via the servos.

Code: **TBD**.

### Website

A Rails 4 application. A user logs into it with their Google account, and
associates themselves with a clock. (Either by creating a new clock or adding
themselves to an existing one.) The clock is exported as a JSON representation
at `/clock/:id.json`, which the Raspberry Pi will grab and feed to the Arduino.

## License

Specific components of this project are licensed.

The Raspberry Pi and Arduino code is released under the MIT license. See
[LICENSE.MIT](LICENSE.MIT) for the full text of the license.

The Rails application is released under the AGPLv3. See
[LICENSE.APGL](LICENSE.APGL) for the full text of the license.

Copyright (C) 2013
- [Colin Shea](http://evaryont.me)
- [Tom Shea](http://tom.shea.at)
- David Adams
- Kasey Norman
