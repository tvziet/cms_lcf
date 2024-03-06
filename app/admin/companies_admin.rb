# frozen_string_literal: true

Trestle.resource(:companies) do
  menu do
    group t('trestle.groups.resources') do
      item :companies, icon: 'fa fa-building', label: t('trestle.labels.companies')
    end
  end

  table do |_company|
    column :name, link: true, sort: :name

    column :num_of_employees, align: :center, header: I18n.t('trestle.headers.num_of_employees') do |company|
      company&.num_of_employees
    end

    column :created_at, align: :center do |company|
      company.created_at.strftime('%d/%m/%Y')
    end

    column :updated_at, align: :center do |company|
      company.updated_at.strftime('%d/%m/%Y')
    end
    actions
  end

  form do |company|
    tab :general_info, label: t('trestle.tabs.general_info') do
      text_field :name
    end

    tab :groups_and_employees_info, label: t('trestle.tabs.groups_and_employees_info') do
      table company.groups, admin: :groups do
        column :name, link: true, header: I18n.t('trestle.headers.groups')
        column :num_of_employees, header: I18n.t('trestle.headers.num_of_employees') do |group|
          group&.num_of_employees
        end
      end
    end
  end

  params do |params|
    params.require(:company).permit(:name)
  end
end
