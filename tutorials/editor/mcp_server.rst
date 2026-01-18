.. _doc_mcp_server:

AI Integration (Model Context Protocol)
=======================================

Redot includes a native **MCP (Model Context Protocol)** server, allowing AI coding assistants (like OpenCode, Claude Desktop, Cursor, or Zed) to interact directly with your game project.

This integration provides AI agents with "eyes and hands" inside the engine, enabling them to:

*   **See** the game running via screenshot capture.
*   **Inspect** the live scene tree and project resources.
*   **Edit** scenes and resources safely using high-level tools.
*   **Play** the game by injecting native input events.

Enabling the Server
-------------------

The MCP server is built into the standard Redot editor binary but runs in a headless mode. To start it, launch the engine with the ``--mcp-server`` flag.

.. code-block:: shell

    ./redot --headless --mcp-server --path /path/to/your/project

Configuration
-------------

Most AI clients require a configuration file to know how to launch the MCP server.

Using standard binary
~~~~~~~~~~~~~~~~~~~~~

If you have downloaded a standard binary (e.g., from the Redot website):

.. code-block:: json

    {
      "mcpServers": {
        "redot": {
          "command": "/path/to/redot.linuxbsd.editor.x86_64",
          "args": [
            "--headless",
            "--mcp-server",
            "--path",
            "/absolute/path/to/your/project"
          ],
          "enabled": true
        }
      }
    }

Using Nix
~~~~~~~~~

If you are developing inside a Nix environment, use the provided wrapper script ``redot-mcp.sh`` (located at the root of the engine repository) to ensure all libraries are correctly linked.

.. code-block:: json

    {
      "mcpServers": {
        "redot": {
          "command": "/path/to/redot-engine/redot-mcp.sh",
          "args": [
            "/absolute/path/to/your/project"
          ],
          "enabled": true
        }
      }
    }

Tools Reference
---------------

The MCP server exposes 5 master controllers, designed to give AI agents comprehensive control over the engine:

**1. redot_scene_action**
    Manage ``.tscn`` files. This tool is preferred over raw text editing for scenes as it maintains internal integrity.
    
    *   **Actions**: ``add``, ``remove``, ``set_prop``, ``instance``, ``reparent``.
    *   **Features**: Can wire signals using ``connect``, which automatically generates the corresponding callback method in the target GDScript.

**2. redot_resource_action**
    Manage ``.tres`` files and assets.
    
    *   **Actions**: ``create``, ``modify``, ``inspect``, ``duplicate``.
    *   **Features**: Useful for tweaking materials, creating themes, or inspecting ``.import`` metadata.

**3. redot_code_intel**
    Deep script analysis and documentation lookup.
    
    *   **Actions**: ``get_symbols`` (extracts functions/variables via AST), ``validate`` (syntax check), ``get_docs`` (engine API reference).

**4. redot_project_config**
    Project-level control and file I/O.
    
    *   **Actions**: ``run``/``stop`` (game lifecycle), ``output`` (read logs), ``list_files``, ``create_file_res``.
    *   **Features**: Can configure the Input Map and Autoloads.

**5. redot_game_control**
    Vision & Interaction suite. Requires the game to be running (via ``project_config:run``).
    
    *   **Actions**:
        *   ``capture``: Take a screenshot of the game viewport.
        *   ``click``: Click UI elements (supports node paths or coordinates).
        *   ``type``: Simulate keyboard input (supports special keys like ``[ESCAPE]``).
        *   ``inspect_live``: Dump the runtime scene tree recursively to find node paths and screen coordinates.

Best Practices for Agents
-------------------------

To ensure stability and precision, AI agents should follow these guidelines:

1.  **Scene Editing**: Always use ``redot_scene_action`` for ``.tscn`` modifications. Avoid editing scene files as raw text.
2.  **Script Editing**: For existing ``.gd`` scripts, use **native text editing tools** (like ``edit`` or ``sed``) rather than MCP tools. The MCP ``create_file_res`` action is restricted to creating *new* files to prevent accidental overwrites of complex logic.
3.  **Live Interaction**: After calling ``run``, always ``wait`` 3-5 seconds before attempting vision or input actions to allow the game process and MCP bridge to initialize.
4.  **Spatial Awareness**: Use ``redot_game_control(action="inspect_live", recursive=true)`` to discover UI node paths. The tool returns pre-calculated screen coordinates, ensuring 100% accurate clicking even in complex layouts.
5.  **Debugging**: Use ``redot_project_config(action="output")`` to read real-time game logs and ``redot_code_intel(action="validate")`` to syntax-check fixes before running the game.

Verification
------------

The engine repository includes a Python script to verify the MCP workflow end-to-end. You can use it to confirm your setup is correct:

.. code-block:: bash

    python3 modules/mcp/tests/verify_workflow.py \
      --binary ./bin/redot.linuxbsd.editor.x86_64 \
      --project /path/to/your/project
