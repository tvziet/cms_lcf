Trestle.resource(:companies) do
  menu do
    item :companies, icon: 'fa fa-building', label: t('trestle.labels.companies')
  end

  table do
    column :name
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
