cmake_minimum_required(VERSION 2.8.3)
project(sbg_driver)

add_compile_options(-std=c++11 -lpthread)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Farmwise mod of sbg_ros_driver")
SET(CPACK_PACKAGE_VENDOR "farmwise.io")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
SET(CPACK_PACKAGE_NAME "ros-kinetic-sbg-driver-farmwise")
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "0")
SET(CPACK_PACKAGE_VERSION_PATCH "1")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Adam Cadien")
SET(CPACK_PACKAGING_INSTALL_PREFIX "/opt/ros/kinetic")
# Set this to ensure we overwrite the existing updater, if it's installed
SET(CPACK_DEBIAN_PACKAGE_CONFLICTS "ros-kinetic-sbg-driver")
SET(CPACK_DEBIAN_PACKAGE_REPLACES "ros-kinetic-sbg-driver")
include(CPack)

if(${STANDALONE_INSTALL})
  SET(CMAKE_BUILD_TYPE "None")
  SET(CMAKE_INSTALL_SYSCONFDIR "/etc")
  SET(CMAKE_INSTALL_LOCALSTATEDIR "/var")
  SET(CATKIN_BUILD_BINARY_PACKAGE "1")
  SET(CMAKE_INSTALL_PREFIX "/opt/ros/kinetic")
  SET(CMAKE_PREFIX_PATH "/opt/ros/kinetic")
endif()

find_package(catkin REQUIRED COMPONENTS
  #libsbgrosdriver
  roscpp
  sensor_msgs
  std_msgs
  std_srvs
  geometry_msgs
  message_generation
)

################################################
## Declare ROS messages, services and actions ##
################################################
## Generate messages in the 'msg' folder
add_message_files(FILES
  SbgGpsVelStatus.msg
  SbgGpsPosStatus.msg
  SbgMagStatus.msg
  SbgShipMotionStatus.msg
  SbgUtcTimeStatus.msg

  SbgEkfEuler.msg
  SbgGpsPos.msg
  SbgMag.msg
  SbgStatusCom.msg
  SbgEkfNav.msg
  SbgGpsRaw.msg
  SbgOdoVel.msg
  SbgStatusGeneral.msg
  SbgEkfQuat.msg
  SbgGpsVel.msg
  SbgPressure.msg
  SbgStatus.msg
  SbgEvent.msg
  SbgImuStatus.msg
  SbgImuData.msg
  SbgShipMotion.msg
  SbgUtcTime.msg
  SbgGpsHdt.msg
  SbgMagCalib.msg
  SbgStatusAiding.msg
  SbgEkfStatus.msg
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
)

################################################
## Declare ROS dynamic reconfigure parameters ##
################################################
#none

###################################
## catkin specific configuration ##
###################################
catkin_package(
  INCLUDE_DIRS src
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
add_subdirectory(sbgECom)
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/sbgECom/common
  ${PROJECT_SOURCE_DIR}/sbgECom/src
)

## Declare a C++ executable
add_executable(ellipse
  src/main.cpp
  src/ellipse.cpp
  src/ellipse_msg.cpp
)

add_executable(ellipse_mag
  src/ellipse_mag.cpp
  src/ellipse.cpp
  src/ellipse_msg.cpp
)

add_dependencies(ellipse ${sbg_driver_EXPORTED_TARGETS})
add_dependencies(ellipse_mag ${sbg_driver_EXPORTED_TARGETS})

target_compile_options(ellipse PRIVATE -fpermissive)
target_compile_options(ellipse_mag PRIVATE -fpermissive)

## Specify libraries to link a library or executable target against
target_link_libraries(ellipse
   ${catkin_LIBRARIES}
   sbgECom
)

target_link_libraries(ellipse_mag
   ${catkin_LIBRARIES}
   sbgECom
)

#############
## Install ##
#############

## Mark executables and/or libraries for installation
 install(TARGETS ellipse ellipse_mag
   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )

## Mark cpp header files for installation
 install(DIRECTORY include/${PROJECT_NAME}/
   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
   FILES_MATCHING PATTERN "*.h"
   PATTERN ".svn" EXCLUDE
   PATTERN ".git" EXCLUDE
 )

# Mark other files for installation (e.g. launch and bag files, etc.)
install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
  PATTERN ".git" EXCLUDE)

install(DIRECTORY config/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/config
  PATTERN ".git" EXCLUDE)
