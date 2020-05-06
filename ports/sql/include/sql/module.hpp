#pragma once
#include <sql/types.hpp>
#include <memory>
#include <optional>
#include <vector>

extern "C" {

struct sqlite3_index_info;

}  // extern "C"

namespace sql {

class cursor {
public:
  virtual ~cursor() = default;

  // Filters results.
  virtual void filter(const char* str, const std::vector<sql::value>& values) = 0;

  // Advances cursor.
  virtual void next() = 0;

  // Checks if the end was reached.
  virtual bool eof() = 0;

  // Retrieves value from current row.
  virtual sql::value column(std::size_t index) = 0;

  // Returns current row id.
  virtual std::int64_t id() = 0;
};

class table {
public:
  virtual ~table() = default;

  // Prepares statement.
  virtual sql::code index(sqlite3_index_info* info) = 0;

  // Creates a new cursor.
  virtual std::unique_ptr<sql::cursor> open() = 0;

  // Removes row (only used if the table module is writable).
  virtual sql::code remove(std::int64_t id) {
    return sql::code::error;
  }

  // Inserts row (only used if the table module is writable).
  virtual sql::code insert(const std::vector<sql::value>& values, std::int64_t& id) {
    return sql::code::error;
  }

  // Updates row (only used if the table module is writable).
  virtual sql::code update(std::int64_t id, const std::vector<sql::value>& values) {
    return sql::code::error;
  }
};

class module {
public:
  virtual ~module() = default;

  // Created tables are writable.
  virtual bool writable() {
    return false;
  }

  // Creates a new table.
  virtual std::unique_ptr<sql::table> create(std::string_view name, std::vector<std::string_view> args) = 0;
};

}  // namespace sql
