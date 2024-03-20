# == Schema Information
#
# Table name: carousels
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(FALSE)
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Carousel < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
