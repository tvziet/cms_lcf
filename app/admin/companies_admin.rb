# frozen_string_literal: true

Trestle.resource(:companies) do
  to_param(&:slug)

  instance do |params|
    model.friendly.find(params[:id])
  end

  search do |query|
    query ? collection.searchable(query) : collection
  end

  menu do
    group t('trestle.groups.resources') do
      item :companies, icon: 'fa fa-building', label: t('trestle.labels.companies')
    end
  end

  table do
    column :name, link: true, sort: :name

    column :logo, align: :center do |company|
      if company.logo?
        image_tag(company.logo_url(:thumb),
                  loading: 'lazy')
      end
    end

    column :num_of_employees, align: :center, header: I18n.t('trestle.headers.num_of_employees') do |company|
      company&.num_of_employees
    end

    column :created_at, align: :center do |company|
      company.created_at.strftime('%d/%m/%Y')
    end

    column :updated_at, align: :center do |company|
      company.updated_at.strftime('%d/%m/%Y')
    end

    actions do |toolbar, _instance, admin|
      if (admin&.actions&.include?(:edit) && current_administrator.high_level?) || current_administrator.medium_level?
        toolbar.edit
        toolbar.delete
      end
    end
  end

  form do |company|
    tab :general_info, label: t('trestle.tabs.general_info') do
      row do
        col(sm: 12) { text_field :name }
      end

      row do
        col(sm: 12) { file_field :logo }
      end
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
    params.require(:company).permit(:name, :logo)
  end
end
