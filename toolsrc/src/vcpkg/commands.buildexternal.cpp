#include "pch.h"

#include <vcpkg/build.h>
#include <vcpkg/commands.h>
#include <vcpkg/help.h>
#include <vcpkg/input.h>

namespace vcpkg::Commands::BuildExternal
{
    const CommandStructure COMMAND_STRUCTURE = {
        Help::create_example_string(R"(build_external zlib2 C:\path\to\dir\with\controlfile\)"),
        2,
        2,
        {},
        nullptr,
    };

    void perform_and_exit(const VcpkgCmdArguments& args, const VcpkgPaths& paths, const Triplet& default_triplet)
    {
        const ParsedArguments options = args.parse_arguments(COMMAND_STRUCTURE);

        const FullPackageSpec spec = Input::check_and_get_full_package_spec(
            std::string(args.command_arguments.at(0)), default_triplet, COMMAND_STRUCTURE.example_text);
        Input::check_triplet(spec.package_spec.triplet(), paths);

        auto overlays = args.overlay_ports ? *args.overlay_ports : std::vector<std::string>();
        overlays.insert(overlays.begin(), args.command_arguments.at(1));
        Dependencies::PathsPortFileProvider provider(paths, &overlays);
        auto maybe_scfl = provider.get_control_file(spec.package_spec.name());
        Checks::check_exit(
            VCPKG_LINE_INFO, maybe_scfl.has_value(), "could not load control file for %s", spec.package_spec.name());
        Build::Command::perform_and_exit_ex(spec, maybe_scfl.value_or_exit(VCPKG_LINE_INFO), options, paths);
    }
}
