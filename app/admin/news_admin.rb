Trestle.resource(:news) do
  menu do
    group t('trestle.groups.resources') do
      item :news, icon: 'fa fa-newspaper-o', label: t('trestle.labels.news')
    end
  end

  table do
    column :title

    column :body do |news|
      news.body.html_safe
    end

    column :company_id

    column :group_ids

    column :published_at, align: :center

    column :public

    column :status do |news|
      news.value(:statuses, news.status)
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
      col(sm: 12) { check_box :public, data: { id: 'concac'} }
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
