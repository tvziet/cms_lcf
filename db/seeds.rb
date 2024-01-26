# frozen_string_literal: true

Administrator.delete_all
Administrator.create!(email: 'admin@example.com', password: '123123')
