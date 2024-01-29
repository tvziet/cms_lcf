Trestle.resource(:document_levels) do
  menu do
    item :document_levels, icon: 'fa fa-level-up', label: t('trestle.labels.document_levels')
  end

  table do
    column :name
    column :created_at, align: :center do |document_level|
      document_level.created_at.strftime('%d/%m/%Y')
    end
    column :updated_at, align: :center do |document_level|
      document_level.updated_at.strftime('%d/%m/%Y')
    end
    actions
  end

  form do
    text_field :name
  end

  params do |params|
    params.require(:document_level).permit(:name)
  end
end
