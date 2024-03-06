# frozen_string_literal: true

Trestle.resource(:employees) do
  menu do
    group t('trestle.groups.resources') do
      item :employees, icon: 'fas fa-users', label: t('trestle.labels.employees')
    end
  end

  # Ignore the password parameters if they are blank
  update_instance do |instance, attrs|
    attrs.delete(:password) if attrs[:password].blank?
    instance.assign_attributes(attrs)
  end

  table do
    column :id
    column :email
    column :full_name
    column :avatar, align: :center do |employee|
      if employee.avatar?
        image_tag(employee.avatar.url, id: 'avatar', loading: 'lazy')
      else
        image_tag('fallback/default.png', id: 'avatar', loading: 'lazy')
      end
    end
    column :age
    column :gender do |employee|
      employee.value(:genders, employee.gender)
    end
    column :address
    column :native_place
    column :tax_code
    column :social_insurance_number
    column :created_at, align: :center do |employee|
      employee.created_at.strftime('%d/%m/%Y')
    end
    column :updated_at, align: :center do |employee|
      employee.updated_at.strftime('%d/%m/%Y')
    end
    actions
  end

  form do |employee|
    tab :personal_info, label: t('trestle.tabs.personal_info') do
      row do
        col(sm: 6) { email_field :email }
        col(sm: 6) { password_field :password }
      end

      row do
        col(sm: 6) { text_field :full_name }
        col(sm: 6) { select(:gender, Employee.values(:genders)) }
      end

      row do
        col(sm: 6) { text_field :address }
        col(sm: 6) { text_field :native_place }
      end

      row do
        col(sm: 6) { text_field :tax_code }
        col(sm: 6) { text_field :social_insurance_number }
      end

      row do
        col(sm: 12) { file_field :avatar }
      end
    end

    tab :work_info, label: t('trestle.tabs.work_info') do
      row do
        col(sm: 6) { select(:working_status, Employee.values(:working_statuses)) }
        col(sm: 6) { text_field :job_title }
      end

      row do
        if employee.persisted?
          col(sm: 6) { content_tag(:strong, 'Phòng ban') }
          col(sm: 6) { employee.groups.includes(:company).map { |group| group&.business_name }.join(', ') }
        end
      end
    end

    tab :contract_info, label: t('trestle.tabs.contract_info') do
      row do
        col(sm: 12) { editor :info_contract }
      end
    end

    sidebar do
      form_group :avatar, label: false do
        if employee.avatar?
          link_to image_tag(employee.avatar.url(:thumb)), employee.avatar_url, data: { behavior: 'zoom' }
        else
          image_tag('fallback/default.png', id: 'employee_default_avatar', loading: 'lazy')
        end
      end
    end
  end

  params do |params|
    params.require(:employee).permit(:email, :password,
                                     :full_name, :gender,
                                     :address, :native_place,
                                     :tax_code, :social_insurance_number,
                                     :avatar,
                                     :working_status, :job_title, :info_contract)
  end
end
