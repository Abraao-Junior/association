Rails.application.routes.draw do
  # Dashboard
  get 'dashboard/index'
  
  # Relatório de saldo
  get 'reports/balance'

  # Recursos para pagamentos
  resources :payments

  # Devise para autenticação de usuários
  devise_for :users

  # Recursos para dívidas, excluindo as rotas de editar, atualizar e mostrar
  resources :debts, except: %i(edit update show)

  # Recursos para pessoas, com rota adicional para pesquisa
  resources :people do
    collection do
      get :search
    end
  end

  # Verificador de saúde do aplicativo
  get "up" => "rails/health#show", as: :rails_health_check

  # Página inicial
  root 'dashboard#index'

  # Configuração do Letter Opener Web apenas em ambiente de desenvolvimento
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
