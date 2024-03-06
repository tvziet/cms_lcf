# frozen_string_literal: true

Trestle.resource(:employees) do
  menu do
    item :employees, icon: 'fas fa-users', label: t('trestle.labels.employees')
  end

  # Ignore the password parameters if they are blank
  update_instance do |instance, attrs|
    attrs.delete(:password) if attrs[:password].blank?
    instance.assign_attributes(attrs)
  end

  controller do
    def groups_for_company
      company = Company.find_by(id: params[:company_id])
      groups = company&.groups

      render json: groups.map { |group| { id: group.id, name: group.name } }
    end

    def companies
      companies = Company.all
      render json: companies.map { |company| { id: company.id, name: company.name } }
    end

    def groups
      groups = Company.first.groups
      render json: groups.map { |group| { id: group.id, name: group.name } }
    end

    def delete
      ActiveRecord::Base.transaction do
        CompanyEmployee.find_by(id: params[:company_id]).destroy if params[:company_id]
        GroupEmployee.find_by(group_id: params[:group_id]).destroy if params[:group_id]
      end
    end

    def update
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash[:message] = "Pike cac to"
        redirect_to employees_admin_index_path
      else
        render :new
      end
    end

    private

    def employee_params
      params.require(:employee).permit(:email,
                                       :full_name, :gender,
                                       :address, :native_place,
                                       :tax_code, :social_insurance_number,
                                       :avatar,
                                       :working_status, :job_title, :info_contract,
                                       company_employees_attributes: %i[id company_id _destroy],
                                       group_employees_attributes: %i[id group_id _destroy]).tap do |whitelisted|
        whitelisted[:password] = params[:employee][:password] if params[:employee][:password].present?
      end
    end
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
        col(sm: 4) do
          link_to t('links.add_companies_and_groups'), '#', id: 'add_company_and_group'
        end
      end

      row(class: 'your-class-name') do
        col(sm: 4) do
          content_tag(:div, id: 'companies') do
            fields_for :company_employees, employee.company_employees || employee.build_company_employees do |company_employee|
              company_employee.select :company_id, Company.all.map { |company| [company.name, company.id] },
                                      selected: company_employee.object.company_id, label: t('trestle.labels.companies')
            end
          end
        end

        col(sm: 4) do
          content_tag :div, id: 'groups' do
            fields_for :group_employees, employee.group_employees || employee.build_group_employees do |group_employee|
              selected_company_id = Group.find(group_employee.object.group_id)&.company_id
              group_employee.select :group_id, Group.where(company_id: selected_company_id).map { |group| [group.name, group.id] },
                                    selected: group_employee.object.group_id, label: t('trestle.labels.groups')
            end
          end
        end

        col(sm: 2) do
          content_tag :div, id: 'groups' do
            (employee.group_employees.presence || [employee.group_employees.build]).each_with_index do |group_employee, index|
              selected_company_id = group_employee.group_id && Group.find(group_employee.group_id).company_id
              fields_for :group_employees, group_employee do |ge|
                ge.select :group_id, Group.where(company_id: selected_company_id).map { |group| [group.name, group.id] },
                          selected: group_employee.group_id, label: t('trestle.labels.groups')

                company_employee = employee.company_employees[index]
                link_to 'Delete', '#', class: "delete-button", data: { company_id: company_employee&.id, index: index, group_id: group_employee.group_id }
              end
            end
          end
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

  # update_instance do |instance, attrs|
  #   if attrs[:company_employees_attributes]
  #     permitted_ids = CompanyEmployee.where(id: attrs[:company_employees_attributes].values.map { |attr| attr[:id] }).pluck(:id)
  #     attrs[:company_employees_attributes].delete_if do |_, company_employee_attrs|
  #       !permitted_ids.include?(company_employee_attrs["id"].to_i)
  #     end
  #   end

  #   attrs.delete(:password) if attrs[:password].blank?
  #   instance.assign_attributes(attrs)
  # end

  params do |params|
    params.require(:employee).permit(:email, :password,
                                     :full_name, :gender,
                                     :address, :native_place,
                                     :tax_code, :social_insurance_number,
                                     :avatar,
                                     :working_status, :job_title, :info_contract,
                                     company_employees_attributes: %i[id company_id],
                                     group_employees_attributes: %i[id group_id])
  end

  routes do
    collection do
      get :groups_for_company
      get :companies
      get :groups
    end
    member do
      delete :delete
    end
  end
end
