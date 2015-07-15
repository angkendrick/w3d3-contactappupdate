require 'active_record'

class Contact < ActiveRecord::Base

  def to_s
    puts "#{id} - #{first_name} - #{last_name} - #{email}"
  end

end