# frozen_string_literal: true

Trestle.resource(:document_levels) do
  menu do
    group t('trestle.groups.resources') do
      item :document_levels, icon: 'fa fa-level-up', label: t('trestle.labels.document_levels')
    end
  end

  table do
    column :name

    column :num_of_documents, align: :center, header: I18n.t('trestle.headers.num_of_documents') do |document_level|
      document_level&.documents_count
    end

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
    params.require(:document_level).permit(:name, :document_id)
  end
end
