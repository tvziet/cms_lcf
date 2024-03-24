# frozen_string_literal: true

Trestle.resource(:documents) do
  menu do
    group t('trestle.groups.resources') do
      item :documents, icon: 'fa fa-file', label: t('trestle.labels.documents')
    end
  end

  to_param(&:slug)

  instance do |params|
    model.friendly.find(params[:id])
  end

  collection do
    params[:q].present? || (params[:scope].present? && params[:scope] != 'Tất cả') ? model : model.includes(:group)
  end

  search do |query|
    query ? collection.searchable(query) : collection
  end

  scopes do
    scope t('trestle.scopes.all'), lambda {
                                     Document.all
                                   }, label: t('trestle.scopes.all')
    scope t('trestle.scopes.filter_by_company'), lambda {
      Document.filter_by_company
    }, label: t('trestle.scopes.filter_by_company')

    scope t('trestle.scopes.filter_by_group'), lambda {
      Document.filter_by_group
    }, label: t('trestle.scopes.filter_by_group')

    scope t('trestle.scopes.filter_by_groups'), lambda {
      Document.filter_by_groups
    }, label: t('trestle.scopes.filter_by_groups')
  end

  table do
    column :title

    column :company_id, align: :center do |document|
      if document.company_id.present?
        safe_join([
                    content_tag(:strong, Company.find_by(id: document.company_id)&.name, class: 'text-muted hidden-xs')
                  ], '<br />'.html_safe)
      else
        '-'
      end
    end

    column :group_ids, align: :center do |document|
      if document.group_ids.present?
        safe_join([
                    content_tag(:strong, document.inter_groups.map(&:name).compact.join(', '), class: 'text-muted hidden-xs')
                  ], '<br />'.html_safe)
      else
        '-'
      end
    end

    column :group_id, align: :center do |document|
      if document.group_id.present?
        safe_join([
                    content_tag(:strong, document.group&.name, class: 'text-muted hidden-xs')
                  ], '<br />'.html_safe)
      else
        '-'
      end
    end

    column :created_at, align: :center do |document|
      document.created_at.strftime('%d/%m/%Y')
    end

    column :updated_at, align: :center do |document|
      document.updated_at.strftime('%d/%m/%Y')
    end

    actions do |toolbar, _instance, admin|
      if (admin&.actions&.include?(:edit) && current_administrator.high_level?) || current_administrator.medium_level?
        toolbar.edit
        toolbar.delete
      end
    end
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

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def update
      document_level = DocumentLevel.find_by(id: params[:document][:document_level_id])
      update_attributes = case document_level.slug
                          when 'tai-lieu-cap-1'
                            { group_ids: [], group_id: nil, company_id: params[:document][:company_id],
                              document_level_id: params[:document][:document_level_id] }
                          when 'tai-lieu-cap-2'
                            { group_ids: params[:document][:group_ids], group_id: nil, company_id: nil,
                              document_level_id: params[:document][:document_level_id] }
                          when 'tai-lieu-cap-3'
                            { group_ids: [], group_id: params[:document][:group_id], company_id: nil,
                              document_level_id: params[:document][:document_level_id] }
                          when 'tai-lieu-cap-4'
                            { group_ids: [], group_id: nil, company_id: nil,
                              document_level_id: params[:document][:document_level_id] }
                          end
      if instance.update(update_attributes)
        flash[:message] = flash_message('update.success', title: 'Success!',
                                                          message: 'The %<lowercase_model_name>s was successfully updated.')
        redirect_to_return_location(:update, instance, default: admin.instance_path(instance))
      else
        flash.now[:error] =
          flash_message('update.failure', title: 'Warning!',
                                          message: 'Please correct the errors below.')
        render 'show', status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end

  form do |document|
    row do
      col(sm: 12) { text_field :title }
    end

    row do
      col(sm: 12) { editor :body }
    end

    if document.persisted?
      row do
        col(sm: 12) { select :employee_ids, Employee.all, { label: t('trestle.forms.employees') }, multiple: true }
      end
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
    params.require(:document).permit(:title, :body, :document_level_id, :company_id, :group_id, group_ids: [])
  end

  routes do
    collection do
      get :document_level
      get :document_level_default
    end
  end
end
