Stock Screenshots
=================

In this project I have written a few scripts to automatically take
screenshots of stocks that I am interested in. The basic idea is that
I want to "push" this information to myself, rather than me having
to go out and remember to "pull" the data. So, these scripts:

* Open a list of URLs I provide
* Take screenshots of those URLs
* Combine the images into a PDF
* Display the PDF

The PDF file included in this repo gives you an idea of the end
result.

I have two main computers I use at home, and it's easy for me to run
this script on my secondary computer, which I don't use as often as
my main computer. (Both of those computers are Macs, and having a Mac
and OS X is a requirement of using these scripts.)


The main script
---------------

The main script here is named _StockScreenshots.sh_. See its source
code to see how it works.


Dependencies
------------

This code several dependencies, including:

* Having a Mac (that you won't be using while this script runs)
* Scala
* ImageMagick (which you can install with Homebrew or MacPorts)


Running the script on a schedule
--------------------------------

There are a few ways to run Mac OS X scripts on a schedule. I describe
one approach in this article:

* [Mac crontab - How to run Mac OS X jobs on a schedule](http://alvinalexander.com/mac-os-x/mac-osx-startup-crontab-launchd-jobs)


More
----

At some point I'll add more information here, and possibly a
short video to show how the script works, but for now, that's
it.


