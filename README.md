# configsh

To manipulate a configuration file in INI format into a shell script (.cfg, .ini)

## Usage

> source /path/to/configsh/config.sh; parseConfig; get section key

## A simple example

**config.ini**
```ini
[main]
; comment
home=/home/foo/directory/
logfile=/home/foo/foo.log
[database]
server=my_server
db=my_database
```

**another.cfg**
```ini
[database]
foo=bar
```

**command line**
```shell
$ source config.sh; parseConfig;
$ get main home;
/home/foo/directory/
$ destroyConfig;
$
```

**shell script**
```shell
#!/bin/bash
INI="config.ini" # config.ini is set by default
source config.sh
parseConfig "$INI"  # or => parseConfig
HOME=$(get main home)
parseConfig 'another.cfg'
FOO=$(get database foo)
EMPTY=$(get database server)
destroyConfig
echo $FOO
echo $EMPTY
echo $HOME
```
```shell
bar

/home/foo/directory/
```

## Changelog

#### v0.1.0 (08/01/2016) ####
- First version


## License

Copyright (c) 2016 Rodrigue NSIANGANI

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
