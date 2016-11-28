+++
title = "Let's Rock!"
weight = 1

+++

## Let's Rock!

- Web app (riot.js).
- Android app.
- Server modules (golang, sphinx, nginx).
- Build automation (make, bash, docker, vagrant, packer).


This is an ongoing project, it is neither finished nor abandoned yet.
We started this project along with my colligue about two years ago.
Because we haven't made into production yet and don't have income from it,
most of job around this project we do ourselves (actually, all the
programming work). My responsibilities here range from software developement
(backend server with Go language, frontend web application with Javascript
and Riot.js framework, Android application, bash scripting to launch build
and test environment on Docker and Vagrant), to UI/UX design to testing and
QA to project management to marketing and so on. It's difficult to say who
did what, because many decidions we make during Hangouts or phone
conversations, also we practice pair programming using tmate + vim + Hangouts
or TeamViewer + Android Studio + SIP.

Mostly main parts are:

Backend server architecture and skeleton implementation with Nginx as a
reverse proxy and a load balancer and our modules (separate linux processes)
behind it, deployed as RPM packages and managed by SystemD and interconnected
with http API over unix domain sockets (tcp with tls also supported via
configuration). Modules are implemented on Go language. Used SystemD's
socket activation, watchdog timer, graceful shutdown. Modules can be
configured to use JSON or GOB RPC or our custom RESTful-JSON API
(implemented with combination of Gorilla and Negroni).

Implementation of OAuth2 authentication of the server app via web and
Android clients. In our flow server, not client make requests to the
OAuth2 provider on behave of user, so just use any client side SDK would
not be enough. We implemented our OAuth2 module using Nginx's
ngx_http_auth_request_module feature in a plugable way, so that supporting
a new standard-compliant provider is a matter of configuration. Android
implementation uses account authenticator service and creates user account
in the system settings page similar to Google account.

Scripting (using bash) development test and release build using Docker and
Vagrant. In our build process we create banch of docker container to quick
start test environment. We start Redis, LedisDB and Nginx in separate
containers and all our module in one another container. For final build
we create dedicated docker containers to produce RPM's of our modules and
customized Nginx and LedisDB. Finally we test produced RPM's by installing
them on the VirtualBox'es guest CentOS using Vagrant and making dozens of
requests to them with curl.

Skeleton of Android application and auth implementation.
Also, I participated in the most aspects of the Android application
developement, but it mostly created during pair programming sessions,
not entirely by any one of us.

I participated in the web frontend developement as well, which is also
mainly created during pair programming sessions. We used Riot.js and
webpack for that. My solo work here is porting of golang's heap data
structure and implementation of caching fetch above it.
