#include <sql/database.hpp>
#include <sql/exception.hpp>
#include <sql/lock.hpp>
#include <sql/module.hpp>
#include <ice/log.hpp>
#include <sqlite3.h>
#include <limits>
#include <sstream>
#include <vector>

#ifdef NDEBUG
#define SQL_NOEXCEPT noexcept
#else
#define SQL_NOEXCEPT
#endif

namespace sql {
namespace {

std::string error(sqlite3* handle) {
  if (const auto str = sqlite3_errmsg(handle)) {
    return str;
  }
  return "unknown database error";
}

struct table_impl;

struct cursor_impl : public sqlite3_vtab_cursor {
  cursor_impl(std::unique_ptr<sql::cursor> impl, table_impl* parent) : impl(std::move(impl)), parent(parent) {
  }
  std::unique_ptr<sql::cursor> impl;
  table_impl* parent;
};

struct module_impl;

struct table_impl : public sqlite3_vtab {
  table_impl(std::unique_ptr<sql::table> impl, module_impl* parent) : impl(std::move(impl)), parent(parent) {
  }
  std::unique_ptr<sql::table> impl;
  module_impl* parent;
};

struct module_impl : public sqlite3_module {
  module_impl(std::unique_ptr<sql::module> impl) : sqlite3_module({}), impl(std::move(impl)) {
    //
    // Version number.
    //

    iVersion = 1;

    //
    // Required module methods.
    //

    xCreate = [](sqlite3* db, void* module, int argc, const char* const* argv, sqlite3_vtab** table, char** error)
                SQL_NOEXCEPT {
#ifdef NDEBUG
                  try {
#endif
                    auto name = std::string_view(argv[0]);
                    auto args = std::vector<std::string_view>();
                    for (int i = 1; i < argc; i++) {
                      args.emplace_back(argv[i]);
                    }
                    auto self = static_cast<module_impl*>(module);
                    auto impl = self->impl->create(name, std::move(args));
                    if (!impl) {
                      return SQLITE_NOMEM;
                    }
                    *table = std::make_unique<table_impl>(std::move(impl), self).release();
#ifdef NDEBUG
                  }
                  catch (const std::exception& e) {
                    ice::log::error() << "virtual table create error: " << e.what();
                    return SQLITE_INTERNAL;
                  }
                  catch (...) {
                    ice::log::error() << "virtual table create error";
                    return SQLITE_INTERNAL;
                  }
#endif
                  return SQLITE_OK;
                };

    xConnect = xCreate;

    //
    // Required table methods.
    //

    xBestIndex = [](sqlite3_vtab* table, sqlite3_index_info* info) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<table_impl*>(table);
        return static_cast<int>(self->impl->index(info));
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::error() << "virtual table index error: " << e.what();
        return SQLITE_INTERNAL;
      }
      catch (...) {
        ice::log::error() << "virtual table index error";
        return SQLITE_INTERNAL;
      }
#endif
      return SQLITE_OK;
    };

    xDisconnect = [](sqlite3_vtab* table) SQL_NOEXCEPT {
      auto self = static_cast<table_impl*>(table);
      self->impl.reset();
      delete self;
      return SQLITE_OK;
    };

    xDestroy = xDisconnect;

    xOpen = [](sqlite3_vtab* table, sqlite3_vtab_cursor** cursor) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<table_impl*>(table);
        auto impl = self->impl->open();
        if (!impl) {
          return SQLITE_NOMEM;
        }
        *cursor = std::make_unique<cursor_impl>(std::move(impl), self).release();
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::error() << "virtual table open cursor error: " << e.what();
        return SQLITE_INTERNAL;
      }
      catch (...) {
        ice::log::error() << "virtual table open cursor error";
        return SQLITE_INTERNAL;
      }
#endif
      return SQLITE_OK;
    };

    //
    // Required cursor methods.
    //

    xClose = [](sqlite3_vtab_cursor* cursor) SQL_NOEXCEPT {
      auto self = static_cast<cursor_impl*>(cursor);
      self->impl.reset();
      delete self;
      return SQLITE_OK;
    };

    xFilter = [](sqlite3_vtab_cursor* cursor, int index, const char* str, int argc, sqlite3_value** argv) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<cursor_impl*>(cursor);
        self->impl->filter(str, get(argc, argv));
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::error() << "virtual table cursor filter error: " << e.what();
        return SQLITE_INTERNAL;
      }
      catch (...) {
        ice::log::error() << "virtual table cursor filter error";
        return SQLITE_INTERNAL;
      }
#endif
      return SQLITE_OK;
    };

    xNext = [](sqlite3_vtab_cursor* cursor) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<cursor_impl*>(cursor);
        self->impl->next();
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::error() << "virtual table cursor next error: " << e.what();
        return SQLITE_INTERNAL;
      }
      catch (...) {
        ice::log::error() << "virtual table cursor next error";
        return SQLITE_INTERNAL;
      }
#endif
      return SQLITE_OK;
    };

    xEof = [](sqlite3_vtab_cursor* cursor) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<cursor_impl*>(cursor);
        return self->impl->eof() ? 1 : 0;
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::warning() << "virtual table cursor eof error: " << e.what();
      }
      catch (...) {
        ice::log::warning() << "virtual table cursor eof error";
      }
      return 1;
#endif
    };

    xColumn = [](sqlite3_vtab_cursor* cursor, sqlite3_context* context, int index) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<cursor_impl*>(cursor);
        return set(context, self->impl->column(index));
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::error() << "virtual table cursor column error: " << e.what();
        return SQLITE_INTERNAL;
      }
      catch (...) {
        ice::log::error() << "virtual table cursor column error";
        return SQLITE_INTERNAL;
      }
#endif
      return SQLITE_OK;
    };

    xRowid = [](sqlite3_vtab_cursor* cursor, sqlite3_int64* id) SQL_NOEXCEPT {
#ifdef NDEBUG
      try {
#endif
        auto self = static_cast<cursor_impl*>(cursor);
        *id = self->impl->id();
#ifdef NDEBUG
      }
      catch (const std::exception& e) {
        ice::log::error() << "virtual table cursor id error: " << e.what();
        return SQLITE_INTERNAL;
      }
      catch (...) {
        ice::log::error() << "virtual table cursor id error";
        return SQLITE_INTERNAL;
      }
#endif
      return SQLITE_OK;
    };

    //
    // Optional table methods.
    //

    if (this->impl->writable()) {
      xUpdate = [](sqlite3_vtab* table, int argc, sqlite3_value** argv, sqlite3_int64* id) SQL_NOEXCEPT {
#ifdef NDEBUG
        try {
#endif
          auto self = static_cast<table_impl*>(table);
          if (argc < 1) {
            return SQLITE_MISUSE;
          }

          // Process delete request.
          if (argc == 1) {
            return static_cast<int>(self->impl->remove(sqlite3_value_int64(argv[0])));
          }

          // Process insert request.
          if (sqlite3_value_type(argv[0]) == SQLITE_NULL) {
            auto tmp = static_cast<std::int64_t>(*id);
            return static_cast<int>(self->impl->insert(get(argc - 2, argv + 2), tmp));
            *id = static_cast<sqlite3_int64>(tmp);
          }

          // Process update request.
          return static_cast<int>(self->impl->update(*id = sqlite3_value_int64(argv[0]), get(argc - 2, argv + 2)));
#ifdef NDEBUG
        }
        catch (const std::exception& e) {
          ice::log::error() << "virtual table update error: " << e.what();
          return SQLITE_INTERNAL;
        }
        catch (...) {
          ice::log::error() << "virtual table update error";
          return SQLITE_INTERNAL;
        }
#endif
        return SQLITE_OK;
      };
    }

    //xBegin = [](sqlite3_vtab* table) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xSync = [](sqlite3_vtab* table) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xCommit = [](sqlite3_vtab* table) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xRollback = [](sqlite3_vtab* table) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xFindFunction = [](sqlite3_vtab* table, int arg, const char* name, void(**callback)(sqlite3_context* context, int, sqlite3_value** value), void** args) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xRename = [](sqlite3_vtab* table, const char* name) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xSavepoint = [](sqlite3_vtab* table, int index) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xRelease = [](sqlite3_vtab* table, int index) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};

    //xRollbackTo = [](sqlite3_vtab* table, int index) SQL_NOEXCEPT {
    //  auto self = static_cast<table_impl*>(table);
    //  return SQLITE_OK;
    //};
  }

  static std::vector<sql::value> get(int argc, sqlite3_value** argv) {
    std::vector<sql::value> values;
    for (int i = 0; i < argc; i++) {
      const auto arg = argv[i];
      switch (sqlite3_value_type(arg)) {
      case SQLITE_NULL: values.emplace_back(null()); break;
      case SQLITE_INTEGER: values.emplace_back(static_cast<integer>(sqlite3_value_int64(arg))); break;
      case SQLITE_FLOAT: values.emplace_back(sqlite3_value_double(arg)); break;
      case SQLITE_TEXT: {
        const auto data = reinterpret_cast<const char*>(sqlite3_value_text(arg));
        const auto size = static_cast<std::size_t>(sqlite3_value_bytes(arg));
        values.emplace_back(text(data, size));
      } break;
      case SQLITE_BLOB: {
        const auto data = reinterpret_cast<const unsigned char*>(sqlite3_value_blob(arg));
        const auto size = static_cast<std::ptrdiff_t>(sqlite3_value_bytes(arg));
        values.emplace_back(blob(data, size));
      } break;
      }
    }
    return values;
  }

  static int set(sqlite3_context* context, const sql::value& value) {
    switch (value.index()) {
    case 0: sqlite3_result_null(context); break;
    case 1: sqlite3_result_int64(context, std::get<1>(value)); break;
    case 2: sqlite3_result_double(context, std::get<2>(value)); break;
    case 3:
      sqlite3_result_text(context, std::get<3>(value).data(), static_cast<int>(std::get<3>(value).size()), nullptr);
      break;
    case 4:
      sqlite3_result_blob(context, std::get<4>(value).data(), static_cast<int>(std::get<4>(value).size()), nullptr);
      break;
    default: return SQLITE_INTERNAL;
    }
    return SQLITE_OK;
  }

private:
  std::unique_ptr<sql::module> impl;
};

void module_destructor(void* module) {
  delete static_cast<module_impl*>(module);
}

}  // namespace

class database::impl {
public:
  database_handle handle = database_handle(nullptr, sqlite3_close);
  statement begin;
  statement commit;
  statement rollback;
  std::recursive_mutex mutex;
  std::atomic<int> transaction = { 0 };
};

database::database() : impl_(std::make_unique<impl>()) {
}

database::database(const std::filesystem::path& filename, flags flags) : database() {
  sqlite3* handle = nullptr;
  auto ec = sqlite3_open_v2(filename.u8string().data(), &handle, static_cast<int>(flags), nullptr);
  if (ec != SQLITE_OK) {
    sqlite3_close(handle);
    throw exception("open error: " + error(ec) + ": " + filename.u8string());
  }
  impl_->handle.reset(handle);
  impl_->begin = prepare("BEGIN");
  impl_->commit = prepare("COMMIT");
  impl_->rollback = prepare("ROLLBACK");
}

database::database(database&& other) noexcept : impl_(std::move(other.impl_)) {
}

database& database::operator=(database&& other) noexcept {
  impl_ = std::move(other.impl_);
  return *this;
}

database::~database() {
}

statement database::prepare(std::string_view query) {
  const auto data = query.data();
  const auto size = query.size();
  if (size > static_cast<std::size_t>(std::numeric_limits<int>::max())) {
    throw exception("query size error");
  }
  sqlite3_stmt* handle = nullptr;
  if (sqlite3_prepare_v2(impl_->handle.get(), data, static_cast<int>(size), &handle, nullptr) != SQLITE_OK) {
    sqlite3_finalize(handle);
    throw exception("prepare error: " + error(impl_->handle.get()), query);
  }
  statement stmt;
  stmt.handle().reset(handle);
  return stmt;
}

std::size_t database::changes() const noexcept {
  const auto changes = sqlite3_changes(impl_->handle.get());
  if (changes > 0) {
    return static_cast<std::size_t>(changes);
  }
  return 0;
}

sql::version database::version() {
  if (impl_) {
    std::lock_guard<std::recursive_mutex> lock(impl_->mutex);
    if (const auto& row = operator()("PRAGMA user_version")) {
      return sql::version(row.get<std::uint32_t>(0));
    }
  }
  return {};
}

void database::version(sql::version version) {
  std::ostringstream oss;
  oss << static_cast<std::int64_t>(version.value());
  std::lock_guard<std::recursive_mutex> lock(impl_->mutex);
  operator()("PRAGMA user_version = " + oss.str());
}

void database::create(const std::string& name, std::unique_ptr<sql::module> module) {
  if (!module) {
    return;
  }
  auto ptr = std::make_unique<module_impl>(std::move(module));
  if (sqlite3_create_module_v2(impl_->handle.get(), name.data(), ptr.get(), ptr.get(), module_destructor) !=
    SQLITE_OK) {
    throw exception("failed to create module: " + name);
  }
  ptr.release();
}

void database::declare(const std::string& format) {
  auto ec = sqlite3_declare_vtab(impl_->handle.get(), format.c_str());
  if (ec != SQLITE_OK) {
    throw exception("table format error: " + error(ec), format);
  }
}

database_handle& database::handle() noexcept {
  return impl_->handle;
}

std::recursive_mutex& database::mutex() noexcept {
  return impl_->mutex;
}

void database::begin() {
  if (impl_->transaction.fetch_add(1) == 0) {
    impl_->begin();
  }
}

void database::commit() {
  if (impl_->transaction.fetch_sub(1) == 1) {
    impl_->commit();
  }
}

void database::rollback() {
  if (impl_->transaction.fetch_sub(1) == 1) {
    impl_->rollback();
  }
}

}  // namespace sql
