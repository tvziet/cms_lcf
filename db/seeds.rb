# frozen_string_literal: true

Administrator.delete_all
Administrator.create!(email: 'admin@example.com', password: '123123')

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
