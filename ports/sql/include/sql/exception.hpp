#pragma once
#include <stdexcept>
#include <memory>
#include <optional>
#include <string>
#include <string_view>

namespace sql {

class exception : public std::runtime_error {
public:
  explicit exception(const std::string& what);
  explicit exception(const std::string& what, std::string_view query);

  std::string_view query() const;

private:
  std::optional<std::string> query_;
};

std::string error(int ec);

}  // namespace sql
