:allow_comments: False

.. _doc_about_intro:

Introduction
============

.. tabs::
 .. code-tab:: gdscript

    func _ready():
        print("Hello world!")

 .. code-tab:: csharp

    public override void _Ready()
    {
        GD.Print("Hello world!");
    }

Welcome to the official documentation of the **Redot Engine**, the free and open source
community-driven 2D and 3D game engine, forked from the equally awesome **Godot Engine**! Behind 
this mouthful, you will find a powerful yet user-friendly tool that you can use to develop any 
kind of game, for any platform and with no usage restriction whatsoever.

This page gives a broad overview of the engine and of this documentation,
so that you know where to start if you are a beginner or
where to look if you need information on a specific feature.

Before you start
----------------

The :ref:`Tutorials and resources <doc_community_tutorials>` page lists
video tutorials contributed by the community. If you prefer video to text,
consider checking them out. Otherwise, :ref:`Getting Started <doc_getting_started_intro>`
is a great starting point.

In case you have trouble with one of the tutorials or your project,
you can find help on the various `Community channels <https://godotengine.org/community/>`_,
especially the Redot `Discord <https://discord.gg/redot>`_.

About the Engine
----------------

A game engine is a complex tool and difficult to present in a few words.
Here's a quick synopsis, which you are free to reuse
if you need a quick write-up about the Redot Engine:

    The Redot Engine is a feature-packed, cross-platform game engine to create 2D
    and 3D games from a unified interface. It provides a comprehensive set of
    common tools, so that users can focus on making games without having to
    reinvent the wheel. Games can be exported with one click to a number of
    platforms, including the major desktop platforms (Linux, macOS, Windows),
    mobile platforms (Android, iOS), as well as Web-based platforms and consoles.

    Redot is completely free and open source under the :ref:`permissive MIT
    license <doc_complying_with_licenses>`. No strings attached, no royalties,
    nothing. Users' games are theirs, down to the last line of engine code.
    Redot's development is fully independent and community-driven, empowering
    users to help shape their engine to match their expectations.

    And since Redot is a fork of Godot, it is supported by the `Godot Foundation <https://godot.foundation/>`_
    not-for-profit indirectly. Features added to Godot will make it downstream to Redot, and hopefully
    features developed for Redot will make it upstream to Godot.


Organization of the documentation
---------------------------------

This documentation is organized into several sections:

- **About** contains this introduction as well as
  information about the engine, its history, its licensing, authors, etc. It
  also contains the :ref:`doc_faq`.
- **Getting Started** contains all necessary information on using the
  engine to make games. It starts with the :ref:`Step by step
  <toc-learn-step_by_step>` tutorial which should be the entry point for all
  new users. **This is the best place to start if you're new!**
- The **Manual** can be read or referenced as needed,
  in any order. It contains feature-specific tutorials and documentation.
- **Contributing** gives information related to contributing to
  Redot, whether to the core engine, documentation, demos or other parts.
  It describes how to report bugs, how contributor workflows are organized, etc.
  It also contains sections intended for advanced users and contributors,
  with information on compiling the engine, contributing to the editor,
  or developing C++ modules.
- **Community** contains a list of recommended third-party tutorials and materials outside of 
  this documentation. It also provides details on the Asset Library.
- Finally, the **Class reference** documents the full Redot API,
  also available directly within the engine's script editor.
  You can find information on all classes, functions, signals and so on here.

In addition to this documentation, you may also want to take a look at the
various `Godot <https://github.com/godotengine/godot-demo-projects>`_ and
`Redot <https://github.com/Redot-Engine/redot-demo-projects>`_ demo projects.

About this documentation
------------------------

Members of the Redot Engine community continuously write, correct, edit, and
improve this documentation. We are always looking for more help. You can also
contribute by opening Github issues or translating the documentation into your language.
If you are interested in helping, see :ref:`Ways to contribute <doc_ways_to_contribute>`
and :ref:`Writing documentation <doc_contributing_writing_documentation>`.

All documentation content is licensed under the permissive Creative Commons Attribution 3.0
(`CC BY 3.0 <https://creativecommons.org/licenses/by/3.0/>`_) license,
with attribution to "*Juan Linietsky, Ariel Manzur, and the Godot and Redot Engine communities*"
unless otherwise noted.

*Have fun reading and making games with the Redot Engine!*
