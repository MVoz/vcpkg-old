#include <catch2/catch.hpp>

#include <vcpkg/base/util.h>
#include <vcpkg/packagespec.h>

using namespace vcpkg;

TEST_CASE ("specifier conversion", "[specifier]")
{
    SECTION ("full package spec to feature specs")
    {
        constexpr std::size_t SPEC_SIZE = 6;

        auto a_spec = PackageSpec::from_name_and_triplet("a", Triplet::X64_WINDOWS).value_or_exit(VCPKG_LINE_INFO);
        auto b_spec = PackageSpec::from_name_and_triplet("b", Triplet::X64_WINDOWS).value_or_exit(VCPKG_LINE_INFO);

        auto fspecs = FullPackageSpec::to_feature_specs({{a_spec, {"0", "1"}}, {b_spec, {"2", "3"}}});

        REQUIRE(fspecs.size() == SPEC_SIZE);

        std::array<const char*, SPEC_SIZE> features = {"", "0", "1", "", "2", "3"};
        std::array<PackageSpec*, SPEC_SIZE> specs = {&a_spec, &a_spec, &a_spec, &b_spec, &b_spec, &b_spec};

        for (std::size_t i = 0; i < SPEC_SIZE; ++i)
        {
            REQUIRE(features.at(i) == fspecs.at(i).feature());
            REQUIRE(*specs.at(i) == fspecs.at(i).spec());
        }
    }
}

TEST_CASE ("specifier parsing", "[specifier]")
{
    SECTION ("parsed specifier from string")
    {
        auto maybe_spec = vcpkg::ParsedSpecifier::from_string("zlib");
        REQUIRE(maybe_spec.error() == vcpkg::PackageSpecParseResult::SUCCESS);

        auto& spec = *maybe_spec.get();
        REQUIRE(spec.name == "zlib");
        REQUIRE(spec.features.size() == 0);
        REQUIRE(spec.triplet == "");
    }

    SECTION ("parsed specifier from string with triplet")
    {
        auto maybe_spec = vcpkg::ParsedSpecifier::from_string("zlib:x64-uwp");
        REQUIRE(maybe_spec.error() == vcpkg::PackageSpecParseResult::SUCCESS);

        auto& spec = *maybe_spec.get();
        REQUIRE(spec.name == "zlib");
        REQUIRE(spec.triplet == "x64-uwp");
    }

    SECTION ("parsed specifier from string with colons")
    {
        auto ec = vcpkg::ParsedSpecifier::from_string("zlib:x86-uwp:").error();
        REQUIRE(ec == vcpkg::PackageSpecParseResult::TOO_MANY_COLONS);
    }

    SECTION ("parsed specifier from string with feature")
    {
        auto maybe_spec = vcpkg::ParsedSpecifier::from_string("zlib[feature]:x64-uwp");
        REQUIRE(maybe_spec.error() == vcpkg::PackageSpecParseResult::SUCCESS);

        auto& spec = *maybe_spec.get();
        REQUIRE(spec.name == "zlib");
        REQUIRE(spec.features.size() == 1);
        REQUIRE(spec.features.at(0) == "feature");
        REQUIRE(spec.triplet == "x64-uwp");
    }

    SECTION ("parsed specifier from string with many features")
    {
        auto maybe_spec = vcpkg::ParsedSpecifier::from_string("zlib[0, 1,2]");
        REQUIRE(maybe_spec.error() == vcpkg::PackageSpecParseResult::SUCCESS);

        auto& spec = *maybe_spec.get();
        REQUIRE(spec.name == "zlib");
        REQUIRE(spec.features.size() == 3);
        REQUIRE(spec.features.at(0) == "0");
        REQUIRE(spec.features.at(1) == "1");
        REQUIRE(spec.features.at(2) == "2");
        REQUIRE(spec.triplet == "");
    }

    SECTION ("parsed specifier wildcard feature")
    {
        auto maybe_spec = vcpkg::ParsedSpecifier::from_string("zlib[*]");
        REQUIRE(maybe_spec.error() == vcpkg::PackageSpecParseResult::SUCCESS);

        auto& spec = *maybe_spec.get();
        REQUIRE(spec.name == "zlib");
        REQUIRE(spec.features.size() == 1);
        REQUIRE(spec.features.at(0) == "*");
        REQUIRE(spec.triplet == "");
    }

    SECTION ("expand wildcards")
    {
        auto zlib = vcpkg::FullPackageSpec::from_string("zlib[0,1]", Triplet::X86_UWP).value_or_exit(VCPKG_LINE_INFO);
        auto openssl =
            vcpkg::FullPackageSpec::from_string("openssl[*]", Triplet::X86_UWP).value_or_exit(VCPKG_LINE_INFO);
        auto specs = FullPackageSpec::to_feature_specs({zlib, openssl});
        Util::sort(specs);
        auto spectargets = FeatureSpec::from_strings_and_triplet(
            {
                "openssl",
                "zlib",
                "openssl[*]",
                "zlib[0]",
                "zlib[1]",
            },
            Triplet::X86_UWP);
        Util::sort(spectargets);

        REQUIRE(specs.size() == spectargets.size());
        REQUIRE(Util::all_equal(specs, spectargets));
    }

#if defined(_WIN32)
    SECTION ("ASCII to utf16")
    {
        auto str = vcpkg::Strings::to_utf16("abc");
        REQUIRE(str == L"abc");
    }

    SECTION ("ASCII to utf16 with whitespace")
    {
        auto str = vcpkg::Strings::to_utf16("abc -x86-windows");
        REQUIRE(str == L"abc -x86-windows");
    }
#endif
}
