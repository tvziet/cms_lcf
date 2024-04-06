# frozen_string_literal: true

Trestle.resource(:employees) do
  menu do
    group t('trestle.groups.resources') do
      item :employees, icon: 'fas fa-users', label: t('trestle.labels.employees')
    end
  end

  to_param(&:slug)

  instance do |params|
    model.friendly.find(params[:id])
  end

  # Ignore the password parameters if they are blank
  update_instance do |instance, attrs|
    attrs.delete(:password) if attrs[:password].blank?
    instance.assign_attributes(attrs)
  end

  search do |query|
    query ? collection.searchable(query) : collection
  end

  scopes do
    scope t('trestle.scopes.all'), lambda {
                                     Employee.all
                                   }, label: t('trestle.scopes.all')

    scope t('trestle.scopes.employees.filter_by_male'), lambda {
      Employee.male
    }, label: t('trestle.scopes.employees.filter_by_male')

    scope t('trestle.scopes.employees.filter_by_female'), lambda {
      Employee.female
    }, label: t('trestle.scopes.employees.filter_by_female')

    scope t('trestle.scopes.employees.filter_by_unknown'), lambda {
      Employee.unknown
    }, label: t('trestle.scopes.employees.filter_by_unknown')

    scope t('trestle.scopes.employees.filter_by_inactive'), lambda {
      Employee.inactive
    }, label: t('trestle.scopes.employees.filter_by_inactive')

    scope t('trestle.scopes.employees.filter_by_active'), lambda {
      Employee.active
    }, label: t('trestle.scopes.employees.filter_by_active')
  end

  table do
    column :id

    column :email

    column :full_name

    column :avatar, align: :center do |employee|
      if employee.avatar?
        image_tag(employee.avatar.url, id: 'avatar', loading: 'lazy')
      elsif employee.male?
        image_tag('fallback/default_male.png', id: 'avatar', loading: 'lazy')
      elsif employee.female?
        image_tag('fallback/default_female.png', id: 'avatar', loading: 'lazy')
      end
    end

    column :age

    column :dob, align: :center do |employee|
      employee.dob&.strftime('%d/%m/%Y')
    end

    column :gender do |employee|
      employee.value(:genders, employee.gender)
    end

    column :address

    column :native_place

    column :tax_code

    column :social_insurance_number

    column :phone_number

    column :relative_phone_number

    column :created_at, align: :center do |employee|
      employee.created_at.strftime('%d/%m/%Y')
    end

    column :updated_at, align: :center do |employee|
      employee.updated_at.strftime('%d/%m/%Y')
    end

    actions do |toolbar, _instance, admin|
      if (admin&.actions&.include?(:edit) && current_administrator.high_level?) || current_administrator.medium_level?
        toolbar.edit
        toolbar.delete
      end
    end
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
        col(sm: 6) { file_field :avatar }
        col(sm: 6) { date_field :dob }
      end

      row do
        col(sm: 6) { text_field :phone_number }
        col(sm: 6) { text_field :relative_phone_number }
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
        elsif employee.male?
          image_tag('fallback/default_male.png', data: { behavior: 'zoom' })
        elsif employee.female?
          image_tag('fallback/default_female.png', data: { behavior: 'zoom' })
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
