project(cppunit)
cmake_minimum_required(VERSION 2.6)

# CppUnit version number
set(CPPUNIT_MAJOR_VERSION 1)
set(CPPUNIT_MINOR_VERSION 12)
set(CPPUNIT_MICRO_VERSION 1)
set(CPPUNIT_VERSION ${CPPUNIT_MAJOR_VERSION}.${CPPUNIT_MINOR_VERSION}.${CPPUNIT_MICRO_VERSION})

option(BUILD_EXECUTABLE  "Enable building DllPlugInTester" OFF)
option(BUILD_SHARED_LIBS "Build shared library." ON)

set(CPPUNIT_SRC
    #core
    src/cppunit/AdditionalMessage.cpp
    src/cppunit/Asserter.cpp
    src/cppunit/Exception.cpp
    src/cppunit/Message.cpp
    src/cppunit/SourceLine.cpp
    src/cppunit/SynchronizedObject.cpp
    src/cppunit/Test.cpp
    src/cppunit/TestAssert.cpp
    src/cppunit/TestCase.cpp
    src/cppunit/TestComposite.cpp
    src/cppunit/TestFailure.cpp
    src/cppunit/TestLeaf.cpp
    src/cppunit/TestPath.cpp
    src/cppunit/TestResult.cpp
    src/cppunit/TestRunner.cpp
    src/cppunit/TestSuite.cpp

    #extension
    src/cppunit/RepeatedTest.cpp
    src/cppunit/TestCaseDecorator.cpp
    src/cppunit/TestDecorator.cpp
    src/cppunit/TestSetUp.cpp

    #helper
    src/cppunit/TestFactoryRegistry.cpp
    src/cppunit/TestNamer.cpp
    src/cppunit/TestSuiteBuilderContext.cpp
    src/cppunit/TypeInfoHelper.cpp

    #listener
    src/cppunit/BriefTestProgressListener.cpp
    src/cppunit/TestResultCollector.cpp
    src/cppunit/TestSuccessListener.cpp
    src/cppunit/TextTestProgressListener.cpp
    src/cppunit/TextTestResult.cpp

    #output
    src/cppunit/CompilerOutputter.cpp
    src/cppunit/TextOutputter.cpp
    src/cppunit/XmlOutputter.cpp
    src/cppunit/XmlOutputterHook.cpp

    #plugin
    src/cppunit/BeOsDynamicLibraryManager.cpp
    src/cppunit/DynamicLibraryManager.cpp
    src/cppunit/DynamicLibraryManagerException.cpp
    src/cppunit/PlugInManager.cpp
    src/cppunit/PlugInParameters.cpp
    src/cppunit/ShlDynamicLibraryManager.cpp
    src/cppunit/TestPlugInDefaultImpl.cpp
    src/cppunit/UnixDynamicLibraryManager.cpp
    src/cppunit/Win32DynamicLibraryManager.cpp

    #protector
    src/cppunit/DefaultProtector.cpp
    src/cppunit/Protector.cpp
    src/cppunit/ProtectorChain.cpp

    #textui
    src/cppunit/TextTestRunner.cpp

    #tools
    src/cppunit/StringTools.cpp
    src/cppunit/XmlDocument.cpp
    src/cppunit/XmlElement.cpp
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_BINARY_DIR}/include/)

# Generates include/cppunit/config-auto.h
include(${CMAKE_CURRENT_SOURCE_DIR}/config/config.cmake)

if(BUILD_SHARED_LIBS)
    add_library(cppunit SHARED ${CPPUNIT_SRC})
    add_definitions(-DCPPUNIT_BUILD_DLL)
    target_link_libraries(cppunit ${CMAKE_DL_LIBS})
else()
    add_library(cppunit STATIC ${CPPUNIT_SRC})
endif()

set_target_properties(cppunit PROPERTIES
	VERSION ${CPPUNIT_VERSION}
	SOVERSION ${CPPUNIT_MAJOR_VERSION}
)

if(BUILD_EXECUTABLE)
    set(DLLPLUGINTESTER_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/DllPlugInTester/CommandLineParser.cpp
                            ${CMAKE_CURRENT_SOURCE_DIR}/src/DllPlugInTester/DllPlugInTester.cpp
                            )
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/DllPlugInTester)
    add_executable(DllPlugInTester ${DLLPLUGINTESTER_SRC})
    target_link_libraries(DllPlugInTester cppunit)
    install(TARGETS DllPlugInTester
            RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}/bin")
endif()

install(TARGETS cppunit
        RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}/bin"
        ARCHIVE DESTINATION "${CMAKE_INSTALL_PREFIX}/lib"
        LIBRARY DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" )
install(FILES ${CMAKE_BINARY_DIR}/include/cppunit/config-auto.h
        DESTINATION "${CMAKE_INSTALL_PREFIX}/include/cppunit/")
install(DIRECTORY "${PROJECT_SOURCE_DIR}/include/cppunit"
        DESTINATION "${CMAKE_INSTALL_PREFIX}/include")

