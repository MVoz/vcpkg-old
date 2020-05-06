#pragma once
#include <ostream>
#include <string>
#include <cstdint>
#include <cstdio>

#ifdef major
#undef major
#endif

#ifdef minor
#undef minor
#endif

namespace sql {

class version {
public:
  constexpr version() = default;
  constexpr explicit version(std::uint32_t value) : value_(value) {
  }
  constexpr explicit version(std::uint32_t major, std::uint32_t minor, std::uint32_t patch) :
    value_((major << 24) + (minor << 16) + patch) {
  }

  explicit version(const std::string& str) {
    unsigned long major = 0;
    unsigned long minor = 0;
    unsigned long patch = 0;
    std::sscanf(str.data(), "%lu.%lu.%lu", &major, &minor, &patch);
    value_ = (major << 24) + (minor << 16) + patch;
  }

  constexpr operator bool() const {
    return value_ != 0x0;
  }

  constexpr std::uint32_t major() const {
    return value_ >> 24;
  }

  constexpr std::uint32_t minor() const {
    return value_ >> 16 & 0xFF;
  }

  constexpr std::uint32_t patch() const {
    return value_ & 0xFFFF;
  }

  constexpr std::uint32_t value() const {
    return value_;
  }

  friend constexpr bool operator==(const version& lhs, const version& rhs) {
    return lhs.value_ == rhs.value_;
  }

  friend constexpr bool operator!=(const version& lhs, const version& rhs) {
    return lhs.value_ != rhs.value_;
  }

  friend constexpr bool operator<(const version& lhs, const version& rhs) {
    return lhs.value_ < rhs.value_;
  }

  friend constexpr bool operator>(const version& lhs, const version& rhs) {
    return lhs.value_ > rhs.value_;
  }

  friend constexpr bool operator<=(const version& lhs, const version& rhs) {
    return lhs.value_ <= rhs.value_;
  }

  friend constexpr bool operator>=(const version& lhs, const version& rhs) {
    return lhs.value_ >= rhs.value_;
  }

private:
  std::uint32_t value_ = 0x0;
};

inline std::ostream& operator<<(std::ostream& os, const version& v) {
  return os << static_cast<unsigned>(v.major()) << '.' << static_cast<unsigned>(v.minor()) << '.' << v.patch();
}

}  // namespace sql
