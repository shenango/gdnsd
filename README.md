## Setting up

- `apt install ragel libev-dev`
- `autoreconf --install`
- `./configure --with-rundir=$PWD/run  --without-urcu --prefix=$PWD/build/ --with-shenango=<shenango repo dir>`
- `make -j install`
- `mkdir -p $PWD/run/gdnsd $PWD/build/var/lib/gdnsd $PWD/build/etc/gdnsd/zones`
- `gunzip -c com.gz > $PWD/build/etc/gdnsd/zones/com`
- `build/sbin/gdnsd <shenango cfg file> -f start`


[![Build Status](https://travis-ci.org/gdnsd/gdnsd.png)](https://travis-ci.org/gdnsd/gdnsd)
[![Coverity Scan Build Status](https://scan.coverity.com/projects/760/badge.svg)](https://scan.coverity.com/projects/760)
[![Coverage Status](https://coveralls.io/repos/gdnsd/gdnsd/badge.svg?branch=master&service=github)](https://coveralls.io/github/gdnsd/gdnsd?branch=master)

## Overview

gdnsd is an Authoritative-only DNS server. The initial g stands for Geographic, as gdnsd offers a plugin system for geographic (or other sorts of) balancing, redirection, and service-state-conscious failover. The plugin system can also do things like weighted address/cname records.  If you don't care about these features you can ignore them :).

gdnsd is written in C using libev and pthreads with a focus on high performance, low latency service. It does not offer any form of caching or recursive service, and does not support DNSSEC.  There's a strong focus on making the code efficient, lean, and resilient.  The code has a decent regression testsuite with full branch coverage on the core packet parsing and generation code, and some scripted QA tools for e.g. valgrind validation, clang-analyzer, etc.

The geographically-aware features also support the emerging EDNS Client Subnet draft ( https://datatracker.ietf.org/doc/draft-vandergaast-edns-client-subnet/ , http://afasterinternet.com ) for receiving more-precise network location information from intermediate shared caches.

## Resources

Project site: http://gdnsd.org/

Release downloads: https://github.com/gdnsd/gdnsd/releases/

The code is hosted at Github: https://github.com/gdnsd/gdnsd/

Bug reports: https://github.com/gdnsd/gdnsd/issues

Wikified docs: https://github.com/gdnsd/gdnsd/wiki

Google Group for discussion: https://groups.google.com/forum/#!forum/gdnsd

See the INSTALL file for details on prerequisites and build procedure
for working from the source tree or a source tarball.

The documentation is included in the source tree in POD format
and installed as manpages and textfiles on installation.

## COPYRIGHT AND LICENSING

gdnsd is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

gdnsd is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with gdnsd.  If not, see <http://www.gnu.org/licenses/>.
