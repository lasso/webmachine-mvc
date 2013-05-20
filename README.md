# webmachine-mvc

This is webmachine-mvc, a shiny, glittering disco ball of delicious MVC magic
sprinkled over Sean Cribb's excellent
[webmachine-ruby](https://github.com/seancribbs/webmachine-ruby) library.

## Why?

This project is all fun and games and not for profit. I just needed a break from
coding stuff in [Ramaze](http://ramaze.net/) and webmachine looked interesting.
However, after playing a few hours with webmachine I started to miss certain
things from ramaze, so I started thinking about how to make things work in a
more familiar way. Thus, webmachine-mvc was born!

Even though webmachine is awesome, there are a few things that I think would be
useful to add for the average web developer:

* Simpler management of resourses

  Webmachine usually uses a whole class just for handling a single URL. This
  gives a lot of flexibility, but in many cases it is pretty overkill as most
  pages just display some HTML. In webmachine-mvc, many URLs can be managed by
  a single controller.

* Better living through templating

  Webmachine does not help you with templating but does not get in your way if
  you want to use them either. For me, most URLs display some readable content
  so I think it is important to make templating more easily available in
  webmachine. In webmachine-mvc, the templating is provided by
  [tilt](https://github.com/rtomayko/tilt), making it easy to use your favorite
  templating engine.

* Models

  Oh, I love them so much! Who ever uses SQL when there are beautiful libraries
  like [sequel](http://sequel.rubyforge.org/) and
  [datamapper](http://datamapper.org/) that makes the hardest quadruple join a
  breeze? (I know some people prefer performance over simplicity, but not me.)

  Webmachine-mvc does not have its own models yet, but when they arrive
  (if ever) they will probably be based on Sequel::Model. I'm actually quite
  fond of how Ramaze handles models (by mostly ignoring them) so I have not
  really decided on how to implement this part yet.

## Does it work?

Are you kidding me? This doc probably took longer to write than it took to
write the entire code base (so far). This is *not* production code and will
probably crash and burn within seconds. I have started writing some tests and
when they start to pass things will probably be somewhat more stable. The
only thing that *probably* works right now is the controller initialization
and the templating,

## When will webmachine-mvc be ready for production?

It won't. Like I said in the beginning, this is just a toy. It will eventually
be made into a gem, but that might take a few weeks before I get that far.

## I wanna write stupid code too (ie how to contribute)!

Since I don't have any grand plans for the project I will probably just hack on
it occasionally on my precious spare time. If you feel you want to contribute,
you are welcome to send me a pull request. I will probably accept anything as
long as it adds something useful.

If you want to use *any* part of the code in your own project you are very much
welcome to do so provided that you follow the licence of the code. All
code in the project is licenced under the GNU General Public Licence (version 3
or later). If you don't know about the GNU GPL, you should probably go and read
the file COPYING now.

Over and out -- *lasso*