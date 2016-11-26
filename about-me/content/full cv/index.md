+++
description = ""

+++

# NIKOLAY TURPITKO

## Software Developer, Independent Contractor

### CONTACTS

[email me](mailto:avxbynl[at]ghecvgxb[dot]pbz) (e-mail / Google Hangouts)

[+79267904397](phone:+79267904397)

http://www.nikolay.turpitko.com


### OBJECTIVE

Golang Software Developer, Independent Contractor

### TECHNICAL SUMMARY

- Go programming language: __about 3 years__.
- HTML, CSS, JavaScript: __more than 7 years__.
- NoSQL (Redis, MongoDB): __about 1 year__.
- SQL: __more than 8 years__.
- Android: __some experience__.
- Java, JEE, J2EE: __6 years__.
- Overall experience in the software development: __more than 15 years__.
- Experience in the enterprise web-development area: __more than 10 years__.
- Misc -- Git, SVN, Ubuntu/CentOS Linux, bash, vim, tmate, make, Docker,
  Vagrant, Packer: __confident user__.

### EMPLOYMENT HISTORY

12/2014 -- Present

:   __Let's Rock Today!, Moscow/Barnaul (http://www.letsrock.today)__  
    __Co-founder, Software Developer and Architect__  
    _Hybrid (web/Android) application for search, browse and subscribe to
     entertainment events (not quite like seatgeak.com)_  
    `CentOS, RPM, SystemD, Nginx, Redis, Ledis, LevelDB, Go, Javascript,
     Java (Android), bash, Docker, Vagrant, Packer, Riot.js`

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

03/2012 -- 12/2014

:   __UBS ("Manpower CIS" contractor), Moscow (http://www.ubs.com/ru/en.html)__  
    __Senior Programmer-Analyst__  
    _Equity trading and settlement system_  
    `Java, J2EE, JEE, JDBC, SQL (RDBMS MS SQL), Apache Ant, Apache Maven,
     Apache Camel`

     Migrated equity trading and settlement application form WebLogic 8.1 to
     WebLogic 10.3. Migrated project with two dozens EJB beans from EJB 2 to
     EJB 3. Fixed several memory leaks and absence of stateful beans removal
     throughout project. Refactored about sixty timer tasks to improve code
     reuse, clarity of business logic, separation of concerns, cohesion and
     maintainability. Introduced SNMP monitoring support. Performed ongoing
     development, debugging and level 3 technical support of in-house banking
     application for investment bank UBS Russia/CIS in accordance with business
     needs. Created number of tasks with Apach Camel (as part of the migration
     of the in-house banking application to the newer platform).

09/2009 -- 03/2012

:   __Luxoft, Moscow (http://www.luxoft.com/)__  
    __Senior Java Developer__  
    _Custodian system_  
    `Java, J2EE, JEE, Java Connector Architecture, Swing, Spring Framework,
     Tibco Rendezvous (via Java API), JDBC, SQL (RDBMS MS SQL), Apache Maven,
     Apache Ant, VBA, Crystal Reports, BIRT`

    As an on-site contractor Senior Java Developer participated in the design,
    development, debugging and level 3 technical support of in-house custodian
    banking application for one of important Luxoft's client - UBS Russia/CIS.
    Worked in close collaboration with customer's development team. Implemented
    fee rules (tariff planes) for custody fee calculation. Migrated application
    from WebLogic 8.1 to WebLogic 10.3. Implemented JCA connector to Tibco
    Rendezvous for WebLogic 10.3 and API to reuse it in a Spring-based standalone
    application. Implemented number of new reports (Crystal Reports, BIRT, MS SQL
    stored procedures).

12/2008 -- 09/2009

:   __Sibirenergo-Billing, Novosibirsk (http://www.billing.sibirenergo.ru/)__  
    __Senior Web Developer__  
    _Unified Payment System_  
    `Java, Hibernate, Criteria API, Spring, web services, Axis2, J2EE, JAX-WS,
     JAXB, XML, XML DOM, XPath, JUnit 4, EasyMock`

     As a senior web and Java developer took part in the development of the
     payment system owned and supported by Sibirenergo-Billing company.
     Integrated this payment system with other external payment systems of
     several different vendors. Used custom communication protocols over HTTP
     and HTTPS, web services (SOAP), parsing and processing XML-messages with
     XPath. Developed using JAX-WS, JAXB and Apache Axis2 as JAX-WS
     implementation. Spent some time with security aspects - Spring Security
     and JAAS configurations, configured web service server and client to
     communicate with mutual SSL and pre-emptive base authentication.
     Used Java Security API to perform mutual SSL authentication and signing
     messages. Participated in the development of several back-end parts with
     Spring and Hibernate. Created and optimized SQL, HQL and Criteria API
     queries as needed. Developed complex unit and integration tests with
     JUnit 4 and EasyMock. Performed profiling, bottleneck analysis and
     optimization. Used UML modeling and reverse engineering in development
     process as necessary.

04/2008 -- 12/2008

:   __S7 IT, Novosibirsk (http://www.s7.ru/en/index.html)__  
    __Senior Java Developer__  
    _Web application for ticket agents and retailers_  
    `Java, J2EE, EJB3, JSF, Facelets, JBoss Seam, RichFaces, Ajax, Javascript,
     Prototype.js`

     Designed and developed new version of web UI for backend system used by
     ticket reseller partners of S7 airlines. Used RichFaces, Facelets and Ajax.
     Redesigned existing application to get more structured and supportable code.
     Optimized web application to increase its performance. Introduced
     validation with Ajax and Hibernate Validator. Implemented strategy of web
     application resources caching.  Introduced mechanisms of Javascript and
     CSS minifying as well as adjustable gzip-compression.

11/2006 -- 03/2008

:   __Luxoft, Moscow (http://www.luxoft.com/)__  
    __Java Developer, Senior Java Developer__  
    _Dell's global order fulfilment system_--
    `Java, J2EE, JSP, JSF, JMS, JDBC, SQL (RDBMS Oracle), XML, web services,
    Apache Axis, Apache XMLBeans, C#, ASP.NET, webMethods, Apache MyFaces,
    Apache Tobago, Apache Shale`

    Started to work in the November 2006 as Java Developer, then in the July
    2007 promoted to the Senior Java Developer. Participated in the development
    of the new versions of the large project in a global team under the Dell
    standard development process. Analyzed requirements, designed parts of
    application using UML diagrams and J2EE design patterns, implemented them
    with Java language. Made changes to the existing code, redesigned parts
    of the code, fixed defects, performed code refactoring. Implemented
    integration logic for establish communications with the newly introduced
    external systems using web services and XML parsing (Apache Axis, JMS,
    XML DOM, Apache XMLBeans). Developed new and modified legacy UI using
    JSF and JSP, created, changed and optimized SQL queries (RDBMS Oracle)
    for new functionality of the web application. Participated in the
    development and support of ASP.NET web-application with C# programming
    language. Supported application implemented with webMethods.

05/2005 -- 11/2006

:   __Applied Technologies, Chelyabinsk (http://www.appliedtech.ru/?lang=en&amp;page=home)__  
    __Java Developer__  
    _Thin client for the DB2 Query Management Facility Tool_  
    `Java, JSP, JSF, HTML, CSS, Javascript`

    Took part in the development of JSF-based web UI for existing Swing-based
    project. Developed several custom cross-browser JSF components. Prepared
    web application for the internationalization including BiDi locales support
    and layout.

06/2003 -- 04/2005

:   __Toll station, Sibirtelecom &amp; Altaytelecom, Barnaul (http://www.altai.sibirtelecom.ru/)__  
    __Engineer of electronics__  
    _Several web-applications for telephone exchange engineers_
    `C#, ASP.NET, ADO.NET, .NET Framework. HTML, DHTML, CSS, SQL (RDBMS Oracle,
    Microsoft Access), VBScript, Javascript, ASP, ADO, Microsoft IIS`

    Being the sole software developer in the department, worked as a one-man
    development team performing all parts of the development process of each
    application - from user requirements analysis through designing of data
    structure, user interface and application architecture to creating installers
    and deployment packages, data backup and recovery tools. Maintained and
    supported all created applications, fixing and modifying them as necessary
    in response to changing user requirements.

05/2000 -- 06/2003

:   __Prominform, Miass (http://www.prominform.ru/index.php?ktg=1&amp;lng=1)__  
    __Software Developer__  
    _Development software for Telephone Channel Analyzer_  
    `C++, STL, ATL, WTL, COM, OLE-automation, DirectSound, Win32 API, DDK,
    NuMega SoftIce DriverStudio, x86 Assembler, ADSP2181 Assembler,
    Atmel ST90S1200 Assembler, Microsoft Visual Studio 6`

    Developed embedded programs for telecom device using assembler languages.
    Developed (Ring 0) device drivers for Windows 98 (vxd) and NT2000 (sys)
    using C++, x86 assembler, Microsoft DDK and NuMega SoftIce DriverStudio.
    Developed dll libraries to provide API for upper-level programs. Developed
    Windows-based GUI application to work with device, which was able to display,
    play and record in real time all data gathered from analyzer (such as sound
    and signaling information from two PCM-30 trunks).

## EDUCATION

09/1994 -- 06/1999

:   __Chelyabinsk State University, Chelyabinsk (http://www.csu.ru/en)__  
    __Specialist degree ([5 years degree](https://en.wikipedia.org/wiki/Specialist_degree))__  
    _Physics, Radiophysics and electronics_  
    `Diploma number: ABC 0245806`

## CERTIFICATIONS

- [Oracle Certified Master, Java EE 5 Enterprise Architect](/cert/OCM-JEE5.pdf)
- [Sun Certified Web Component Developer for J2EE 1.4](/cert/SCWCD.pdf)
- [Sun Certified Programmer for the Java 2 Platform, Standard Edition 5.0](/cert/SCP.pdf)

## HUMAN LANGUAGES

- English: intermediate
- Russian: native speaker

## ADDITIONAL INFORMATION

- Remote positions are preferable
- Business trips are possible
- Relocation is possible
- Document change date: __11/26/2016__
