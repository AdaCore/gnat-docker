#! /bin/sh
#
# GNAT binary distribution installation script
# Copyright (c) 2003-2016, Free Software Foundation
#

####################
#                  #
# Global variables #
#                  #
####################

prefix="/usr/gnat"
if [ "$TMPDIR" = "" ]; then
  TMPDIR=/tmp
fi
tmpout="${TMPDIR}/install.log.$$"
tmpvalue="${TMPDIR}/install.$$"
doinstall_dir=`dirname $0`

#######################################
#                                     #
# Install GNAT to a standard location #
#                                     #
#######################################

standard_installation () {

   # Makes the real installation
   touch "$tmpout" &&
     (make ins-all prefix="$prefix" 2>&1; echo $? > "$tmpvalue" ) | tee "$tmpout"

   # Check that installation was OK

   error_exit=false

   if [ ! -f "$tmpout" ]; then
      error_exit=true
      cat << EOF


   An error occurred during installation. The installation log file,
   $tmpout, could not be written.
EOF

   elif [ ! -f "$tmpvalue" -o `cat "$tmpvalue"` -ne 0 ]; then
      error_exit=true
      cat << EOF


   An error occurred during installation. You can find a complete log
   of the installation in $tmpout.
EOF
   fi

   rm -f "$tmpvalue"
}

######################
#                    #
# Start installation #
#                    #
######################

# This avoids some problems when cd prints the new directory when CDPATH
# is defined
unset CDPATH

# Do the real installation
cd $doinstall_dir && standard_installation
