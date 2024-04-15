# == Schema Information
#
# Table name: footers
#
#  id                   :bigint           not null, primary key
#  company_address_info :string
#  company_email        :string
#  company_info         :string
#  company_phone        :string
#  logo                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Footer < ApplicationRecord
  mount_uploader :logo, ImageUploader
end
