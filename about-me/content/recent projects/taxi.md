+++
title = "Taxi Moment"
weight = 4

+++

## Taxi Moment (<http://taximoment.ru/>)

This was a project of my former colleague, who asked me to help him with
Android application for booking taxi cabs in Moscow.

I implemented:

- web/mobile app for booking taxi cabs,
- back-end service for this web/mobile app,
- prototype of mobile app for drivers (didn't make it into production).

### Web/Android/iOS app with Apache Cordova, jQuery and Dojo

Here is how it looks [in the browser](http://taximoment.ru/mobile/?lang=ru&theme=Custom&sprut-url=http://momenttaxi1.appspot.com)
and [at the Google Play](https://play.google.com/store/apps/details?id=ru.taximoment.cab).

We decided to implement it using relatively new (at that time) HTML5 and
[Apache Cordova](https://cordova.apache.org/).  This way we hoped to use the
same HTML and JavaScript code for web application (deployed on web site) as
well as for the Android and iOS apps.

Initially I tried to develop it as a single-page
[jQuery](http://jquerymobile.com/) app, but encountered severe performance
issues within Cordova app on all devices I used to test it at that time (an old
Motorola Android phone, presented to me by another my former colleague when he
heard that I'm going to learn mobile programming, relatively new Android
tablet, proudly made in PRC, iPhone 3, and all emulators).

So, to be able to at least test it (needless to say about customers, they,
strangely had more modern and powerful devices) I decided to switch to another,
more lightweight JavaScript framework. I evaluated several of them, popular at
that time, and chose [Dojo](https://dojotoolkit.org). It looked solid, mature,
and offered a compiler, which optimized, minified and packaged only reachable
JavaScript code (there are plenty alternatives nowadays).

Reimplemented with Dojo, application became significantly lighter, it stopped
to crash on Motorola every now and then. But I was still disappointed at Apache
Cordova performance and development clumsiness. Don't know, if it become better
since then, but I decided __never touch Apache Cordova (or similar products) again__.

It turns out, that we spent more time patching and plumbing our app, making the
same codebase to work at completely different environments, then we, probably,
would spent, developing native versions for every platform. For such a small
and simple app it does not worth it. And for bigger app, I suspect, the amount
of differences is much bigger, so plumbing will take even more efforts.

Another aspect with such approach is that from time to time you have to implement
some native code anyway. You have to create plugins. For example, when I developed
Android app for drivers, we needed it to work in background, updating driver's
GPS position at taxi operator's servers. And it was not possible without help
of native code. I created plugin for it on Java for Android. OK. But it was
broken Cordova's promise. Code base was no longer the same for different platforms,
we had to support not only "common" JavaScript code, but also native plugins.
And moreover, user experience was not the same as with native apps. I was not
to explain to every Android and iOS user why UI is so ugly and different from
native. Why, looking almost as native (but for obsolete phone versions), it
behave different in some unexpected ways.

Nevertheless, application was created, and used to work on both iOS and
Android.  We stopped to develop it due shortage of funds from business side,
but from time to time it requires maintenance (again, due Apache Cordova
security breaches and updates). Recently we decided to drop maintenance of iOS
version, just because of that. It was already expensive enough to pay for App
Developer account every year just for the one application, which does not
generate much income.  But we were not prepared to fix application after every
Apache Cordova update, which came out of our schedule, and do not welcomed by
our business customers.

Besides Apache Cordova, jQuery and Dojo, I had a somewhat bitter experience with
Google Maps and Geolocation API. It worked. We used it to show booked route on
the map, to estimate price, to self-check by user that he/she entered a correct
addresses. Most of times it worked well. But there were errors, when it found
entirely different geo-position for address, provided by user.
User was disappointed. We could do nothing, that's how Google parsed entered
address, probably, because correct address was not in database. We could not
solve this at our side. Human operator due phone call usually corrects this
issues, but blames us at the same time. Another issue with Google APIs is that
Google likes to drop it's products. We used GWT in admin's web app (it was not
created by me, but I helped to fix several issues in it). When Google dropped
GWT support and changed maps or geo API, we was in unpleasant situation.


### Server module for client auth, and update order status (Go, Google App Engine)

This part was fun. When I almost finished client app's, I needed to add simple
login into app, so that returned user could check status of his/her order(s)
and could collect bonuses for loyalty. It needed new and relatively independent
service at server side. So, I decided to implement it on Go programming language.
Just for fun and to try it in some project. We already used Java on Google App
Engine for the rest of the server app's logic. App Engine offered Java, Python
and Go. I was feed up with Java and had a taste of Python, so I decided to try Go,
and was charmed with it's simplicity, clarity and performance. I mean not
execution performance. All we know, that Java is pretty performant when it is
wormed-up. But I mean development performance in the write-compile-execute loop.
How fast it compiled and started to work. I was not able to make a cap of tee,
relax and forget what I was about to do during build, like I used to with Java.
That how I started to like Go.

For the app I implemented OAuth2 3-legged authentication (social login).
App did not have hard security requirements. It was enough to login user with
his/her social account (Facebook, Google, Twitter) and simply check next time
that it is the same user. I used "code.google.com/p/goauth2/oauth" for this (and
"github.com/mrjones/oauth" for Twitter).

As one of the options besides social login, application allows to login using
phone number and one-time generated pin code sent via SMS. I connected app to
Twillio and SMSAero providers for this task.

Main server pushed order statuses to the service, service saved them into database
and returned them on requests from client app. JSON format was used for messages,
appengine's datastore and memcache API were used for persistence.

Additionally, service provided simple address book for client's regular
destinations and made Google Geocoding API requests to parse address for 
address book. Also, it proxied some requests to 3-party API to find street names
by first letters (for suggestion box in the client's app).

Nothing fancy. It just works unattended for years.

