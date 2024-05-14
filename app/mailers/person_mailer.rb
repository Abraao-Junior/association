# app/mailers/person_mailer.rb
class PersonMailer < ApplicationMailer
  def balance_report(person)
    @person = person
    mail(to: @person.email, subject: 'Seu Relatório de Balanço')
  end
end
