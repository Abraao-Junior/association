class ReportsController < ApplicationController
    before_action :authenticate_user!
  
    def balance
      PersonMailer.balance_report(current_user).deliver_now
      redirect_to root_path, notice: 'Relatório enviado para seu e-mail.'
    end
  
    private
  
    def authenticate_user!
      redirect_to new_user_session_path, alert: 'Você precisa estar logado para acessar essa funcionalidade.' unless current_user
    end
  end
  