#
# deta
#
# Copyright (c) 2011 David Persson
#
# Distributed under the terms of the MIT License.
# Redistributions of files must retain the above copyright notice.
#
# @COPYRIGHT 2011 David Persson <nperson@gmx.de>
# @LICENSE   http://www.opensource.org/licenses/mit-license.php The MIT License
# @LINK      http://github.com/davidpersson/deta
#

printf "[%5s] Module %s loaded.\n" "ok" "core"

# @FUNCTION: role
# @USAGE: [role]
# @DESCRIPTION:
# Maps an env (left) to role provided
# to this function (right). Detects role by:
# 1. Checking all available envs for a variable i.e.
#    DEV_[role]="y" will select DEV as the role.
# 2. Prompting the user to select from available env.
role() {
	local PAIR=$(set | grep -m 1 "_$1=y" );

	if [[ -n $PAIR ]];  then
		 _env_to_role ${PAIR%_*} $1
	else
		for ENV_ in $(set | grep -E "^[A-Z]+_HOST="); do
			local AVAIL+="${ENV_%_*} "
		done
		local PS3="Please select an env to map to role $1: "
		select ENV in $AVAIL; do
			_env_to_role $ENV $1
			break
		done
	fi
	printf "[%5s] Using role %s.\n" "ok" $@
}

# @FUNCTION: _env_to_role
# @USAGE: [env] [role]
# @DESCRIPTION:
# Maps all variables from env to role.
_env_to_role() {
	local IFS=$'\n'
	for C in $(set | grep -E "^$1_"); do
		eval ${C/$1_/$2_}
	done
	printf "[%5s] Mapped env %s to role %s.\n" "ok" $@
}

