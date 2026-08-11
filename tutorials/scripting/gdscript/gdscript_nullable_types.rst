.. _doc_gdscript_nullable_types:

Nullable static types
=====================

This guide builds on :ref:`doc_gdscript_static_typing`. In statically-typed
GDScript, a value is **non-nullable** by default: the type system flags ``null``
as an illegal value for it. Writing a ``?`` after a type hint makes the value
**nullable**, opting it back into holding ``null``::

    var health: int?          # May be an int or null; starts as null.
    var player_name: String? = null

This is purely a static typing feature. It does not change how values are stored
at runtime — ``null`` is still ``Nil``. It changes what the analyzer allows and
what the virtual machine enforces.

.. note::

    How strictly "non-nullable" is enforced depends on the type. Built-in value
    types (``int``, ``String``, ``Array``, and so on) are checked both when used
    directly and at runtime. Enums are checked on transfer and at runtime. Object
    references (``Node``, ``RefCounted``, script classes) keep GDScript's existing
    behavior and may hold ``null`` regardless of the ``?``. See
    `Notes on objects and enums`_ below for the details.

Syntax
------

The ``?`` suffix is allowed anywhere a type hint is allowed: member variables,
local variables, function parameters, and return types::

    var member: int?

    func f(v: int?) -> int?:
        var local: Vector2? = null
        return null

An uninitialized nullable variable defaults to ``null``, whereas a non-nullable
``int`` would default to ``0``::

    var x: int?
    print(x)  # <null>

Compatible types
----------------

The ``?`` suffix works on nearly every type you can write as a hint:

+-----------------------+--------------------------------------------------------------------------------------------+
| Category              | Examples                                                                                   |
+=======================+============================================================================================+
| Built-in value types  | ``int?``, ``float?``, ``bool?``, ``String?``, ``StringName?``, ``Vector2?``, ``Color?``, … |
+-----------------------+--------------------------------------------------------------------------------------------+
| Enums                 | ``State?`` (script enums), ``Vector2.Axis?``, ``Variant.Type?`` (native and nested enums)  |
+-----------------------+--------------------------------------------------------------------------------------------+
| Objects               | ``Node?``, ``RefCounted?``, and script classes such as ``MyClass?``                        |
+-----------------------+--------------------------------------------------------------------------------------------+
| Collections           | ``Array?``, ``Dictionary?``                                                                |
+-----------------------+--------------------------------------------------------------------------------------------+
| Typed collections     | ``Array[int]?``, ``Dictionary[String, int]?`` — the *collection* is nullable               |
+-----------------------+--------------------------------------------------------------------------------------------+

The following forms are rejected because they are redundant or ambiguous:

- ``Variant?`` — :ref:`Variant <class_Variant>` already includes ``null``, so the
  suffix is redundant and raises an error.
- ``void?`` — a function cannot return "maybe nothing"; this is a parser error.
- **Nullable element types**, such as ``Array[int?]`` or
  ``Dictionary[String, int?]`` — only the container itself can be made nullable,
  not its elements. Use ``Array[int]?`` (a nullable array of ints) instead.

Null-narrowing
--------------

After you check a nullable value against ``null``, the analyzer *narrows* it to
its non-nullable type for the rest of the safe region, so you can use it without
a warning::

    func guard(v: int?) -> int:
        if v == null:
            return -1
        return v          # Here v is known to be non-null (int).

    func branch(v: int?) -> int:
        if v != null:
            return v + 1  # Narrowed inside the block.
        return 0

Narrowing is recognized for:

- **Early-return / early-exit guards:** ``if v == null: return``, then use ``v``
  afterwards.
- **Positive blocks:** the body of ``if v != null:``.
- **else branches:** the ``else`` of an ``if v == null:`` guard.
- **while conditions:** the body of ``while v != null:``.
- **Boolean and:** ``v != null and v > 5`` — the right-hand side sees ``v`` as
  non-null.
- **or guards:** ``if a == null or b == null: return`` narrows both ``a`` and
  ``b`` after the guard.
- **Reassignment with a non-null value** keeps the value narrowed::

      if v != null:
          v = v + 1       # Still non-null.
          return v

Narrowing is intentionally conservative. In the following cases the value stays
nullable and still produces the ``UNSAFE_NULLABLE_ACCESS`` warning:

- **Reassignment from a nullable source** re-widens the value; check it again::

      if v != null:
          v = get_nullable()  # v is nullable again.
          return v + 1        # Warns.

- **break / continue guards** are not treated as narrowing::

      while true:
          if v == null:
              break
          return v + 1        # Warns — break guard is not narrowed.

- **Non-definite guards** (a guard that does not unconditionally exit)::

      if x == null:
          if cond:
              return -1
      return x + 1            # Warns — the guard might fall through.

- Combinations that do not actually prove non-null, such as
  ``a == null and b == null`` or ``a != null or b != null``, do not narrow ``a``
  in the branch.

The UNSAFE_NULLABLE_ACCESS warning
----------------------------------

The analyzer emits ``UNSAFE_NULLABLE_ACCESS`` in two situations.

First, when a nullable **built-in value** (``int?``, ``String?``, ``Vector2?``,
``Array?``, and so on) is used directly — in an operator, a subscript or property
access, or a ``for`` loop — without first narrowing it::

    var v: Vector2? = Vector2(3, 4)
    print(v.x)  # Warns: the value of type "Vector2?" may be null.

Second, when a nullable value of **any** type is transferred to a non-nullable
target: assigned to it, returned as it, or passed as an argument::

    var a: int? = 5
    var b: int = a  # Warns: assigning nullable to non-nullable.
    takes_int(a)    # Warns: nullable argument to non-nullable parameter.

The direct-use check only applies to built-in value types. Nullable enums and
nullable object references are covered by the transfer check but not the
direct-use one — see `Notes on objects and enums`_ below.

The severity is configured by the
:ref:`debug/gdscript/warnings/unsafe_nullable_access<class_ProjectSettings_property_debug/gdscript/warnings/unsafe_nullable_access>`
project setting (default: warn). Set it to ``error`` to make unsafe nullable
access a hard compile error, or ``ignore`` to silence it. As with any GDScript
warning, you can suppress a single site with
``@warning_ignore("unsafe_nullable_access")``. See :ref:`doc_gdscript_warning_system`
for details on the warning system.

Runtime enforcement
-------------------

The warning is a static hint; for built-in value types and enums the runtime
independently rejects ``null`` reaching a non-nullable slot. Even if you ignore
the warning, the following fail at runtime::

    func bad(v: int?) -> int:
        return v            # If v is null: runtime error.

    func use() -> void:
        var value: int? = get_nullable()
        print(value + 1)    # If null: "Invalid operands 'Nil' and 'int'".

Typical runtime messages are:

- ``Trying to return value of type "Nil" from a function whose return type is "int".``
- ``Invalid operands 'Nil' and 'int' in operator '+'.``

Typed containers keep their own element checks. Returning a wrongly-typed array
from ``-> Array[int]?`` still errors with ``Trying to return an array of type
"Array" where expected return type is "Array[int]"``.

Notes on objects and enums
--------------------------

Object references (``Node``, ``RefCounted``, script classes) keep GDScript's
existing nullability. Unlike built-in value types, an object type accepts ``null``
at runtime whether or not it is marked with ``?``, so a null object reaching a
non-nullable object type is **not** a runtime error.

What ``?`` adds for objects is static tracking. ``Node?`` participates in
null-narrowing and raises ``UNSAFE_NULLABLE_ACCESS`` when the value is transferred
to a non-nullable target (assigned, returned, or passed as an argument). Accessing
a member or calling a method directly on a nullable object does *not* currently
raise the warning; only built-in value types are checked for direct use.

Nullable enums behave the same way for direct use: an operator or subscript on a
nullable enum is not flagged, but transferring it to a non-nullable enum warns,
and — because enums are backed by integers — reaching a non-nullable enum with
``null`` fails at runtime.

Freed objects keep GDScript's existing semantics. After ``node.free()``, comparing
``node == null`` returns ``true``, while ``is_instance_valid(node)`` returns
``false`` — the reference still points at the freed instance but compares equal to
``null``.
