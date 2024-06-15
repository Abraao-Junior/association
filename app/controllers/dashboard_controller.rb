class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :load_data, only: [:index]

  def index
    # Essas variáveis agora são carregadas pelo serviço no before_action
  end

  private

  def load_data
    # Inicializa o serviço DashboardService com o usuário atual
    data_service = DashboardService.new(current_user)
    data = data_service.load_data
    @active_people_pie_chart = data[:active_people_pie_chart]
    @total_debts = data[:total_debts]
    @total_payments = data[:total_payments]
    @balance = data[:balance]
    @last_debts = data[:last_debts]
    @last_payments = data[:last_payments]
    @my_people = data[:my_people]
    @top_person = data[:top_person]
    @bottom_person = data[:bottom_person]
    @recent_high_value_debts = data[:recent_high_value_debts]
  end
end
