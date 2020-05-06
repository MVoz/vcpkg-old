#include <sql/statement.hpp>
#include <sql/exception.hpp>
#include <sqlite3.h>

namespace sql {
namespace {

static const char empty_text[1] = { '\0' };
static const unsigned char empty_blob[1] = { 0 };

std::string error(sqlite3_stmt* handle) {
  if (const auto str = sqlite3_errmsg(reinterpret_cast<sqlite3*>(handle))) {
    return str;
  }
  return "unknown statement error";
}

}  // namespace

statement::statement() noexcept : handle_(nullptr, sqlite3_finalize) {
}

bool statement::step() {
  data_ = false;
  switch (auto ec = sqlite3_step(handle_.get())) {
  case SQLITE_DONE: break;
  case SQLITE_ROW: data_ = true; break;
  case SQLITE_BUSY: throw exception("step error: timeout reached", query()); break;
  case SQLITE_ERROR: throw exception("step error: " + error(handle_.get()), query()); break;
  case SQLITE_MISUSE: throw exception("step error: " + error(handle_.get()), query()); break;
  default: throw exception("step error: " + error(ec), query()); break;
  }
  return data_;
}

void statement::reset() noexcept {
  if (handle_) {
    sqlite3_reset(handle_.get());
  }
}

void statement::bind(std::size_t index, null) {
  if (auto ec = sqlite3_bind_null(handle_.get(), static_cast<int>(index + 1))) {
    throw exception("bind null error: index " + std::to_string(index) + ": " + error(ec), query());
  }
}

void statement::bind(std::size_t index, integer value) {
  if (auto ec = sqlite3_bind_int64(handle_.get(), static_cast<int>(index + 1), value)) {
    throw exception("bind integer error: index " + std::to_string(index) + ": " + error(ec), query());
  }
}

void statement::bind(std::size_t index, real value) {
  if (auto ec = sqlite3_bind_double(handle_.get(), static_cast<int>(index + 1), value)) {
    throw exception("bind real error: index " + std::to_string(index) + ": " + error(ec), query());
  }
}

void statement::bind(std::size_t index, text value, bool copy) {
  auto data = value.data();
  auto size = value.size();
  if (!data || size == 0) {
    size = 0;
    data = empty_text;
    copy = false;
  }
  auto flags = copy ? SQLITE_TRANSIENT : SQLITE_STATIC;
  if (auto ec = sqlite3_bind_text64(handle_.get(), static_cast<int>(index + 1), data, size, flags, SQLITE_UTF8)) {
    throw exception("bind text error: index " + std::to_string(index) + ": " + error(ec), query());
  }
}

void statement::bind(std::size_t index, blob value, bool copy) {
  auto data = value.data();
  auto size = value.size();
  if (!data) {
    size = 0;
    data = empty_blob;
    copy = false;
  }
  auto flags = copy ? SQLITE_TRANSIENT : SQLITE_STATIC;
  if (auto ec = sqlite3_bind_blob64(handle_.get(), static_cast<int>(index + 1), data, size, flags)) {
    throw exception("bind blob error: index " + std::to_string(index) + ": " + error(ec), query());
  }
}

std::size_t statement::column_count() const noexcept {
  const auto columns = sqlite3_column_count(handle_.get());
  if (columns > 0) {
    return static_cast<std::size_t>(columns);
  }
  return 0;
}

std::string_view statement::column_name(std::size_t index) const noexcept {
  if (auto str = sqlite3_column_name(handle_.get(), static_cast<int>(index))) {
    return str;
  }
  return {};
}

std::string_view statement::column_type(std::size_t index) const noexcept {
#ifndef SQLITE_OMIT_DECLTYPE
  if (auto str = sqlite3_column_decltype(handle_.get(), static_cast<int>(index))) {
    return str;
  }
#endif
  return {};
}

std::string_view statement::column_table(std::size_t index) const noexcept {
#ifdef SQLITE_ENABLE_COLUMN_METADATA
  if (auto str = sqlite3_column_table_name(handle_.get(), static_cast<int>(index))) {
    return str;
  }
#endif
  return {};
}

std::string_view statement::column_origin(std::size_t index) const noexcept {
#ifdef SQLITE_ENABLE_COLUMN_METADATA
  if (auto str = sqlite3_column_origin_name(handle_.get(), static_cast<int>(index))) {
    return str;
  }
#endif
  return {};
}

sql::type statement::type(std::size_t index) const noexcept {
  switch (auto type = sqlite3_column_type(handle_.get(), static_cast<int>(index))) {
  case SQLITE_NULL: return sql::type::null;
  case SQLITE_INTEGER: return sql::type::integer;
  case SQLITE_FLOAT: return sql::type::real;
  case SQLITE_TEXT: return sql::type::text;
  case SQLITE_BLOB: return sql::type::blob;
  }
  return sql::type::null;
}

std::string_view statement::query() const {
  if (auto str = sqlite3_expanded_sql(handle_.get())) {
    return str;
  }
  if (auto str = sqlite3_sql(handle_.get())) {
    return str;
  }
  return {};
}

template <>
null statement::get<null>(std::size_t index) const {
  return nullptr;
}

template <>
integer statement::get<integer>(std::size_t index) const {
  return sqlite3_column_int64(handle_.get(), static_cast<int>(index));
}

template <>
real statement::get<real>(std::size_t index) const {
  return sqlite3_column_double(handle_.get(), static_cast<int>(index));
}

template <>
text statement::get<text>(std::size_t index) const {
  const auto data = sqlite3_column_text(handle_.get(), static_cast<int>(index));
  if (!data) {
    return {};
  }
  const auto size = sqlite3_column_bytes(handle_.get(), static_cast<int>(index));
  if (size < 0) {
    return {};
  }
  return text(reinterpret_cast<const char*>(data), static_cast<std::size_t>(size));
}

template <>
blob statement::get<blob>(std::size_t index) const {
  const auto data = sqlite3_column_blob(handle_.get(), static_cast<int>(index));
  if (!data) {
    return {};
  }
  const auto size = sqlite3_column_bytes(handle_.get(), static_cast<int>(index));
  if (size < 0) {
    return {};
  }
  return blob(reinterpret_cast<const unsigned char*>(data), static_cast<std::size_t>(size));
}

}  // namespace sql
