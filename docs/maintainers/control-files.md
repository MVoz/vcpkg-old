# CONTROL files

The `CONTROL` file contains metadata about the port.  The syntax is based on [the Debian `control` format][debian] although we only support the subset of fields documented here.

Field names are case-sensitive and start the line without leading whitespace.  Paragraphs are separated by one or more empty lines.

[debian]: https://www.debian.org/doc/debian-policy/ch-controlfields.html

## Source Paragraph

The first paragraph in a `CONTROL` file is the Source paragraph.  It must have a `Source`, `Version`, and `Description` field.  It can optionally have a `Build-Depends` and `Default-Features` field.

### Examples:
```no-highlight
Source: ace
Version: 6.5.5-1
Description: The ADAPTIVE Communication Environment
```

```no-highlight
Source: vtk
Version: 8.2.0-2
Description: Software system for 3D computer graphics, image processing, and visualization
Build-Depends: zlib, libpng, tiff, libxml2, jsoncpp, glew, freetype, expat, hdf5, libjpeg-turbo, proj4, lz4, libtheora, atlmfc (windows), eigen3, double-conversion, pugixml, libharu, sqlite3, netcdf-c
```


### Recognized fields

#### Source
The name of the port.

When adding new ports be aware that the name may conflict with other projects that are not a part of vcpkg.  For example `json` conflicts with too many other projects so you should add a scope to the name such as `taocpp-json` to make it unique.  Verify there are no conflicts on a search engine as well as on other package collections.

Package collections to check for conflicts:

+ [Repology](https://repology.org/projects/)
+ [Debian packages](https://www.debian.org/distrib/packages)
+ [Packages search](https://pkgs.org/)

#### Version
The port version.

This field is an alphanumeric string that may also contain `.`, `_`, or `-`. No attempt at ordering versions is made; all versions are treated as bit strings and are only evaluated for equality.

By convention, if a portfile is modified without incrementing the "upstream" version, a `-#` is appended to create a unique version string.

Some projects do not have named releases.  In these cases use the date of the version   do not have labeled releases, in these cases use the date of the last commit in `YYYY-MM-DD` format.  See the `abseil` port as an example.

Example:
```no-highlight
Version: 1.0.5-2
```
```no-highlight
Version: 2019-3-21
```

#### Description
A description of the library

By convention the first line of the description is a summary of the library.  An optional detailed description follows.  The detailed description can be multiple lines, all starting with whitespace.

Example:
```no-highlight
Description: C++ header-only JSON library
```
```no-highlight
Description: Mosquitto is an open source message broker that implements the MQ Telemetry Transport protocol versions 3.1 and 3.1.1.
  MQTT provides a lightweight method of carrying out messaging using a publish/subscribe model. This makes it suitable for "machine 
  to machine" messaging such as with low power sensors or mobile devices such as phones, embedded computers or microcontrollers like the Arduino.
````

#### Build-Depends
Comma separated list of vcpkg ports the library has a dependency on.

Vcpkg does not distinguish between build-only dependencies and runtime dependencies. The complete list of dependencies needed to successfully use the library should be specified.

*For example: websocketpp is a header only library, and thus does not require any dependencies at install time. However, downstream users need boost and openssl to make use of the library. Therefore, websocketpp lists boost and openssl as dependencies*

Example:
```no-highlight
Build-Depends: zlib, libpng, libjpeg-turbo, tiff
```
If the port is dependent on optional features of another library those can be specified using the `portname[featurelist]` syntax.

Dependencies can be filtered based on the target triplet to support different requirements on Windows Desktop versus the Universal Windows Platform. Currently, the string inside parentheses is substring-compared against the triplet name.  There must be a space between the name of the port and the filter. __This will change in a future version to not depend on the triplet name.__

Example:
```no-highlight
Build-Depends: curl[openssl] (!windows&!osx), curl[winssl] (windows), curl[darwinssl] (osx)
```

#### Default-Feature
Comma separated list of optional port features to install by default.

This field is optional.

```no-highlight
Default-Features: dynamodb, s3, kinesis
```

## Feature Paragraphs

Multiple optional features can be specified in the `CONTROL` files.  It must have a `Feature` and `Description` field.  It can optionally have a `Build-Depends` field.  It must be separated from other paragraphs by one or more empty lines.

### Example:
```no-highlight
Source: vtk
Version: 8.2.0-2
Description: Software system for 3D computer graphics, image processing, and visualization
Build-Depends: zlib, libpng, tiff, libxml2, jsoncpp, glew, freetype, expat, hdf5, libjpeg-turbo, proj4, lz4, libtheora, atlmfc (windows), eigen3, double-conversion, pugixml, libharu, sqlite3, netcdf-c

Feature: openvr
Description: OpenVR functionality for VTK
Build-Depends: sdl2, openvr

Feature: qt
Description: Qt functionality for VTK
Build-Depends: qt5

Feature: mpi
Description: MPI functionality for VTK
Build-Depends: msmpi, hdf5[parallel]

Feature: python
Description: Python functionality for VTK
Build-Depends: python3
```

### Recognized fields

#### Feature
The name of the feature.

#### Description
A description of the feature using the same syntax as the port  `Description` field.

#### Build-Depends
The list of dependencies required to build and use this feature.

On installation the dependencies from all selected features are combined to produce the full dependency list for the build. This field follows the same syntax as `Build-Depends` in the Source Paragraph.
