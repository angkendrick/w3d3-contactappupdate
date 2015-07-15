require_relative 'contact'
require 'active_record'

class ContactApp 

  def self.create_a_contact
    puts "First Name"
    first_name = gets.chomp()
    puts "Last Name"
    last_name = gets.chomp()
    puts "Email"
    email = gets.chomp()

    Contact.create(first_name: first_name, last_name: last_name, email: email)

  end

  def self.retrieve_all_contacts
    contact_results = Contact.all # retrieve all contacts
    contact_results.each do |contact|
      puts contact
    end
  end

  def self.destroy(id) # delete a contact by id
    contact = Contact.find_by(id: id)
    puts "#{contact.first_name} deleted"
    contact.destroy
  end

  def self.destroy_agent # sets up the destroy method
    puts "enter id number"
    id = gets.chomp()
    ContactApp.destroy(id)
  end

  def self.find_contact(type, string) # type = id / first / last / email
    contact = nil
    case type
    when 'id'
      string = string.to_i
      contact = Contact.find_by(id: string)
    when 'first'
      contact = Contact.find_by(first_name: string)
    when 'last'
      contact = Contact.find_by(last_name: string)
    when 'email'
      contact = Contact.find_by(email: string)
    end
    puts contact 
  end

  def self.find_contact_agent # sets up the find_contact method
    puts "id / first / last / email"
    type = gets.chomp()
    puts "enter search string"
    string = gets.chomp()

    ContactApp.find_contact(type, string)
  end

  def self.main_menu
    puts "create / show / find / delete"
    case gets.chomp().downcase
    when 'create'
      ContactApp.create_a_contact
    when 'show'
      ContactApp.retrieve_all_contacts
    when 'find'
      ContactApp.find_contact_agent
    when 'delete'
      ContactApp.destroy_agent
    end
  end

  puts 'Establishing connection to database ...'
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    database: 'contacts',
    username: 'development',
    password: 'development',
    host: 'localhost',
    port: 5432,
    pool: 5,
    encoding: 'unicode',
    min_messages: 'error'
  )
  puts 'CONNECTED'

  main_menu

end