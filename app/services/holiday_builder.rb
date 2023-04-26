require './app/services/holiday_service.rb'
require 'json'
require './app/poros/holiday.rb'
require 'httparty'

class HolidayBuilder
  def self.service
    HolidayService.new
  end

  def self.next_3_holidays
    Holiday.new(service.holidays)
  end
end