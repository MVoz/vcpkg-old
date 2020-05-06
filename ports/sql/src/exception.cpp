#include <sql/exception.hpp>
#include <sqlite3.h>

namespace sql {

exception::exception(const std::string& what) : std::runtime_error(what) {
}

exception::exception(const std::string& what, std::string_view query) : std::runtime_error(what) {
  if (!query.empty()) {
    query_ = std::string(query);
  }
}

std::string_view exception::query() const {
  if (query_) {
    return query_.value();
  }
  return {};
}

std::string error(int ec) {
  if (const auto str = sqlite3_errstr(ec)) {
    return str;
  }
  return std::to_string(ec);
}

}  // namespace sql
