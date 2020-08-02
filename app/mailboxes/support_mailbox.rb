class SupportMailbox < ApplicationMailbox
  def process
    recent_order = Order.where(email: mail.from_address.to_s ).
                   order('created_at desc').first

    SupportRequest.create!(email: mail.from_address.to_s,
                          subject: mail.subject,
                          order: recent_order,
                          body: mail.body.to_s)
    puts "Start SupportMailBox process"
    puts "FROM:  #{mail.from_address}"
    puts "Subject:  #{mail.subject}"
    puts "Body:  #{mail.body}"
    puts "END SupportMailbox#process:"
  end
end
