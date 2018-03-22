#pragma once

#define DEBUG !NDEBUG

#include <base/limits.h>
#include <base/lock.h>
#include <base/tcache.h>

#include <runtime/thread.h>
#include <runtime/sync.h>
#include <runtime/udp.h>

#undef assert
#undef ARRAY_SIZE
#undef likely
#undef unlikely