set(PELIB_SOURCES
	BoundImportDirectory.cpp
	CoffSymbolTable.cpp
	ComHeaderDirectory.cpp
	DebugDirectory.cpp
	ExportDirectory.cpp
	IatDirectory.cpp
	InputBuffer.cpp
	MzHeader.cpp
	OutputBuffer.cpp
	PeFile.cpp
	PeHeader.cpp
	PeLibAux.cpp
	RelocationsDirectory.cpp
	ResourceDirectory.cpp
	RichHeader.cpp
	SecurityDirectory.cpp
)

add_library(pelib STATIC ${PELIB_SOURCES})
target_include_directories(pelib SYSTEM PUBLIC ../../include)


# Installation
SET(CMAKE_INSTALL_ALWAYS 1)

install(TARGETS ${targets}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
