# frozen_string_literal: true

# Customer class
class Customer
  def self.create(name, phone)
    return "Por favor, informe seu nome." if name.nil?
    return "Por favor, informe seu telefone." if phone.nil?

    { id: 1, name: name, phone: phone }
  end
end
