# frozen_string_literal: true

Trestle.resource(:groups) do
  menu do
    group t('trestle.groups.resources') do
      item :groups, icon: 'fa fa-briefcase', label: t('trestle.labels.groups')
    end
  end

  collection do
    model.includes(:company)
  end

  table do
    column :name

    column :company_id, align: :center do |group|
      group.company.name
    end

    column :created_at, align: :center do |group|
      group.created_at.strftime('%d/%m/%y')
    end

    column :updated_at, align: :center do |group|
      group.updated_at.strftime('%d/%m/%y')
    end

    actions do |toolbar, _instance, admin|
      if (admin&.actions&.include?(:edit) && current_administrator.high_level?) || current_administrator.medium_level?
        toolbar.edit
        toolbar.delete
      end
    end
  end

  form do |group|
    text_field :name

    row do
      col(sm: 12) { collection_select :company_id, Company.all, :id, :name }
    end

    if group.persisted?
      # Assign employees to group's company
      employees = group.employees.presence || []
      group.company.employees = employees

      row do
        employees = employees.presence || Employee.all
        col(sm: 12) { collection_select :employee_ids, employees, :id, :full_name, {}, { multiple: true } }
      end
    end
  end

  params do |params|
    params.require(:group).permit(:name, :company_id, employee_ids: [])
  end
end
