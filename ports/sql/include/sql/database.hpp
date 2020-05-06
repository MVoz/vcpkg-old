#pragma once
#include <sql/statement.hpp>
#include <sql/version.hpp>
#include <atomic>
#include <filesystem>
#include <mutex>

extern "C" {

struct sqlite3;

}  // extern "C"

namespace sql {

enum class flags {
  read = 0x00000001,
  read_write = 0x00000002,
  read_write_create = 0x00000002 | 0x00000004,
};

using database_handle = std::unique_ptr<sqlite3, int (*)(sqlite3*)>;

class module;

class database {
public:
  database();
  database(const std::filesystem::path& filename, flags flags = flags::read_write_create);

  database(database&& other) noexcept;
  database& operator=(database&& other) noexcept;

  ~database();

  template <typename... T>
  statement operator()(std::string_view query, T&&... args) {
    auto statement = prepare(query);
    statement(std::forward<T>(args)...);
    return statement;
  }

  statement prepare(std::string_view query);
  std::size_t changes() const noexcept;

  sql::version version();
  void version(sql::version version);
  void create(const std::string& name, std::unique_ptr<sql::module> module);
  void declare(const std::string& format);

  database_handle& handle() noexcept;
  std::recursive_mutex& mutex() noexcept;

private:
  void begin();
  void commit();
  void rollback();

  class impl;
  std::unique_ptr<impl> impl_;

  friend class transaction;
};

}  // namespace sql
