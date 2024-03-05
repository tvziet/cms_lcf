# frozen_string_literal: true

Trestle.resource(:documents) do
  menu do
    item :documents, icon: 'fa fa-file', label: t('trestle.labels.documents')
  end

  table do
    column :title
    column :created_at, align: :center do |document|
      document.created_at.strftime('%d/%m/%Y')
    end
    column :updated_at, align: :center do |document|
      document.updated_at.strftime('%d/%m/%Y')
    end
    actions
  end

  controller do
    def document_level
      groups = Group.all
      render json: groups.map { |group| { id: group.id, name: group.name } }
    end

    def document_level_default
      companies = Company.all
      render json: companies.map { |company| { id: company.id, name: company.name } }
    end
  end

  form do
    row do
      col(sm: 12) { text_field :title }
    end

    row do
      col(sm: 12) { editor :body }
    end

    row do
      col(sm: 12) { collection_select :document_level_id, DocumentLevel.all, :id, :name }
    end

    row do
      col(sm: 12) { collection_select :company_id, Company.all, :id, :name }
    end

    row do
      col(sm: 12) { select :group_ids, Group.all, { label: t('trestle.forms.groups') }, multiple: true }
    end

    row do
      col(sm: 12) { collection_select :group_id, Group.all, :id, :name }
    end
  end

  params do |params|
    params.require(:document).permit(:title, :body, :document_level_id)
  end

  routes do
    collection do
      get :document_level
      get :document_level_default
    end
  end
end
