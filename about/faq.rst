:allow_comments: False

.. meta::
    :keywords: FAQ

.. _doc_faq:

Frequently asked questions
==========================

What can I do with Redot? How much does it cost? What are the license terms?
----------------------------------------------------------------------------

Redot is `Free and open source Software <https://en.wikipedia.org/wiki/Free_and_open_source_software>`_
available under the `OSI-approved <https://opensource.org/licenses/MIT>`_ MIT license. This means it is
free as in "free speech" as well as in "free beer."

In short:

* You are free to download and use Redot for any purpose: personal, non-profit, commercial, or otherwise.
* You are free to modify, distribute, redistribute, and remix Godot to your heart's content, for any reason,
  both non-commercially and commercially.

All the contents of this accompanying documentation are published under the permissive Creative Commons
Attribution 3.0 (`CC BY 3.0 <https://creativecommons.org/licenses/by/3.0/>`_) license, with attribution
to "Juan Linietsky, Ariel Manzur, and the Godot and Redot Engine communities."

Logos and icons are generally under the same Creative Commons license. Note
that some third-party libraries included with Redot's source code may have
different licenses.

For full details, look at the `COPYRIGHT.txt <https://github.com/Redot-Engine/redot-engine/blob/master/COPYRIGHT.txt>`_
as well as the `LICENSE.txt <https://github.com/Redot-Engine/redot-engine/blob/master/LICENSE.txt>`_
and `LOGO_LICENSE.txt <https://github.com/Redot-Engine/redot-engine/blob/master/LOGO_LICENSE.txt>`_ files
in the Redot Engine repository.

Also, see `the license page on the Redot website <https://redotengine.org/license>`_.

Which platforms are supported by Redot?
---------------------------------------

**For the editor:**

* Windows
* macOS
* Linux, \*BSD
* Android (experimental)
* `Web <https://editor.godotengine.org/>`__ (experimental)

**For exporting your games:**

* Windows
* macOS
* Linux, \*BSD
* Android
* iOS
* Web

Both 32- and 64-bit binaries are supported where it makes sense, with 64
being the default. Official macOS builds support Apple Silicon natively as well as x86_64.

Some users also report building and using Redot successfully on ARM-based
systems with Linux, like the Raspberry Pi.

The Redot team can't provide an open source console export due to the licensing
terms imposed by console manufacturers. Regardless of the engine you use,
though, releasing games on consoles is always a lot of work. You can read more
about :ref:`doc_consoles`.

For more on this, see the sections on :ref:`exporting <toc-learn-workflow-export>`
and :ref:`compiling Redot yourself <toc-devel-compiling>`.

Which programming languages are supported in Redot?
---------------------------------------------------

The officially supported languages for Redot are GDScript, C#, and C++.
See the subcategories for each language in the :ref:`scripting <toc-learn-scripting>` section.

If you are just starting out with either Redot or game development in general,
GDScript is the recommended language to learn and use since it is native to Godot-based engines.
While scripting languages tend to be less performant than lower-level languages in
the long run, for prototyping, developing Minimum Viable Products (MVPs), and
focusing on Time-To-Market (TTM), GDScript will provide a fast, friendly, and capable
way of developing your games.

Note that C# support is still relatively new, and as such, you may encounter
some issues along the way. C# support is also currently missing on the web
platform. Our friendly and hard-working development community is always
ready to tackle new problems as they arise, but since this is an open source
project, we recommend that you first do some due diligence yourself.

As for new languages, support is possible via third parties with GDExtensions. (See the question
about plugins below). There is a non-exhaustive list of community maintained bindings on the 
`List of Features <about/list_of_features>` page of this documentation.

.. _doc_faq_what_is_gdscript:

What is GDScript and why should I use it?
-----------------------------------------

GDScript is Godot's integrated scripting language. It was built from the ground
up to maximize Godot's potential in the least amount of code, affording both novice
and expert developers alike to capitalize on Godot's strengths as fast as possible. And since 
Redot is a fork of Godot, the Redot Engine also leverages all the strengths of GDScript as well.
If you've ever written anything in a language like Python before, then you'll feel
right at home. For examples and a complete overview of the power GDScript offers
you, check out the :ref:`GDScript scripting guide <doc_gdscript>`.

There are several reasons to use GDScript, but the most salient reason is the overall
**reduction of complexity**.

The original intent of creating a tightly integrated, custom scripting language for
Godot was two-fold: first, it reduces the amount of time necessary to get up and running
with Godot, giving developers a rapid way of exposing themselves to the engine with a
focus on productivity; second, it reduces the overall burden of maintenance, attenuates
the dimensionality of issues, and allows the developers of the engine to focus on squashing
bugs and improving features related to the engine core, rather than spending a lot of time
trying to get a small set of incremental features working across a large set of languages.

Since Redot is an open source project, it was imperative from the start to prioritize a
more integrated and seamless experience over attracting additional users by supporting
more familiar programming languages, especially when supporting those more familiar
languages would result in a worse experience. We understand if you would rather use
another language in Redot (see the list of supported options above). That being said, if
you haven't given GDScript a try, try it for **three days**. Just like Redot,
once you see how powerful it is and how rapid your development becomes, we think GDScript
will grow on you.

More information about getting comfortable with GDScript or dynamically typed
languages can be found in the :ref:`doc_gdscript_more_efficiently` tutorial.

What were the motivations behind creating GDScript?
---------------------------------------------------

In the early days, the engine used the `Lua <https://www.lua.org>`_ scripting
language. Lua can be fast thanks to LuaJIT, but creating bindings to an object-oriented
system (by using fallbacks) was complex and slow and took an enormous
amount of code. After some experiments with `Python <https://www.python.org>`_,
that also proved difficult to embed.

The main reasons for creating a custom scripting language for Godot were:

1. Poor threading support in most script VMs, and Godot uses threads
   (Lua, Python, Squirrel, JavaScript, ActionScript, etc.).
2. Poor class-extending support in most script VMs, and adapting to
   the way Godot works is highly inefficient (Lua, Python, JavaScript).
3. Many existing languages have horrible interfaces for binding to C++, resulting in a
   large amount of code, bugs, bottlenecks, and general inefficiency (Lua, Python,
   Squirrel, JavaScript, etc.). We wanted to focus on a great engine, not a great number
   of integrations.
4. No native vector types (Vector3, Transform3D, etc.), resulting in highly
   reduced performance when using custom types (Lua, Python, Squirrel,
   JavaScript, ActionScript, etc.).
5. Garbage collector results in stalls or unnecessarily large memory
   usage (Lua, Python, JavaScript, ActionScript, etc.).
6. Difficulty integrating with the code editor for providing code
   completion, live editing, etc. (all of them).

GDScript was designed to curtail the issues above, and more.

What 3D model formats does the Redot Engine support?
----------------------------------------------------

You can find detailed information on supported formats, how to export them from
your 3D modeling software, and how to import them for Redot in the
:ref:`doc_importing_3d_scenes` documentation.

Will [insert closed SDK such as FMOD, GameWorks, etc.] be supported in Redot?
-----------------------------------------------------------------------------

The aim of Redot is to create a free and open source MIT-licensed engine that
is modular and extendable. There are no plans for the core engine development
community to support any third-party, closed-source/proprietary SDKs, as integrating
with these would go against Redot's ethos.

That said, because Redot is open source and modular, nothing prevents you or
anyone else interested in adding those libraries as a module and shipping your
game with them, as either open- or closed-source.

To see how support for your SDK of choice could still be provided, look at the
Plugins question below.

If you know of a third-party SDK that is not supported by Redot but that offers
free and open source integration, consider starting the integration work yourself.
Redot is not owned by one person; it belongs to the community, and it grows along
with ambitious community contributors like you.

How can I extend Redot?
-----------------------

For extending Redot, like creating Redot Editor plugins or adding support
for additional languages, take a look at :ref:`EditorPlugins <doc_making_plugins>`
and tool scripts.

Also, see the official blog post on GDExtension, a way to develop native extensions for Godot and Redot:

* `Introducing GDNative's successor, GDExtension <https://godotengine.org/article/introducing-gd-extensions>`_

You can also take a look at the GDScript implementation, the Godot and Redot modules,
as well as the `Jolt physics engine integration <https://github.com/godot-jolt/godot-jolt>`_
for Godot and Redot. This would be a good starting point to see how another
third-party library integrates with Redot.

How do I install the Redot editor on my system (for desktop integration)?
-------------------------------------------------------------------------

Since you don't need to actually install Redot on your system to run it,
this means desktop integration is not performed automatically. We are still working on getting Steam, 
Brew, Scoop, Chocolatey, Flathub, and Homebrew packages set up, much like what Godot has.

Alternatively, you can manually perform the steps that an installer would do for you:

Windows
^^^^^^^

- Move the Redot executable to a stable location (i.e. outside of your Downloads folder),
  so you don't accidentally move it and break the shortcut in the future.
- Right-click the Redot executable and choose **Create Shortcut**.
- Move the created shortcut to ``%APPDATA%\Microsoft\Windows\Start Menu\Programs``.
  This is the user-wide location for shortcuts that will appear in the Start menu.
  You can also pin Godot in the task bar by right-clicking the executable and choosing
  **Pin to Task Bar**.

macOS
^^^^^

Drag the extracted Redot application to ``/Applications/Redot.app``, then drag it
to the Dock if desired. Spotlight will be able to find Redot as long as it's in
``/Applications`` or ``~/Applications``.

Linux
^^^^^

- Move the Redot binary to a stable location (i.e. outside of your Downloads folder),
  so you don't accidentally move it and break the shortcut in the future.
- Rename and move the Redot binary to a location present in your ``PATH`` environment variable.
  This is typically ``/usr/local/bin/redot`` or ``/usr/bin/redot``.
  Doing this requires administrator privileges, but this also allows you to
  :ref:`run the Redot editor from a terminal <doc_command_line_tutorial>` by entering ``redot``.

  - If you cannot move the Redot editor binary to a protected location, you can
    keep the binary somewhere in your home directory, and modify the ``Path=``
    line in the ``.desktop`` file linked below to contain the full *absolute* path
    to the Redot binary.

- Save `this .desktop file <https://raw.githubusercontent.com/Redot-Engine/redot-engine/master/misc/dist/linux/org.redotengine.Redot.desktop>`__
  to ``$HOME/.local/share/applications/``. If you have administrator privileges,
  you can also save the ``.desktop`` file to ``/usr/local/share/applications``
  to make the shortcut available for all users.

Is the Redot editor a portable application?
-------------------------------------------

In its default configuration, Redot is *semi-portable*. Its executable can run
from any location (including non-writable locations) and never requires
administrator privileges.

However, configuration files will be written to the user-wide configuration or
data directory. This is usually a good approach, but this means configuration files
will not carry across machines if you copy the folder containing the Redot executable.
See :ref:`doc_data_paths` for more information.

If *true* portable operation is desired (e.g. for use on a USB stick),
follow the steps in :ref:`doc_data_paths_self_contained_mode`.

Why does Redot prioritize Vulkan and OpenGL over Direct3D?
----------------------------------------------------------

Redot aims for cross-platform compatibility and open standards first and
foremost. OpenGL and Vulkan are the technologies that are both open and
available on (nearly) all platforms. Thanks to this design decision, a project
developed with Redot on Windows will run out of the box on Linux, macOS, and
more.

While Vulkan and OpenGL remain our primary focus for their open standard and
cross-platform benefits, Godot 4.3 introduced experimental support for Direct3D 12.
This addition aims to enhance performance and compatibility on platforms where
Direct3D 12 is prevalent, such as Windows and Xbox. However, Vulkan and OpenGL
will continue as the default rendering backends on all platforms, including Windows.

Why does Redot aim to keep its core feature set small?
------------------------------------------------------

Redot intentionally does not include features that can be implemented by add-ons
unless they are used very often. One example of something not used often is
advanced artificial intelligence functionality.

There are several reasons for this:

- **Code maintenance and surface for bugs.** Every time we accept new code in
  the Redot repository, existing contributors often take the responsibility of
  maintaining it. Some contributors don't always stick around after getting
  their code merged, which can make it difficult for us to maintain the code in
  question. This can lead to poorly maintained features with bugs that are never
  fixed. On top of that, the "API surface" that needs to be tested and checked
  for regressions keeps increasing over time.

- **Ease of contribution.** By keeping the codebase small and tidy, it can remain
  fast and easy to compile from source. This makes it easier for new
  contributors to get started with Redot, without requiring them to purchase
  high-end hardware.

- **Keeping the binary size small for the editor.** Not everyone has a fast Internet
  connection. Ensuring that everyone can download the Redot editor, extract it
  and run it in less than 5 minutes makes Redot more accessible to developers in
  all countries.

- **Keeping the binary size small for export templates.** This directly impacts the
  size of projects exported with Redot. On mobile and web platforms, keeping
  file sizes low is important to ensure fast installation and loading on
  underpowered devices. Again, there are many countries where high-speed
  Internet is not readily available. To add to this, strict data usage caps are
  often in effect in those countries.

For all the reasons above, we have to be selective of what we can accept as core
functionality in Redot. This is why we are aiming to move some core
functionality to officially supported add-ons in future versions of Redot.
In terms of binary size, this also has the advantage of making you pay only for
what you actually use in your project. (In the meantime, you can
:ref:`compile custom export templates with unused features disabled <doc_optimizing_for_size>`
to optimize the distribution size of your project.)

How should assets be created to handle multiple resolutions and aspect ratios?
------------------------------------------------------------------------------

This question pops up often and it's probably thanks to the misunderstanding
created by Apple when they originally doubled the resolution of their devices.
It made people think that having the same assets in different resolutions was a
good idea, so many continued towards that path. That originally worked to a
point and only for Apple devices, but then several Android and Apple devices
with different resolutions and aspect ratios were created, with a very wide
range of sizes and DPIs.

The most common and proper way to achieve this is to, instead, use a single base
resolution for the game and only handle different screen aspect ratios. This is
mostly needed for 2D, as in 3D, it's just a matter of camera vertical or
horizontal FOV.

1. Choose a single base resolution for your game. Even if there are
   devices that go up to 1440p and devices that go down to 400p, regular
   hardware scaling in your device will take care of this at little or
   no performance cost. The most common choices are either near 1080p
   (1920x1080) or 720p (1280x720). Keep in mind the higher the
   resolution, the larger your assets, the more memory they will take
   and the longer the time it will take for loading.

2. Use the stretch options in Redot; canvas items stretching while keeping
   aspect ratios works best. Check the :ref:`doc_multiple_resolutions` tutorial
   on how to achieve this.

3. Determine a minimum resolution and then decide if you want your game
   to stretch vertically or horizontally for different aspect ratios, or
   if there is one aspect ratio and you want black bars to appear
   instead. This is also explained in :ref:`doc_multiple_resolutions`.

4. For user interfaces, use the :ref:`anchoring <doc_size_and_anchors>`
   to determine where controls should stay and move. If UIs are more
   complex, consider learning about Containers.

And that's it! Your game should work in multiple resolutions.

When is the next release of Redot going to be?
----------------------------------------------

When it's ready! See :ref:`doc_release_policy_when_is_next_release_out` for more
information.

Which Redot version should I use for a new project?
---------------------------------------------------

We recommend using Redot 4.x for new projects, but depending on the feature set
you need, it may be better to use Godot 3.x instead. See
:ref:`doc_release_policy_which_version_should_i_use` for more information.

Should I upgrade my project to use new Redot versions?
------------------------------------------------------

Some new versions are safer to upgrade to than others. In general, whether you
should upgrade depends on your project's circumstances. See
:ref:`doc_release_policy_should_i_upgrade_my_project` for more information.

I would like to contribute! How can I get started?
--------------------------------------------------

Awesome! As an open source project, Redot thrives off of the innovation and
the ambition of developers like you.

The best way to start contributing to Redot is by using it and reporting
any `issues <https://github.com/Redot-Engine/redot-engine/issues>`_ that you might experience.
A good bug report with clear reproduction steps helps your fellow contributors
fix bugs quickly and efficiently. You can also report issues you find in the
`online documentation <https://github.com/Redot-Engine/redot-docs/issues>`_.

If you feel ready to submit your first PR, pick any issue that resonates with you from
one of the links above and try your hand at fixing it. You will need to learn how to
compile the engine from sources, or how to build the documentation. You also need to
get familiar with Git, a version control system that the Redot developers use.

We explain how to work with the engine source, how to edit the documentation, and
what other ways to contribute are there in our :ref:`documentation for contributors <doc_ways_to_contribute>`.

I have a great idea for Redot. How can I share it?
--------------------------------------------------

We are always looking for suggestions about how to improve the engine. User feedback
is the main driving force behind our decision-making process, and limitations that
you might face while working on your project are a great data point for us when considering
engine enhancements.

If you experience a usability problem or are missing a feature in the current version of
Redot, start by discussing it with our `community <https://discord.gg/redot/>`_.
There may be other, perhaps better, ways to achieve the desired result that community members
could suggest. And you can learn if other users experience the same issue, and figure out
a good solution together.

If you come up with a well-defined idea for the engine, feel free to open a
`proposal issue <https://github.com/Redot-Engine/redot-proposals/issues>`_.
Try to be specific and concrete while describing your problem and your proposed
solution — only actionable proposals can be considered. It is not required, but
if you want to implement it yourself, that's always appreciated!

If you only have a general idea without specific details, you can open a
`proposal discussion <https://github.com/Redot-Engine/redot-proposals/discussions>`_.
These can be anything you want, and allow for a free-form discussion in search of
a solution. Once you find one, a proposal issue can be opened.

Please, read the `readme <https://github.com/Redot-Engine/redot-proposals/blob/master/README.md>`_
document before creating a proposal to learn more about the process.

.. _doc_faq_non_game_applications:

Is it possible to use Redot to create non-game applications?
------------------------------------------------------------

Yes! Redot features an extensive built-in UI system, and its small distribution
size can make it a suitable alternative to frameworks like Electron or Qt.

When creating a non-game application, make sure to enable
:ref:`low-processor mode <class_ProjectSettings_property_application/run/low_processor_mode>`
in the Project Settings to decrease CPU and GPU usage.

Check out `Material Maker <https://github.com/RodZill4/material-maker>`__ and
`Pixelorama <https://github.com/Orama-Interactive/Pixelorama>`__ for examples of
open source applications made with the Godot Engine. We hope the community will start making applications 
using the Redot engine as well!

.. _doc_faq_use_godot_as_library:

Is it possible to use Redot as a library?
-----------------------------------------

Redot is meant to be used with its editor. We recommend you give it a try, as it
will most likely save you time in the long term. There are no plans to make
Redot usable as a library, as it would make the rest of the engine more
convoluted and difficult to use for casual users.

If you want to use a rendering library, look into using an established rendering
engine instead. Keep in mind rendering engines usually have smaller communities
compared to Godot and Redot. This will make it more difficult to find answers to your
questions.

What user interface toolkit does Redot use?
-------------------------------------------

Redot does not use a standard :abbr:`GUI (Graphical User Interface)` toolkit
like GTK, Qt or wxWidgets. Instead, Redot uses its own user interface toolkit,
rendered using OpenGL ES or Vulkan. This toolkit is exposed in the form of
Control nodes, which are used to render the editor (which is written in C++).
These Control nodes can also be used in projects from any scripting language
supported by Godot and Redot.

This custom toolkit makes it possible to benefit from hardware acceleration and
have a consistent appearance across all platforms. On top of that, it doesn't
have to deal with the LGPL licensing caveats that come with GTK or Qt. Lastly,
this means Redot is "eating its own dog food" since the editor itself is one of
the most complex users of Redot's UI system.

This custom UI toolkit :ref:`can't be used as a library <doc_faq_use_godot_as_library>`,
but you can still
:ref:`use Redot to create non-game applications by using the editor <doc_faq_non_game_applications>`.

.. _doc_faq_why_scons:

Why does Redot use the SCons build system?
------------------------------------------

Redot uses the `SCons <https://www.scons.org/>`__ build system. There are no
plans to switch to a different build system in the near future. There are many
reasons why we have chosen SCons over other alternatives. For example:

-  Redot can be compiled for a dozen different platforms: all PC
   platforms, all mobile platforms, many consoles, and WebAssembly.
-  Developers often need to compile for several of the platforms **at
   the same time**, or even different targets of the same platform. They
   can't afford reconfiguring and rebuilding the project each time.
   SCons can do this with no sweat, without breaking the builds.
-  SCons will *never* break a build no matter how many changes,
   configurations, additions, removals etc.
-  Redot's build process is not simple. Several files are generated by
   code (binders), others are parsed (shaders), and others need to offer
   customization (:ref:`modules <doc_custom_modules_in_cpp>`). This requires
   complex logic which is easier to write in an actual programming language (like Python)
   rather than using a mostly macro-based language only meant for building.
-  Redot's build process makes heavy use of cross-compiling tools. Each
   platform has a specific detection process, and all these must be
   handled as specific cases with special code written for each.

Please try to keep an open mind and get at least a little familiar with SCons if
you are planning to build Redot yourself.

.. _doc_faq_why_not_stl:

Why does Redot not use STL (Standard Template Library)?
-------------------------------------------------------

Like many other libraries (Qt as an example), Redot does not make use of STL
(with a few exceptions such as threading primitives). We believe STL is a great
general-purpose library, but we had special requirements for Redot.

* STL templates create very large symbols, which results in huge debug binaries. We use few
  templates with very short names instead.
* Most of our containers cater to special needs, like Vector, which uses copy on write and we
  use to pass data around, or the RID system, which requires O(1) access time for performance.
  Likewise, our hash map implementations are designed to integrate seamlessly with internal
  engine types.
* Our containers have memory tracking built-in, which helps better track memory usage.
* For large arrays, we use pooled memory, which can be mapped to either a preallocated buffer
  or virtual memory.
* We use our custom String type, as the one provided by STL is too basic and lacks proper
  internationalization support.

Why does Redot not use exceptions?
----------------------------------

We believe games should not crash, no matter what. If an unexpected
situation happens, Redot will print an error (which can be traced even to
script), but then it will try to recover as gracefully as possible and keep
going.

Additionally, exceptions significantly increase the binary size for the
executable and result in increased compile times.

Does Redot use an ECS (Entity Component System)?
------------------------------------------------

Redot does **not** use an ECS, and relies on inheritance instead. While there
is no universally better approach, we found that using an inheritance-based approach
resulted in better usability while still being fast enough for most use cases.

That said, nothing prevents you from making use of composition in your project
by creating child Nodes with individual scripts. These nodes can then be added and
removed at run-time to dynamically add and remove behaviors.

More information about Godot's design choices can be found in
`this article <https://godotengine.org/article/why-isnt-godot-ecs-based-game-engine>`__.

Why does Redot not force users to implement DOD (Data-Oriented Design)?
-----------------------------------------------------------------------

While Redot internally attempts to use cache coherency as much as possible,
we believe users don't need to be forced to use DOD practices.

DOD is mostly a cache coherency optimization that can only provide
significant performance improvements when dealing with dozens of
thousands of objects which are processed every frame with little
modification. That is, if you are moving a few hundred sprites or enemies
per frame, DOD won't result in a meaningful improvement in performance. In
such a case, you should consider a different approach to optimization.

The vast majority of games do not need this and Redot provides handy helpers
to do the job for most cases when you do.

If a game needs to process such a large amount of objects, our recommendation
is to use C++ and GDExtensions for performance-heavy tasks and GDScript (or C#)
for the rest of the game.

How can I support Redot development or contribute?
--------------------------------------------------

See :ref:`doc_ways_to_contribute`.

Who is working on Redot? How can I contact you?
-----------------------------------------------

See the corresponding page on the `Redot website <https://redotengine.org/contact>`_.
