# Generates include/cppunit/config-auto.h
# This is originally done by autoconf

include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckCXXSourceCompiles)
include(CheckCSourceCompiles)
include(CheckLibraryExists)
include(CheckFunctionExists)

#Not used == not seen in any *.h *.cpp files
#Not used FUNC_STRING_COMPARE_STRING_FIRST

check_include_file_cxx(sstream CPPUNIT_HAVE_SSTREAM)
check_include_file_cxx(strstream CPPUNIT_HAVE_STRSTREAM)
set (CMAKE_REQUIRED_DEFINITIONS -DHAVE_STRSTREAM=CPPUNIT_HAVE_STRSTREAM)
check_cxx_source_compiles(
"#ifdef HAVE_STRSTREAM
#    include <strstream>
#else
#    include <strstream.h>
#endif
int main() {
    std::ostrstream message;
    message << \"Hello\";
    return 0;
}" CPPUNIT_HAVE_CLASS_STRSTREAM)

check_include_file_cxx(cmath CPPUNIT_HAVE_CMATH)
#Not used, dld library is obsolete anyway HAVE_DLD
#Not used HAVE_DLERROR
check_include_file(dlfcn.h CPPUNIT_HAVE_DLFCN_H)

check_c_source_compiles(
"#include <math.h>
int main() {
    return finite(3);
}" CPPUNIT_HAVE_FINITE)

check_c_source_compiles(
"#include <math.h>
int main() {
    return _finite(3);
}" CPPUNIT_HAVE__FINITE)

check_include_file_cxx(cxxabi.h CPPUNIT_HAVE_GCC_ABI_DEMANGLE)
#Not used HAVE_INTTYPES_H

check_c_source_compiles(
"#include <math.h>
int main() {
    return isfinite(3);
}" CPPUNIT_HAVE_ISFINITE)

check_library_exists(dl dlopen "" CPPUNIT_HAVE_LIBDL)
#Not used HAVE_MEMORY_H

check_cxx_source_compiles(
"namespace Outer {
    namespace Inner {
        int i = 0;
    }
}
using namespace Outer::Inner;
int main() {
    return i;
}" CPPUNIT_HAVE_NAMESPACES)

check_cxx_source_compiles(
"#include <typeinfo>
class Base {
public:
    Base() {}
    virtual int f() { return 0; }
};
class Derived : public Base {
public:
    Derived() {}
    virtual int f() { return 1; }
};
int main() {
    Derived d;
    Base * ptr = &d;
    return typeid(*ptr) == typeid(Derived);
}" CPPUNIT_HAVE_RTTI)

check_library_exists(dl shl_load "" CPPUNIT_HAVE_SHL_LOAD)
#Not used HAVE_STDINT_H
#Not used HAVE_STDLIB_H
#Not used HAVE_STRINGS_H
#Not used HAVE_STRING_H
#Not used HAVE_SYS_STAT_H
#Not used HAVE_SYS_TYPES_H
#Not used HAVE_UNISTD_H
#Not used PACKAGE
#Not used PACKAGE_BUGREPORT
#Not used PACKAGE_NAME
#Not used PACKAGE_STRING
#Not used PACKAGE_TARNAME
#Not used PACKAGE_VERSION
#Not used STDC_HEADERS
check_include_file_cxx(typeinfo CPPUNIT_USE_TYPEINFO_NAME)
#CPPUNIT_VERSION ok

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config/config.h.cmake 
               ${CMAKE_BINARY_DIR}/include/cppunit/config-auto.h @ONLY)


