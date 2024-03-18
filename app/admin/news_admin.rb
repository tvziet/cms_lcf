Trestle.resource(:news) do
  menu do
    group t('trestle.groups.resources') do
      item :news, icon: 'fa fa-newspaper-o', label: t('trestle.labels.news')
    end
  end

  table do
    column :title
    column :body
    column :company_id
    column :group_ids
    column :published_at, align: :center
    column :public
    column :status
    column :created_at, align: :center
    column :updated_at, align: :center
    actions
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

    row do
      col(sm: 12) { check_box :public }
    end

    row do
      col(sm: 12) { select(:company_id, Company.all) }
    end

    row do
      col(sm: 12) { select(:group_ids, Group.all) }
    end
  end

  params do |params|
    params.require(:news).permit(:title, :body, :status, :published_at, :public, :company_id, group_ids: [])
  end
end
