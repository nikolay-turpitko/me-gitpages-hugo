+++
title = "Let's Rock!"
weight = 2

+++

<https://letsrock.today>

[At the Google Play](https://play.google.com/store/apps/details?id=today.letsrock.client)

[We](https://github.com/letsrock-today) started this project along with
[colleague and a friend of mine](https://ru.linkedin.com/in/ustinovandrey) a
couple of years ago.  Our main goal was to learn Go programming language, Linux
programming environment, and all the things, required for modern web
programming, especially free and open source tools, techniques and practises -
all that stuff, which we were discouraged to use during years of the work in
the Java/enterprise environment.

This is an ongoing project, it is neither completely finished nor abandoned.
We doing it in our spare time, and it is not fully functional yet.

Sources are in the private repository. We hope to open it some day, but right
now we are ashamed to do this. I may show some parts as a code sample by request.
But the whole repository contains some sensitive parts. Though, we started to
extract authentication code from this project into open-source one, see
[authkit](../authkit).

Basically, our server uses public API of several ticket sellers (similar to
[SeatGeek](https://seatgeek.com/)) to retrieve information about entertainment
events into our database, index it and provide better search and filtering, as
well as additional features, like push notifications about new events,
conforming user-defined criteria. We also planned some social aspects, but
haven't implemented these ideas yet. Another planned, but not implemented yet
feature is to enrich information about events from the public media (Youtube,
Wikipedia, etc). So, basically, our app is an aggregator. But we trying to
provide some additional services to the end user, and not pretend to be a
reseller. We do not (and not going to) sell anything within our app, we forward
traffic back to the partner site (with referral code, of course). This model is
not going to be very lucrative, but it's OK for start.

So far we created:

- back-end server on Go,
- very basic web app (HTML5, [Riot.js](riotjs.com/)),
- more functional native Android app,
- build and deployment automation scripts for the server.

## Server

We use Go-based services (we call them "modules") behind the
[Nginx](https://nginx.org/en/) server, working in the reverse proxy mode. Each
service focused on one task, has it's own database and API.  Architecture is
not strictly "micro-service", though, because services are relatively
coarse-grained and, moreover, we allowed them to share databases in some cases.
For example, we have services which populates data into the DB, and others that
perform search and returns data to the client app via API, they necessarily
share the same databases.

We use [Redis](https://redis.io/) and [LedisDB](http://ledisdb.com/) (with
[LevelDB](http://leveldb.org/) back-end) databases, plus
[Sphinx](http://sphinxsearch.com/) search engine.  Redis we use for small
frequently used objects (because Redis stores everything in RAM), LedisDB - for
all other things (which are stored mostly on HDD, but with
[mmap](https://en.wikipedia.org/wiki/Memory-mapped_file) for faster read
access), and Sphinx stores indexes mostly. Each service has several logical
connections (we call them "data sources") to the database it needs. We are
striving to logically separate data sources, though currently they may reside
within the same DB instance, and some services may use the same logical data
source by necessity.

We think, that with the current architecture we are well prepared to scale, if
necessary. Actually, we haven't prove this in practice yet. Currently we deploy
all the components onto the single virtual host with unix-socket connections
between them. But, theoretically, we can deploy Nginx, (multiple instances of)
every service and database (cluster) onto the separate nodes, using Nginx as a
load balancer.

We performed some stress tests on our current setup and monitored CPU, RAM and
HDD consumption growth and estimated, that we can grow up to 10K simultaneous
connections with only VDS hosting tariff plan upgrades, after that we have an
option to deploy databases onto separate nodes, which can give us some time to
prepare for the farther traffic growth. Though, it's all pure theoretical,
actually we'd be quite happy to become popular enought to have a small
"slashdot effect".

We used [Gorilla toolkit](www.gorillatoolkit.org/) and [Negroni
middleware](https://github.com/urfave/negroni) to implement services.  Each
service deployed as a separate [RPM package](http://rpm.org/) (we use [CentOS
Linux](https://www.centos.org/) in production).  Currently, to simplify
deployment and version control, we use single super-package, containing only
common initialization scripts and dependencies onto other app's packages.
Though, we can deploy packages independently almost without interruption.
Services are completely stateless, behind the load balancer and we use graceful
shutdown to minimize active connections loss.

We use [systemd](https://www.freedesktop.org/wiki/Software/systemd/) to manage
our services. It capable to detect if processes are stuck or dead and restart
them automatically, if needed. We also used systemd's socket activation - mode
with which client connects to the socket, managed by systemd, so, socket would not
break if process crashed and restarted. We leveraged systemd's watchdog and
have quite a few of systemd timers.

One of the server's modules holds information about users. It also used as
a request handler of [Nginx's http auth request
module](http://nginx.org/en/docs/http/ngx_http_auth_request_module.html).  It
implements OAuth2 3-legged flow with
["golang.org/x/oauth2"](https://godoc.org/golang.org/x/oauth2).  We started to
re-write it as an open-source project (see [authkit](../authkit)).

## Build and deployment automation

We started to implement our build automation logic when
[Docker](https://www.docker.com/) was young, and [Docker
Compose](https://docs.docker.com/compose/) was to be born yet, so, we created
relatively complex make build to manage docker containers. We use docker
containers to:

- build binary files from Go sources for dev-test (and optionally execute unit
  tests and lint),
- setup dev-test environment (to perform integration tests - with databases,
  Nginx, Sphinx, etc),
- build RPMs (unit tests and lint run again as a part of this build).

After RPM files are created with docker, make executes Packer and Vagrant to
prepare fresh test environment within virtual box, in which it executes tests
of the deployment, undeployment and some integration tests. This environment
closer resembles production, and allows us to find some issues which Docker
doesn't. For example, that's how we test required permissions, selinux rules,
etc.

We also use make and bash scripts, to prepare production server and to deploy
(or update) server application into production. No Puppet or Ansible at this
point, just don't need them yet.

## Native Android app

For this project we decided to use native Android app. I have had awful
experience with HTML5 / Apache Cordova app in [Taxi project](../taxi).

In our Android application we used following libraries:

- [Android Annotations](http://androidannotations.org/),
- [Volley](https://developer.android.com/training/volley/index.html),
- [CardView and
  RecyclerView](https://developer.android.com/training/material/lists-cards.html)
  from support library,
- [FireBase](https://firebase.google.com/) for push notifications.

To support custom OAuth2 login, we implemented [Authenticator
Service](https://developer.android.com/training/id-auth/custom_auth.html) and
used WebViewClient to perform 3-legged flow (redirect user to the provider's
login page).

## Web app

There is not much to say about the web app. It is HTML5 single-page app, created
with [Riot.js](WebViewClient). We used [es6
(babel)](https://babeljs.io/docs/learn-es2015/), [npm](https://www.npmjs.com/),
[webpack](https://webpack.github.io/) and [i18next](i18next.com/).

