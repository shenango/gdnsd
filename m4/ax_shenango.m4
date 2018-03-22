AC_DEFUN([AX_SHENANGO],[
tryshenangodir=""
AC_ARG_WITH(shenango,
       [  --with-shenango=PATH     Specify path to shenango installation ],
       [
                if test "x$withval" != "xno" ; then
                        tryshenangodir=$withval
                fi
       ]
)

dnl ------------------------------------------------------

AC_CACHE_CHECK([for shenango directory], ac_cv_shenango_dir, [
  saved_LIBS="$LIBS"
  saved_LDFLAGS="$LDFLAGS"
  saved_CPPFLAGS="$CPPFLAGS"
  le_found=no
  for ledir in $tryshenangodir "" $prefix /usr/local ; do
    LDFLAGS="$saved_LDFLAGS"
    LIBS="-lruntime -lnet -lbase $saved_LIBS"

    # Skip the directory if it isn't there.
    if test ! -z "$ledir" -a ! -d "$ledir" ; then
       continue;
    fi
    if test ! -z "$ledir" ; then
      if test -d "$ledir/lib" ; then
        LDFLAGS="-L$ledir/lib -T $ledir/base/base.ld $LDFLAGS"
      else
        LDFLAGS="-L$ledir -T $ledir/base/base.ld $LDFLAGS"
      fi
      if test -d "$ledir/inc" ; then
        CPPFLAGS="-I$ledir/inc $CPPFLAGS"
      else
        CPPFLAGS="-I$ledir $CPPFLAGS"
      fi
    fi
    # Can I compile and link it?
    AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <sys/time.h>
#include <sys/types.h>
#include <runtime/thread.h>]], [[ thread_yield() ]])],[ shenango_linked=yes ],[ shenango_linked=no ])
    if test $shenango_linked = yes; then
       if test ! -z "$ledir" ; then
         ac_cv_shenango_dir=$ledir
       else
         ac_cv_shenango_dir="(system)"
       fi
       le_found=yes
       break
    fi
  done
  LIBS="$saved_LIBS"
  LDFLAGS="$saved_LDFLAGS"
  CPPFLAGS="$saved_CPPFLAGS"
  if test $le_found = no ; then
    AC_MSG_ERROR([shenango is required. 

      If it's already installed, specify its path using --with-shenango=/dir/
])
  fi
])
SHEN_LIBS="-lruntime -lnet -lbase"
if test $ac_cv_shenango_dir != "(system)"; then
  if test -d "$ac_cv_shenango_dir/lib" ; then
    SHEN_LDFLAGS="-no-pie -L$ac_cv_shenango_dir/lib -T $ac_cv_shenango_dir/base/base.ld"
    le_libdir="$ac_cv_shenango_dir/lib"
  else
    SHEN_LDFLAGS="-no-pie -L$ac_cv_shenango_dir -T $ac_cv_shenango_dir/base/base.ld"
    le_libdir="$ac_cv_shenango_dir"
  fi
  if test -d "$ac_cv_shenango_dir/inc" ; then
    SHEN_CPPFLAGS="-I$ac_cv_shenango_dir/inc"
  else
    SHEN_CPPFLAGS="-I$ac_cv_shenango_dir"
  fi
fi
SHEN_CPPFLAGS="-DNDEBUG -O3 -Wall -std=gnu11 -D_GNU_SOURCE -mssse3 $SHEN_CPPFLAGS"

])dnl AX_SHENANGO
