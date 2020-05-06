#pragma once
#include <sql/exception.hpp>
#include <sql/types.hpp>
#include <chrono>

// Possible duration and time point storage types.
//
// seconds      can store +/- 292277024626 years
// milliseconds can store +/- 292277024 years
// microsecond  can store +/- 292277 years
// nanosecond   can store +/- 292 years
//

// If this macro is not defined, durations will be stored as text with milliseconds precision.
//#define SQL_DURATION_STORAGE std::chrono::milliseconds

// If this macro is not defined, time points will be stored as text with milliseconds precision.
//#define SQL_TIME_POINT_STORAGE std::chrono::milliseconds

#if !defined(SQL_TIME_POINT_STORAGE) || !defined(SQL_DURATION_STORAGE)
#include <date/serialize.h>
#endif

namespace sql {

#ifdef SQL_TIME_POINT_STORAGE
using time_point_storage = SQL_TIME_POINT_STORAGE;
#endif

#ifdef SQL_DURATION_STORAGE
using duration_storage = SQL_DURATION_STORAGE;
#endif

template <typename Rep, typename Period>
struct traits<std::chrono::duration<Rep, Period>> {
  static void set(sql::column& column, std::chrono::duration<Rep, Period> value) {
#ifdef SQL_DURATION_STORAGE
    column.set(std::chrono::duration_cast<duration_storage>(value).count());
#else
    column.set(date::format(value));
#endif
  }
  static std::chrono::duration<Rep, Period> get(const sql::column& column) {
#ifdef SQL_DURATION_STORAGE
    return std::chrono::duration_cast<std::chrono::duration<Rep, Period>>(
      duration_storage(column.get<duration_storage::rep>()));
#else
    return date::parse_duration<Rep, Period>(column.template get<std::string>());
#endif
  }
};

template <typename Clock, typename Duration>
struct traits<std::chrono::time_point<Clock, Duration>> {
  static void set(sql::column& column, const std::chrono::time_point<Clock, Duration>& value) {
#ifdef SQL_TIME_POINT_STORAGE
    const auto d = value.time_since_epoch();
    column.set(std::chrono::duration_cast<typename time_point_storage::duration>(d).count());
#else
    column.set(date::format(value));
#endif
  }
  static std::chrono::time_point<Clock, Duration> get(const sql::column& column) {
#ifdef SQL_TIME_POINT_STORAGE
    const auto d = time_point_storage(column.get<time_point_storage::rep>());
    return std::chrono::time_point<Clock, Duration>(std::chrono::duration_cast<typename Duration>(d));
#else
    return date::parse_time_point<Clock, Duration>(column.template get<std::string>());
#endif
  }
};

template <>
struct traits<date::day> {
  static void set(sql::column& column, const date::day& value) {
    column.set(static_cast<unsigned>(value));
  }
  static date::day get(const sql::column& column) {
    return date::day(column.get<unsigned>());
  }
};

template <>
struct traits<date::weekday> {
  static void set(sql::column& column, const date::weekday& value) {
    column.set(static_cast<unsigned>(value));
  }
  static date::weekday get(const sql::column& column) {
    return date::weekday(column.get<unsigned>());
  }
};

template <>
struct traits<date::month> {
  static void set(sql::column& column, const date::month& m) {
    column.set(static_cast<unsigned>(m));
  }
  static date::month get(const sql::column& column) {
    return date::month(column.get<unsigned>());
  }
};

template <>
struct traits<date::year> {
  static void set(sql::column& column, const date::year& y) {
    column.set(static_cast<int>(y));
  }
  static date::year get(const sql::column& column) {
    return date::year(column.get<int>());
  }
};

template <>
struct traits<date::weekday_indexed> {
  static void set(sql::column& column, const date::weekday_indexed& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::weekday_indexed get(const sql::column& column) {
    return date::parse_weekday_indexed(column.get<std::string>());
  }
};

template <>
struct traits<date::weekday_last> {
  static void set(sql::column& column, const date::weekday_last& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::weekday_last get(const sql::column& column) {
    return date::parse_weekday_last(column.get<std::string>());
  }
};

template <>
struct traits<date::month_day> {
  static void set(sql::column& column, const date::month_day& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::month_day get(const sql::column& column) {
    return date::parse_month_day(column.get<std::string>());
  }
};

template <>
struct traits<date::month_day_last> {
  static void set(sql::column& column, const date::month_day_last& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::month_day_last get(const sql::column& column) {
    return date::parse_month_day_last(column.get<std::string>());
  }
};

template <>
struct traits<date::month_weekday> {
  static void set(sql::column& column, const date::month_weekday& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::month_weekday get(const sql::column& column) {
    return date::parse_month_weekday(column.get<std::string>());
  }
};

template <>
struct traits<date::month_weekday_last> {
  static void set(sql::column& column, const date::month_weekday_last& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::month_weekday_last get(const sql::column& column) {
    return date::parse_month_weekday_last(column.get<std::string>());
  }
};

template <>
struct traits<date::year_month> {
  static void set(sql::column& column, const date::year_month& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::year_month get(const sql::column& column) {
    return date::parse_year_month(column.get<std::string>());
  }
};

template <>
struct traits<date::year_month_day> {
  static void set(sql::column& column, const date::year_month_day& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::year_month_day get(const sql::column& column) {
    return date::parse_year_month_day(column.get<std::string>());
  }
};

template <>
struct traits<date::year_month_day_last> {
  static void set(sql::column& column, const date::year_month_day_last& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::year_month_day_last get(const sql::column& column) {
    return date::parse_year_month_day_last(column.get<std::string>());
  }
};

template <>
struct traits<date::year_month_weekday> {
  static void set(sql::column& column, const date::year_month_weekday& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::year_month_weekday get(const sql::column& column) {
    return date::parse_year_month_weekday(column.get<std::string>());
  }
};

template <>
struct traits<date::year_month_weekday_last> {
  static void set(sql::column& column, const date::year_month_weekday_last& value) {
    std::ostringstream oss;
    oss << value;
    column.set(oss.str());
  }
  static date::year_month_weekday_last get(const sql::column& column) {
    return date::parse_year_month_weekday_last(column.get<std::string>());
  }
};

}  // namespace sql
