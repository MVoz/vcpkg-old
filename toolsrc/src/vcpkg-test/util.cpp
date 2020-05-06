#include <catch2/catch.hpp>
#include <vcpkg-test/util.h>

#include <vcpkg/base/checks.h>
#include <vcpkg/base/files.h>
#include <vcpkg/base/util.h>
#include <vcpkg/statusparagraph.h>

// used to get the implementation specific compiler flags (i.e., __cpp_lib_filesystem)
#include <ciso646>

#include <iostream>
#include <memory>

#if defined(_WIN32)
#include <windows.h>
#endif

#define FILESYSTEM_SYMLINK_STD 0
#define FILESYSTEM_SYMLINK_UNIX 1
#define FILESYSTEM_SYMLINK_NONE 2

#if defined(__cpp_lib_filesystem)

#define FILESYSTEM_SYMLINK FILESYSTEM_SYMLINK_STD
#include <filesystem> // required for filesystem::create_{directory_}symlink

#elif !defined(_MSC_VER)

#define FILESYSTEM_SYMLINK FILESYSTEM_SYMLINK_UNIX
#include <unistd.h>

#else

#define FILESYSTEM_SYMLINK FILESYSTEM_SYMLINK_NONE

#endif

namespace vcpkg::Test
{
    std::unique_ptr<vcpkg::StatusParagraph> make_status_pgh(const char* name,
                                                            const char* depends,
                                                            const char* default_features,
                                                            const char* triplet)
    {
        using Pgh = std::unordered_map<std::string, std::string>;
        return std::make_unique<StatusParagraph>(Pgh{{"Package", name},
                                                     {"Version", "1"},
                                                     {"Architecture", triplet},
                                                     {"Multi-Arch", "same"},
                                                     {"Depends", depends},
                                                     {"Default-Features", default_features},
                                                     {"Status", "install ok installed"}});
    }

    std::unique_ptr<StatusParagraph> make_status_feature_pgh(const char* name,
                                                             const char* feature,
                                                             const char* depends,
                                                             const char* triplet)
    {
        using Pgh = std::unordered_map<std::string, std::string>;
        return std::make_unique<StatusParagraph>(Pgh{{"Package", name},
                                                     {"Version", "1"},
                                                     {"Feature", feature},
                                                     {"Architecture", triplet},
                                                     {"Multi-Arch", "same"},
                                                     {"Depends", depends},
                                                     {"Status", "install ok installed"}});
    }

    PackageSpec unsafe_pspec(std::string name, Triplet t)
    {
        auto m_ret = PackageSpec::from_name_and_triplet(name, t);
        REQUIRE(m_ret.has_value());
        return m_ret.value_or_exit(VCPKG_LINE_INFO);
    }

    static AllowSymlinks internal_can_create_symlinks() noexcept
    {
#if FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_NONE
        return AllowSymlinks::No;
#elif FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_UNIX
        return AllowSymlinks::Yes;
#elif !defined(_WIN32) // FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_STD
        return AllowSymlinks::Yes;
#else
        HKEY key;
        bool allow_symlinks = true;

        const auto status = RegOpenKeyExW(
            HKEY_LOCAL_MACHINE, LR"(SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock)", 0, 0, &key);

        if (status == ERROR_FILE_NOT_FOUND)
        {
            allow_symlinks = false;
            std::clog << "Symlinks are not allowed on this system\n";
        }

        if (status == ERROR_SUCCESS) RegCloseKey(key);

        return allow_symlinks ? AllowSymlinks::Yes : AllowSymlinks::No;
#endif
    }
    const static AllowSymlinks CAN_CREATE_SYMLINKS = internal_can_create_symlinks();

    AllowSymlinks can_create_symlinks() noexcept { return CAN_CREATE_SYMLINKS; }

    static fs::path internal_base_temporary_directory()
    {
#if defined(_WIN32)
        wchar_t* tmp = static_cast<wchar_t*>(std::calloc(32'767, 2));

        if (!GetEnvironmentVariableW(L"TEMP", tmp, 32'767))
        {
            std::cerr << "No temporary directory found.\n";
            std::abort();
        }

        fs::path result = tmp;
        std::free(tmp);

        return result / L"vcpkg-test";
#else
        return "/tmp/vcpkg-test";
#endif
    }

    const static fs::path BASE_TEMPORARY_DIRECTORY = internal_base_temporary_directory();

    const fs::path& base_temporary_directory() noexcept { return BASE_TEMPORARY_DIRECTORY; }

#if FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_NONE
    constexpr char no_filesystem_message[] =
        "<filesystem> doesn't exist; on windows, we don't attempt to use the win32 calls to create symlinks";
#endif

    void create_symlink(const fs::path& target, const fs::path& file, std::error_code& ec)
    {
#if FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_STD
        if (can_create_symlinks())
        {
            std::filesystem::path targetp = target.native();
            std::filesystem::path filep = file.native();

            std::filesystem::create_symlink(targetp, filep, ec);
        }
        else
        {
            vcpkg::Checks::exit_with_message(VCPKG_LINE_INFO, "Symlinks are not allowed on this system");
        }
#elif FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_UNIX
        if (symlink(target.c_str(), file.c_str()) != 0)
        {
            ec.assign(errno, std::system_category());
        }
#else
        Util::unused(target, file, ec);
        vcpkg::Checks::exit_with_message(VCPKG_LINE_INFO, no_filesystem_message);
#endif
    }

    void create_directory_symlink(const fs::path& target, const fs::path& file, std::error_code& ec)
    {
#if FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_STD
        if (can_create_symlinks())
        {
            std::filesystem::path targetp = target.native();
            std::filesystem::path filep = file.native();

            std::filesystem::create_directory_symlink(targetp, filep, ec);
        }
        else
        {
            vcpkg::Checks::exit_with_message(VCPKG_LINE_INFO, "Symlinks are not allowed on this system");
        }
#elif FILESYSTEM_SYMLINK == FILESYSTEM_SYMLINK_UNIX
        ::vcpkg::Test::create_symlink(target, file, ec);
#else
        Util::unused(target, file, ec);
        vcpkg::Checks::exit_with_message(VCPKG_LINE_INFO, no_filesystem_message);
#endif
    }
}
