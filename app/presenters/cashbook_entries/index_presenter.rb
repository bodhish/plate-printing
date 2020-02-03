module CashbookEntries
  class IndexPresenter < ::ApplicationPresenter

    def date_from
      @date_from ||= params[:filter].try(:[], :date_from) ? Time.zone.strptime(params[:filter][:date_from], '%d-%m-%Y') : Time.zone.now
    end

    def date_to
      @date_to ||= params[:filter].try(:[], :date_to) ? Time.zone.strptime(params[:filter][:date_to], '%d-%m-%Y') : Time.zone.now
    end

    def category_id
      @category_id ||= params[:filter].try(:[], :category_id) ? params[:filter][:category_id] : ""
    end

    def categories
      category_id.present? ? category_id.to_i : CashbookCategory.all.pluck(:id)
    end

    def opening_balance
      CashbookEntry.where('recorded_at < ?', date_from.beginning_of_day).sum(:amount)
    end

    def closing_balance
      CashbookEntry.where('recorded_at < ?', date_to.end_of_day).sum(:amount)
    end

    def cashbook_entries
      @cashbook_entries ||= begin
        category_id.present? ? CashbookCategory.where(id: category_id.to_i) : CashbookCategory.all.pluck(:id)
        CashbookEntry.where(recorded_at: date_window, category_id: categories).order(:recorded_at).reverse
      end
    end

    def amount_classes(amount)
      amount.negative? ? 'text-red-500' : 'text-green-500'
    end

    def category_dropdown_options
      CashbookCategory.all.order(:name).map { |c| [c.name, c.id] }
    end

    private

    def date_window
      date_from.beginning_of_day..date_to.end_of_day
    end
  end
end
