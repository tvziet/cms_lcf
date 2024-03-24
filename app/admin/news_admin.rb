Trestle.resource(:news) do
  menu do
    group t('trestle.groups.resources') do
      item :news, icon: 'fa fa-newspaper-o', label: t('trestle.labels.news')
    end
  end

  to_param(&:slug)

  instance do |params|
    model.friendly.find(params[:id])
  end

  table do
    column :title

    column :body do |news|
      news.body.html_safe
    end

    column :company_id, align: :center do |news|
      if news.company_id
        safe_join([
                    content_tag(:strong, Company.where(id: news.company_id).map(&:name)&.join(', '), class: 'text-muted hidden-xs')
                  ], '<br />'.html_safe)
      else
        '-'
      end
    end

    column :group_ids, align: :center do |news|
      if news.group_ids.present?
        safe_join([
                    content_tag(:strong, Group.where(id: news.group_ids).map(&:name)&.join(', '), class: 'text-muted hidden-xs')
                  ], '<br />'.html_safe)
      else
        '-'
      end
    end

    column :published_at, align: :center do |news|
      news.published_at.strftime('%d/%m/%y')
    end

    column :public

    column :status, sort: :status, align: :center do |news|
      status_tag(news.value(:statuses, news.status),
                 { 'Đã xuất bản' => :success, 'Nháp' => :danger }[news.value(:statuses, news.status)] || :default)
    end

    column :created_at, align: :center do |news|
      news.created_at.strftime('%d/%m/%y')
    end

    column :updated_at, align: :center do |news|
      news.updated_at.strftime('%d/%m/%y')
    end

    actions do |toolbar, _instance, admin|
      if (admin&.actions&.include?(:edit) && current_administrator.high_level?) || current_administrator.medium_level?
        toolbar.edit
        toolbar.delete
      end
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
      col(sm: 12) { select(:status, News.values(:statuses)) }
    end

    row do
      col(sm: 12) { datetime_field :published_at }
    end

    row(class: 'check-box-news') do
      col(sm: 12) { check_box :public, data: { id: 'public_mode' } }
    end

    row do
      col(sm: 12) do
        collection_select(:company_id, Company.all, :id, :name, include_blank: true)
      end
    end

    row do
      col(sm: 12) { select :group_ids, Group.all, { label: t('trestle.forms.groups') }, multiple: true }
    end
  end

  params do |params|
    params.require(:news).permit(:title, :body, :status, :published_at, :public, :company_id, group_ids: [])
  end
end
