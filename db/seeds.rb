# frozen_string_literal: true

puts '... Bắt đầu khởi tạo dữ liệu cho quyền và quản trị viên ...'
Administrator.delete_all
Role.delete_all
role_1 = Role.create(level: 0)
role_2 = Role.create(level: 1)
role_3 = Role.create(level: 2)
Administrator.create!(email: 'tacohu@admin1.com', password: '123123', full_name: 'Tạ Công Huân', role_id: role_3.id)
Administrator.create!(email: 'vietle@admin1.com', password: '123123', full_name: 'Việt Lê', role_id: role_3.id)
Administrator.create!(email: 'dienpham@admin2.com', password: '123123', full_name: 'Diện Phạm', role_id: role_2.id)
Administrator.create!(email: 'test@admin3.com', password: '123123', full_name: 'Low Admin', role_id: role_1.id)
puts '... Khởi tạo thành công dữ liệu cho quyền và quản trị viên ...'
puts '======================================================='

puts '... Bắt đầu khởi tạo dữ liệu cho nhân viên ...'

CompanyEmployee.delete_all
GroupEmployee.delete_all
Employee.delete_all
Employee.create!(email: 'user1@example.com', password: '123123', full_name: 'User 1',
                 dob: '20/06/1995'.to_date, gender: 1,
                 address: '119/29/6 Khu phố 2, Tổ 84, Đường TMT13, Phường Trung Mỹ Tây, Quận 12',
                 native_place: 'Xóm 6, Thôn Hiếu An, Xã Nhơn Khánh, Thị Xã An Nhơn, Tỉnh Bình Định',
                 tax_code: '123123123',
                 social_insurance_number: '345345345',
                 info_contract: 1,
                 working_status: 1,
                 job_title: 'Nhân viên kế toán')
puts '... Khởi tạo thành công dữ liệu cho nhân viên ...'
puts '======================================================='

puts '... Bắt đầu khởi tạo dữ liệu cho công ty và phòng ban ...'
Group.delete_all
Company.delete_all

company_1 = Company.create(name: 'LC Foods')
company_2 = Company.create(name: 'KMS Vina')

group_1 = Group.create(name: 'Nhân sự', company_id: company_1.id)
group_2 = Group.create(name: 'IT', company_id: company_2.id)
puts '... Khởi tạo thành công dữ liệu cho công ty và phòng ban ...'

puts '======================================================='

puts '... Bắt đầu khởi tạo dữ liệu cho cấp tài liệu và tài liệu ...'
Document.delete_all
DocumentLevel.delete_all
lv1 = DocumentLevel.create(id: 1, name: 'Tài liệu cấp 1')
lv2 = DocumentLevel.create(id: 2, name: 'Tài liệu cấp 2')
lv3 = DocumentLevel.create(id: 3, name: 'Tài liệu cấp 3')
lv4 = DocumentLevel.create(id: 4, name: 'Tài liệu cấp 4')

20.times do
  Document.create(title: "Tài liệu cấp 1 - #{Faker::Books::Dune.saying}",
                  body: "Nội dung tài liệu cấp 1 - #{Faker::Books::Dune.saying}",
                  document_level_id: lv1.id,
                  company_id: company_1.id)
  Document.create(title: "Tài liệu cấp 2 - #{Faker::Books::Dune.saying}",
                  body: "Nội dung tài liệu cấp 2 - #{Faker::Books::Dune.saying}",
                  document_level_id: lv2.id,
                  group_ids: [group_1.id,
                  group_2.id])
  Document.create(title: "Tài liệu cấp 3 - #{Faker::Books::Dune.saying}",
                  body: "Nội dung tài liệu cấp 3 - #{Faker::Books::Dune.saying}",
                  document_level_id: lv3.id,
                  group_id: group_1.id)
  Document.create(title: "Tài liệu cấp 4 - #{Faker::Books::Dune.saying}",
                  body: "Nội dung tài liệu cấp 4 - #{Faker::Books::Dune.saying}",
                  document_level_id: lv4.id,
                  company_id: nil,
                  group_id: nil,
                  group_ids: [])
end
puts '... Khởi tạo thành công dữ liệu cho cấp tài liệu và tài liệu ...'

puts '======================================================='
