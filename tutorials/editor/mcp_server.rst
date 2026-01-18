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

The MCP server is built into the standard Redot editor binary but runs in a headless mode. To start it manually (for testing), launch the engine with the ``--mcp-server`` flag.

.. code-block:: shell

    ./redot --headless --mcp-server --path /path/to/your/project

Step-by-Step Setup Guide
------------------------

.. note::

    If you installed Redot via a package manager (like Flatpak, Snap, or your distribution's repo), you might not know the exact binary path. Run ``which redot`` in your terminal to find it. Use that path in the configurations below.

To use Redot with your AI coding assistant, you need to register the MCP server in your editor's configuration.

OpenCode
~~~~~~~~

1.  Navigate to your project root directory.
2.  Create a folder named ``.opencode`` and inside it, create a file named ``opencode.json`` with the following configuration:

.. code-block:: json

    {
      "mcp": {
        "redot": {
          "type": "local",
          "command": [
            "/absolute/path/to/redot.linuxbsd.editor.x86_64",
            "--headless",
            "--mcp-server",
            "--path",
            "/absolute/path/to/your/project"
          ],
          "enabled": true
        }
      }
    }

3.  Open the folder in **OpenCode**. The editor will detect the configuration and start the MCP server automatically.

Claude Code (CLI)
~~~~~~~~~~~~~~~~~

To add Redot as a project-scoped tool for Claude Code, run the following command in your terminal from your project root:

.. code-block:: shell

    claude mcp add --transport stdio --scope project redot -- /absolute/path/to/redot --headless --mcp-server --path /absolute/path/to/your/project

This command creates a ``.mcp.json`` file in your project directory.

Cursor
~~~~~~

1.  Navigate to your project root directory.
2.  Create a file named ``mcp.json`` with the following configuration:

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

3.  Restart Cursor or reload the window. The MCP server will start automatically.

Junie (JetBrains)
~~~~~~~~~~~~~~~~~

1.  In your JetBrains IDE settings (**Ctrl+Alt+S**), go to **Tools** > **Junie** > **MCP Settings**.
2.  Click the **Add** button on the toolbar (or the link to edit configuration). This opens the ``mcp.json`` file.
3.  Add the Redot server configuration under the ``mcpServers`` key:

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

4.  Save the file. Junie will reload the configuration and start the server.

Example Prompts
---------------

Once connected, you can ask your AI assistant to perform complex tasks. Here are a few examples of what it can do:

**1. Scene Construction**
    *"Create a new main menu scene with a 'Start Game' button and a 'Settings' button. Save it as `res://scenes/MainMenu.tscn`."*
    
    *   **Action**: The AI uses ``redot_scene_action`` to create the scene, add ``Button`` nodes, and save the file.

**2. Gameplay Testing**
    *"Launch the game, wait for it to load, then find and click the 'Start Game' button."*
    
    *   **Action**: The AI uses ``redot_project_config:run``, then ``redot_game_control:inspect_live`` to find the button's coordinates, and finally ``redot_game_control:click`` to press it.

**3. Script Analysis**
    *"Check `Player.gd` for any syntax errors and explain what the `_physics_process` function does."*
    
    *   **Action**: The AI uses ``redot_code_intel:validate`` to check syntax and ``redot_code_intel:get_symbols`` to analyze the code structure.

Configuration Reference
-----------------------

For standard usage, use the configuration below.

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

For Engine Contributors
-----------------------

If you are compiling Redot from source (e.g., using Nix), you need a slightly different setup to ensure libraries are linked correctly.

Using Nix (Development)
~~~~~~~~~~~~~~~~~~~~~~~

If you are developing inside a Nix environment, use the provided wrapper script ``redot-mcp.sh`` (located at the root of the engine repository).

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
