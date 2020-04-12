#pragma once

#include <vcpkg/packagespec.h>
#include <vcpkg/statusparagraphs.h>
#include <vcpkg/triplet.h>
#include <vcpkg/vcpkgcmdarguments.h>
#include <vcpkg/vcpkgpaths.h>

#include <vcpkg/base/cstringview.h>
#include <vcpkg/base/files.h>
#include <vcpkg/base/optional.h>

#include <array>
#include <map>
#include <set>
#include <vector>

namespace vcpkg::Build
{
    namespace Command
    {
        void perform_and_exit_ex(const FullPackageSpec& full_spec,
                                 const fs::path& port_dir,
                                 const ParsedArguments& options,
                                 const VcpkgPaths& paths);

        void perform_and_exit(const VcpkgCmdArguments& args, const VcpkgPaths& paths, const Triplet& default_triplet);
    }

    enum class UseHeadVersion
    {
        NO = 0,
        YES
    };

    enum class AllowDownloads
    {
        NO = 0,
        YES
    };

    enum class CleanBuildtrees
    {
        NO = 0,
        YES
    };

    enum class CleanPackages
    {
        NO = 0,
        YES
    };

    enum class ConfigurationType
    {
        DEBUG,
        RELEASE,
    };

    enum class DownloadTool
    {
        BUILT_IN,
        ARIA2,
    };
    const std::string& to_string(DownloadTool tool);

    enum class BinaryCaching
    {
        NO = 0,
        YES
    };

    enum class FailOnTombstone
    {
        NO = 0,
        YES
    };

    struct BuildPackageOptions
    {
        UseHeadVersion use_head_version;
        AllowDownloads allow_downloads;
        CleanBuildtrees clean_buildtrees;
        CleanPackages clean_packages;
        DownloadTool download_tool;
        BinaryCaching binary_caching;
        FailOnTombstone fail_on_tombstone;
    };

    enum class BuildResult
    {
        NULLVALUE = 0,
        SUCCEEDED,
        BUILD_FAILED,
        POST_BUILD_CHECKS_FAILED,
        FILE_CONFLICTS,
        CASCADED_DUE_TO_MISSING_DEPENDENCIES,
        EXCLUDED,
    };

    static constexpr std::array<BuildResult, 6> BUILD_RESULT_VALUES = {
        BuildResult::SUCCEEDED,
        BuildResult::BUILD_FAILED,
        BuildResult::POST_BUILD_CHECKS_FAILED,
        BuildResult::FILE_CONFLICTS,
        BuildResult::CASCADED_DUE_TO_MISSING_DEPENDENCIES,
        BuildResult::EXCLUDED};

    const std::string& to_string(const BuildResult build_result);
    std::string create_error_message(const BuildResult build_result, const PackageSpec& spec);
    std::string create_user_troubleshooting_message(const PackageSpec& spec);

    /// <summary>
    /// Settings from the triplet file which impact the build environment and post-build checks
    /// </summary>
    struct PreBuildInfo
    {
        /// <summary>
        /// Runs the triplet file in a "capture" mode to create a PreBuildInfo
        /// </summary>
        static PreBuildInfo from_triplet_file(const VcpkgPaths& paths, const Triplet& triplet);

        std::string triplet_abi_tag;
        std::string target_architecture;
        std::string cmake_system_name;
        std::string cmake_system_version;
        Optional<std::string> platform_toolset;
        Optional<fs::path> visual_studio_path;
        Optional<std::string> external_toolchain_file;
        Optional<ConfigurationType> build_type;
    };

    std::string make_build_env_cmd(const PreBuildInfo& pre_build_info, const Toolset& toolset);

    struct ExtendedBuildResult
    {
        ExtendedBuildResult(BuildResult code);
        ExtendedBuildResult(BuildResult code, std::vector<FeatureSpec>&& unmet_deps);
        ExtendedBuildResult(BuildResult code, std::unique_ptr<BinaryControlFile>&& bcf);

        BuildResult code;
        std::vector<FeatureSpec> unmet_dependencies;
        std::unique_ptr<BinaryControlFile> binary_control_file;
    };

    struct BuildPackageConfig
    {
        BuildPackageConfig(const SourceControlFile& src,
                           const Triplet& triplet,
                           fs::path&& port_dir,
                           const BuildPackageOptions& build_package_options,
                           const std::set<std::string>& feature_list)
            : scf(src)
            , triplet(triplet)
            , port_dir(std::move(port_dir))
            , build_package_options(build_package_options)
            , feature_list(feature_list)
        {
        }

        const SourceControlFile& scf;
        const Triplet& triplet;
        fs::path port_dir;
        const BuildPackageOptions& build_package_options;
        const std::set<std::string>& feature_list;
    };

    ExtendedBuildResult build_package(const VcpkgPaths& paths,
                                      const BuildPackageConfig& config,
                                      const StatusParagraphs& status_db);

    enum class BuildPolicy
    {
        EMPTY_PACKAGE,
        DLLS_WITHOUT_LIBS,
        ONLY_RELEASE_CRT,
        EMPTY_INCLUDE_FOLDER,
        ALLOW_OBSOLETE_MSVCRT,
        // Must be last
        COUNT,
    };

    constexpr std::array<BuildPolicy, size_t(BuildPolicy::COUNT)> G_ALL_POLICIES = {
        BuildPolicy::EMPTY_PACKAGE,
        BuildPolicy::DLLS_WITHOUT_LIBS,
        BuildPolicy::ONLY_RELEASE_CRT,
        BuildPolicy::EMPTY_INCLUDE_FOLDER,
        BuildPolicy::ALLOW_OBSOLETE_MSVCRT,
    };

    const std::string& to_string(BuildPolicy policy);
    CStringView to_cmake_variable(BuildPolicy policy);

    struct BuildPolicies
    {
        BuildPolicies() = default;
        BuildPolicies(std::map<BuildPolicy, bool>&& map) : m_policies(std::move(map)) {}

        bool is_enabled(BuildPolicy policy) const
        {
            const auto it = m_policies.find(policy);
            if (it != m_policies.cend()) return it->second;
            return false;
        }

    private:
        std::map<BuildPolicy, bool> m_policies;
    };

    enum class LinkageType : char
    {
        DYNAMIC,
        STATIC,
    };

    Optional<LinkageType> to_linkage_type(const std::string& str);

    struct BuildInfo
    {
        LinkageType crt_linkage = LinkageType::DYNAMIC;
        LinkageType library_linkage = LinkageType::DYNAMIC;

        Optional<std::string> version;

        BuildPolicies policies;
    };

    BuildInfo read_build_info(const Files::Filesystem& fs, const fs::path& filepath);

    struct AbiEntry
    {
        std::string key;
        std::string value;

        bool operator<(const AbiEntry& other) const
        {
            return key < other.key || (key == other.key && value < other.value);
        }
    };

    struct AbiTagAndFile
    {
        std::string tag;
        fs::path tag_file;
    };

    Optional<AbiTagAndFile> compute_abi_tag(const VcpkgPaths& paths,
                                            const BuildPackageConfig& config,
                                            const PreBuildInfo& pre_build_info,
                                            Span<const AbiEntry> dependency_abis);
}
