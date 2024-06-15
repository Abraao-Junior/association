class DashboardService
  def initialize(user)
    @user = user
  end

  def load_data
    {
      active_people_pie_chart: active_people_pie_chart,
      total_debts: total_debts,
      total_payments: total_payments,
      balance: balance,
      last_debts: last_debts,
      last_payments: last_payments,
      my_people: my_people,
      top_person: top_person,
      bottom_person: bottom_person,
      recent_high_value_debts: recent_high_value_debts
    }
  end

  private

  attr_reader :user

  def active_people_pie_chart
    Rails.cache.fetch("active_people_pie_chart", expires_in: 12.hours) do
      {
        active: Person.where(active: true).count,
        inactive: Person.where(active: false).count
      }
    end
  end

  def total_debts
    active_people_ids = Person.where(active: true).pluck(:id)
    Rails.cache.fetch("total_debts_#{active_people_ids.hash}", expires_in: 1.hour) do
      Debt.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def total_payments
    active_people_ids = Person.where(active: true).pluck(:id)
    Rails.cache.fetch("total_payments_#{active_people_ids.hash}", expires_in: 1.hour) do
      Payment.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def balance
    total_payments - total_debts
  end

  def last_debts
    Rails.cache.fetch("last_debts", expires_in: 30.minutes) do
      Debt.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  end

  def last_payments
    Rails.cache.fetch("last_payments", expires_in: 30.minutes) do
      Payment.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  end

  def my_people
    Rails.cache.fetch("my_people_#{user.id}", expires_in: 1.hour) do
      Person.where(user: user).order(:created_at).limit(10)
    end
  end

  def top_person
    people = Person.all.order(balance: :desc)
    people.first
  end

  def bottom_person
    people = Person.all.order(balance: :desc)
    people.last
  end

  def recent_high_value_debts
    Debt.where("amount > 100000")
        .includes(:person)
        .order(created_at: :desc)
        .limit(10)
  end
end
