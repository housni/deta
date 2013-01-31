#
# deta
#
# Copyright (c) 2011-2012 David Persson
#
# Distributed under the terms of the MIT License.
# Redistributions of files must retain the above copyright notice.
#
# @COPYRIGHT 2011-2012 David Persson <nperson@gmx.de>
# @LICENSE   http://www.opensource.org/licenses/mit-license.php The MIT License
# @LINK      http://github.com/davidpersson/deta
#

PREFIX ?= /usr/local

install: deta.sh
	@ln -s $< $(PREFIX)/bin/$<

uninstall:
	rm $< $(PREFIX)/bin/deta.sh

.PHONY: install uninstall

