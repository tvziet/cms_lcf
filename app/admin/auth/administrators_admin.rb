# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Trestle.resource(:administrators, model: Administrator, scope: Auth) do
  menu do
    group t('trestle.groups.configuration'), priority: :last do
      item :administrators, icon: 'fa fa-star', label: t('trestle.labels.administrators')
    end
  end

  collection do
    model.includes(:role)
  end

  to_param(&:slug)

  instance do |params|
    model.friendly.find(params[:id])
  end

  table do
    column :id

    column :avatar, align: :center do |administrator|
      avatar_for(administrator)
    end

    column :email, link: true, align: :center

    column :full_name, align: :center

    column :role_id, align: :center do |administrator|
      administrator.role.value(:level, administrator.role.level)
    end

    actions do |a|
      a.edit if a.instance == current_user || current_user.high_level?
      a.delete if current_user.high_level?
    end
  end

  form do
    tab :general_info, label: t('trestle.tabs.general_info') do
      row do
        col(sm: 6) { text_field :email }
        col(sm: 6) { password_field :password }
      end

      row do
        col(sm: 6) { text_field :full_name }
        col(sm: 6) { file_field :avatar }
      end
    end

    tab :role_info, label: t('trestle.tabs.role_info') do
      col(sm: 12) { collection_select(:role_id, Role.all, :id, ->(role) { role.value(:level, role.level) }) }
    end
  end

  # Ignore the password parameters if they are blank
  update_instance do |instance, attrs|
    if attrs[:password].blank?
      attrs.delete(:password)
      attrs.delete(:password_confirmation) if attrs[:password_confirmation].blank?
    end

    instance.assign_attributes(attrs)
  end

  # Log the current user back in if their password was changed
  if Devise.sign_in_after_reset_password
    after_action on: :update do
      login!(instance) if instance == current_user && instance.encrypted_password_previously_changed?
    end
  end
end
# rubocop:enable Metrics/BlockLength
