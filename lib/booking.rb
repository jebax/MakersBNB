require_relative 'database_connection'

class Booking
  attr_reader :id, :posting_id, :owner_id, :user_id

  def self.create(posting_id:, owner_id:, user_id:)
    booking = DatabaseConnection.query("INSERT INTO bookings(posting_id, " \
      "owner_id, user_id) VALUES('#{posting_id}', '#{owner_id}', " \
      "'#{user_id}') RETURNING *").first
    create_instance(booking)
  end

  def self.submitted_bookings(current_user_id)
    bookings = DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = '#{current_user_id}'")
    bookings.map do |booking|
      create_instance(booking)
    end
  end

  def self.received_bookings(current_user_id)
    bookings = DatabaseConnection.query("SELECT * FROM bookings WHERE owner_id = '#{current_user_id}'")
    bookings.map do |booking|
      create_instance(booking)
    end
  end

  def self.create_instance(booking)
    Booking.new(id: booking['id'], posting_id: booking['posting_id'],
      owner_id: booking['owner_id'], user_id: booking['user_id'])
  end

  def initialize(id:, posting_id:, owner_id:, user_id:)
    @id = id
    @posting_id = posting_id
    @owner_id = owner_id
    @user_id = user_id
  end

  private_class_method :create_instance
end