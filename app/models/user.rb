class User < ApplicationRecord
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates :username, presence: true, uniqueness: true

  sluggable_column :username

  def two_factor_auth?
    !phone.blank?
  end

  def generate_pin!
    update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    update_column(:pin, nil)
  end

  def send_sms_to_twilio
    # put your own credentials here
    account_sid = 'ACbd6f7235ccfeac70b024f819f83fe0e4'
    auth_token = nil

    # set up a client to talk to the Twilio REST API
    msg = "Your pin is: #{pin}"
    client = Twilio::REST::Client.new account_sid, auth_token
    client.messages.create({
                             :from => '',
                             :to => '+639178422329',
                             :body => msg
                           })
  end
end
