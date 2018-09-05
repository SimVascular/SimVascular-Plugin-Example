# SimVascular Hello World Plugin

This is a simple example of an external plugin for SimVascular

## Setup

There are two steps to start using the plugin:

* Build the plugin using CMake
* Set up environment variables so SimVascular can find and load the plugin

### Building with cmake

from this directory:
```bash
mkdir build
cd build
ccmake ..
make
```
This will compile the plugin shared library into `/build/lib/plugins`

**Note:** during the cmake configuration you will have to turn on the variable `ACCEPT_DOWNLOAD_EXTERNALS`, this allows cmake to download the external libraries SimVascular uses in order to compile the plugin.

**Note:** On certain OSes you may need to add `-fpermissive` to `CMAKE_CXX_FLAGS` and `CMAKE_C_FLAGS` during the cmake configuration step.

### Environment Setup
**Note:** on windows a `;` (semicolon) separator is used instead of `:` (colon)

To determine what plugins to load, at runtime, SimVascular will read an environment variable named `SV_CUSTOM_PLUGINS`, which is a `:` separated list of plugin names.

The name of your plugin is the shared library filename without its extension and without `lib`. E.g. if the plugin file is called `liborg_sv_gui_qt_hello.so` the plugins name is `org_sv_gui_qt_hello`.

SimVascular will also need the directory locations of all plugins. To find these it reads `SV_PLUGIN_PATHS`, which is a `:` separated list of absolute directory paths containing the plugin shared library binary files.

`SV_CUSTOM_PLUGINS` and `SV_PLUGIN_PATHS` can be defined in your environment directly (e.g. by editing your `.bashrc` file). Alternatively, at runtime, SimVascular will look for a script named `simvascular_custom_plugins.sh` in the directory `~/.local/share/SimVascular/` on unix, or `~/Library/Application\ Support/SimVascular/` on MacOS and execute it, so you can also define the environment variables there. If the script doesn't exist yet you can manually create it.

If this plugin was compile in `/home/SimVascular-Plugin-Example/build` our `simvascular_custom_plugins.sh` file would contain
```bash
export SV_CUSTOM_PLUGINS=$SV_CUSTOM_PLUGINS:org_sv_gui_qt_hello

export SV_PLUGIN_PATHS=$SV_PLUGIN_PATHS:/home/SimVascular-Plugin-Example/build/lib/plugins
```
