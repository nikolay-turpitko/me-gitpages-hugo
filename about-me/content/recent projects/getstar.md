+++
title = "GetStar"
weight = 3

+++

<http://getstar.net>

Sources are in the private repository.

This project we made in [the tight
collaboration](https://bitbucket.org/spooning/) with [my buddy (and a former
colleague of mine)](https://ru.linkedin.com/in/ustinovandrey).

Project was about creating a toolkit for near-telecom startup to analyze
telephone traffic with aim to detect suspicious activities and to alert staff
about them.

Task was somewhat experimental. Our customer required some degree of
flexibility out of the tool, because the most suitable algorithm for the task
was unknown and to be found. So, the tool should be configurable and convenient
to experiment with different algorithms and parameters. Also, it was intended
to be used in two different modes - for a research and analyzing and as an
alerting service. Customer stated that they would appreciate timely developed
and deployed tool and prefer fast, maintainable and extensible solution over GUI.

Because of that, we decided to create the set of tools in a more Unix way.  We
developed several tools for specific sub-tasks which could be combined into one
service using a bit of a Bash scripting. Tasks could be executed manually and
individually as well as in the single pipeline as a periodic service,
controlled by systemd.

In Java world we would use [Apache Camel](http://camel.apache.org/) for similar
task, but we decided, that Java is an overkill in this case. Java itself
requires regular maintenance and have too heavy system requirements.  We
decided to use Go and standard Linux tools, which adds small overhead to the
PostreSQL installed on the same virtual machine.

We created several tools which:

- download [CDR](https://en.wikipedia.org/wiki/Call_detail_record) files from
  (potentially) different sources (web/ftp),
- parse file formats of particular phone operator and load data into DB (PostgreSQL),
- process data, using configured algorithm and invokes post-processing to make
  reports, send mails about suspicious conditions or execute configured script,
- display plots for analysis in the simple web UI.

Nothing particularly fancy here. Some interesting points:

Where possible, we used existing Linux utilities, executing them from Go
program as external process, if necessary. Go program reads custom
configuration and adds custom logic to the tool. For example, we used `lftp` to
download files from ftp, `find` and `sort`  to prepare lists of files to
process, `tar` to archive, `iconv` to convert encoding, `sed` and `column` to
prepare simple reports, `mutt` to send emails, etc.

We used `yaml` configuration files and allowed putting `bash` scriptlets within
it. Tool would populate environment from configuration and current application
state and execute bash scriplets for particular sub-task. This way we allowed
system administrator to use familiar tool to extend application.  Solution is
flexible enough, it allows executing arbitrary script or program for the task.
If standard Linux utilities won't be enough, it's possible to create script on
`awk` or any scripting language, or even to execute binary program, created for
the task later. Solution is safe enough (through right file permissions and
specially created user to execute service).

We developed several simple algorithms to calculate traffic forecasts and some
more elaborated (combined from simple ones) and provided an extension point -
ability to execute external process for calculation. Several external processes
could be started to process data in parallel, each process started only once
and live till the whole calculation is done. Every process reads calculation
tasks from `stdin` and returns individual results to `stdout` (we used simple
custom binary protocol based on `msgpack`). Go program than send results via
channel to the next stage (post-processing), where individual results are
accumulated and then similar approach used to concurrently execute
post-processors (which again could be an external scripts).

We used `"go/types".Eval()` to dynamically execute conditional expressions,
which can be stored in the configuration file in Go syntax. These expressions
are evaluated over fields of report and allow filtering data for reports and 
changing of alerting conditions without re-compilation of the whole program.

We created prototype and demonstrated ability to execute more complex external
algorithms (in different execution environment), using provided extension
point. We executed
[R-SSA](https://cran.r-project.org/web/packages/Rssa/index.html) (which is
implementation of
[SSA](https://en.wikipedia.org/wiki/Singular_spectrum_analysis) algorithm,
written on R programming language) to create traffic forecasts, feed it with
data from Go program and captured results back into Go program.

It's may be interesting to note, that we achieve acceptable performance with
simple external algorithms, even written on scripting language (again, we tried
R for simple tests). With such complex algorithms as R-SSA, performance
degraded considerably.  R-SSA with large "window" ate all CPU cycles (and with
short "window" it gave unreliable predictions). Calculations could be done on
real Core i7 notebook, but were unacceptably sluggish on the provided 1-CPU
virtual machine. We stopped experiments due restrictions of time and budged.
Still, I think potentially we would squeeze more interesting results with a
proper setup (it would be interesting to execute math-expensive calculation on
the simple cluster of 3-5 dedicated R nodes, or try to develop our own SSA
implementation on compiled language). Nevertheless, I think, we gave a good
tool to the customer's engineers.  They can experiment, explore and extend it
as they need.

We used systemd to set up periodical execution of our alerting service, to 
start web service on startup and to implement error monitoring. Error monitoring
tool was a simple script, which is periodically executed by systemd. It simply
executes journalctl to find service's errors in the system journal for the last
hour, and send email, if there are such errors. Much simpler, than we used to
do it in Java.

We used `make` to build all binaries from Go sources, to prepare `man`
documentation and to prepare deployment. `go build` alone was not enough to all
these tasks. We used `pandoc` to create `man` pages from Markdown files. We used
`dh_make` and `debuild` to create Debian deployment package.

Overall, we were pleased with Go for this task (and with our collaboration with
customer, looking forward to work with them again).

