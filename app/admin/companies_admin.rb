# frozen_string_literal: true

Trestle.resource(:companies) do
  menu do
    item :companies, icon: 'fa fa-building', label: t('trestle.labels.companies')
  end


  table do
    column :name, link: true, sort: :name

    column :num_of_employees, align: :center, header: I18n.t('trestle.headers.num_of_employees') do |company|
      company.num_of_employees
    end

    column :created_at, align: :center do |company|
      company.created_at.strftime('%d/%m/%Y')
    end

    column :updated_at, align: :center do |company|
      company.updated_at.strftime('%d/%m/%Y')
    end
    actions
  end

  form do
    text_field :name
  end

  params do |params|
    params.require(:company).permit(:name)
  end
end
