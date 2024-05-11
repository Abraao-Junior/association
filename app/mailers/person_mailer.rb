class PersonMailer < ApplicationMailer
    def balance_report(user)
      @user = user
      mail(to: @user.email, subject: 'Seu Relatório de Saldo')
    end
  end
  