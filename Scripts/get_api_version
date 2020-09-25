#!/usr/bin/env ruby

current_date = Time.now
current_month = current_date.month
rounded_month = current_month - ((current_month - 1) % 3)
rounded_date = Time.new(current_date.year, rounded_month, current_date.day)
puts rounded_date.strftime("%Y-%m")
