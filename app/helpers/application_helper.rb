# frozen_string_literal: true

module ApplicationHelper
  def time_since(time)
    passed_time = (Time.zone.now - time).round

    return 'たった今' if passed_time < 60

    days = passed_time / (60 * 60 * 24)
    return "#{days}日前" if days.positive?

    hours = passed_time / (60 * 60)
    return "#{hours}時間前" if hours.positive?

    minutes = passed_time / 60
    return "#{minutes}分前" if minutes.positive?

    "#{passed_time}秒前"
  end
end
