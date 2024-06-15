puts "Destroying existing records..."
User.destroy_all
Debt.destroy_all
Person.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

1000.times do |counter|
  puts "Creating user #{counter}"
  User.create email: Faker::Internet.email, password: '111111'
end

100000.times do |counter|
  puts "Inserting Person #{counter}"

  attrs = {
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: CPF.generate,
    active: [true, false].sample,
    user: User.order('random()').first
  }
  person = Person.create(attrs)


  # 5.times do |debt_counter|
  #   puts "Inserting Debt #{debt_counter}"
  #   person.debts.create(
  #     amount: Faker::Number.between(from: 1, to: 200),
  #     observation: Faker::Lorem.paragraph
  #   )

  
  #   puts "Inserting Paym #{debt_counter}"
  #   person.payments.create(
  #     amount: Faker::Number.between(from: 1, to: 200),
  #     paid_at: Time.at(rand * Time.now.to_i)
  #     )

  
  200.times do |counter|
    puts "Inserting High Value Debt #{counter + 1}"
    Debt.create(
      amount: Faker::Number.between(from: 100_000, to: 200_000),
      person: Person.order('RANDOM()').first,
      observation: Faker::Lorem.paragraph
    )
  end
end
