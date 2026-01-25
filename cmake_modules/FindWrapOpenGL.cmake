# Minimal replacement for CMake's removed FindWrapOpenGL (CMake 4.x).
# Goal on macOS: provide WrapOpenGL::WrapOpenGL WITHOUT deprecated AGL.framework.

if(APPLE AND NOT IOS)
  # OpenGL is still provided as a framework (deprecated but present)
  find_library(_WRAPOPENGL_OPENGL_FRAMEWORK OpenGL)
  if(NOT _WRAPOPENGL_OPENGL_FRAMEWORK)
    set(WrapOpenGL_FOUND FALSE)
    if(WrapOpenGL_FIND_REQUIRED)
      message(FATAL_ERROR "WrapOpenGL: OpenGL.framework not found")
    endif()
    return()
  endif()

  if(NOT TARGET WrapOpenGL::WrapOpenGL)
    add_library(WrapOpenGL::WrapOpenGL INTERFACE IMPORTED)
  endif()

  # Link only OpenGL.framework; do NOT link AGL
  set_property(TARGET WrapOpenGL::WrapOpenGL PROPERTY
    INTERFACE_LINK_LIBRARIES "${_WRAPOPENGL_OPENGL_FRAMEWORK}"
  )

  set(WrapOpenGL_LIBRARIES "${_WRAPOPENGL_OPENGL_FRAMEWORK}")
  set(WrapOpenGL_INCLUDE_DIRS "")
  set(WrapOpenGL_FOUND TRUE)

  # Force-disable AGL cache entries (Qt/CMake should not resurrect it anymore)
  set(WrapOpenGL_AGL "WrapOpenGL_AGL-NOTFOUND" CACHE FILEPATH "Disable deprecated AGL.framework" FORCE)
  set(OPENGL_AGL_LIBRARY "OPENGL_AGL_LIBRARY-NOTFOUND" CACHE FILEPATH "" FORCE)
  set(OpenGL_AGL_LIBRARY "OpenGL_AGL_LIBRARY-NOTFOUND" CACHE FILEPATH "" FORCE)

else()
  # Non-Apple fallback: rely on FindOpenGL if ever needed
  find_package(OpenGL)
  if(OpenGL_FOUND)
    if(NOT TARGET WrapOpenGL::WrapOpenGL)
      add_library(WrapOpenGL::WrapOpenGL INTERFACE IMPORTED)
    endif()
    if(TARGET OpenGL::GL)
      set_property(TARGET WrapOpenGL::WrapOpenGL PROPERTY INTERFACE_LINK_LIBRARIES OpenGL::GL)
      set(WrapOpenGL_LIBRARIES OpenGL::GL)
    elseif(TARGET OpenGL::OpenGL)
      set_property(TARGET WrapOpenGL::WrapOpenGL PROPERTY INTERFACE_LINK_LIBRARIES OpenGL::OpenGL)
      set(WrapOpenGL_LIBRARIES OpenGL::OpenGL)
    endif()
    set(WrapOpenGL_FOUND TRUE)
  else()
    set(WrapOpenGL_FOUND FALSE)
    if(WrapOpenGL_FIND_REQUIRED)
      message(FATAL_ERROR "WrapOpenGL: OpenGL not found")
    endif()
  endif()
endif()
