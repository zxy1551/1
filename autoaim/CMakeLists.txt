cmake_minimum_required(VERSION 3.15)


project(autoaim)
#set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
#set(CMAKE_PREFIX_PATH /opt/intel/opencvino_2021.4.752./openvino_2021/inference_engine/share)
#set(InferenceEngine_DIR "/opt/intel/openvino/deployment_tools/inference_engine/share")

find_package(OpenCV 4 REQUIRED)
#find_package(InferenceEngine REQUIRED)
#find_package(Eigen3 REQUIRED)
#find_package(yaml-cpp REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})
#include_directories(${EIGEN3_INCLUDE_DIRS})
#include_directories(${InferenceEngine_INCLUDE_DIRS})
#if(InferenceEngine_FOUND)
 #   message(STATUS "InferenceEngine found. Version: ${InferenceEngine_VERSION}")
#else()
 #   message(FATAL_ERROR "InferenceEngine not found. Please set InferenceEngine_DIR or CMAKE_PREFIX_PATH.")
#endif()
# aux_source_directory(detector detector_src)
# aux_source_directory(predictor predictor_src)

#TODO: CMAKE as a submodule
# add_library(autoaim_lib OBJECT autoaim.cpp ${detector_src} ${predictor_src})
# add_library(autoaim_lib OBJECT ${detector_src} ${predictor_src})
# target_link_libraries(autoaim ${OpenCV_LIBRARIES} ${InferenceEngine_LIBRARIES})
add_executable(autoaim autoaim.cpp
                        autoaim.h
                       
                        ./debug.h
                        ../debug.h
                        ../general/general.cpp
                        ../general/general.h
                        ../coordsolver/coordsolver.cpp
                        ../coordsolver/coordsolver.h
                        ./predictor/particle_filter.cpp
                        ./predictor/particle_filter.h
                        ./predictor/predictor.cpp
                        ./predictor/predictor.h
                        )

# add_executable(autoaim autoaim.cpp
#                         ./detector/inference.cpp
#                         ./detector/inference.h
#                         ./debug.h
#                         ../debug.h
#                         ../coordsolver/coordsolver.cpp
#                         ../coordsolver/coordsolver.h
#                         ../general/general.cpp
#                         ../general/general.h
#                         )

add_executable(YourExecutable main.cpp)
#target_link_libraries(YourExecutable PRIVATE ${InferenceEngine_LIBRARIES})
target_link_libraries(autoaim ${OpenCV_LIBRARIES}  yaml-cpp)