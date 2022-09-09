class ContactMailer < ApplicationMailer
  default from: "aiueo@example.com"
  def send_mail(contact)
    @contact = contact
    mail to: contact.email, subject: 'お問い合わせを受信しました。'
  end
end
