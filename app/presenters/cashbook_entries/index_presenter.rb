module CashbookEntries
  class IndexPresenter < ::ApplicationPresenter

    def date_from
      @date_from ||= params[:filter].try(:[], :date_from) ? Time.zone.strptime(params[:filter][:date_from], '%d-%m-%Y') : Time.zone.now
    end

    def date_to
      @date_to ||= params[:filter].try(:[], :date_to) ? Time.zone.strptime(params[:filter][:date_to], '%d-%m-%Y') : Time.zone.now
    end

    def opening_balance
      CashbookEntry.where('created_at < ?', date_from.beginning_of_day).sum(:amount)
    end

    def closing_balance
      CashbookEntry.where('created_at < ?', date_to.end_of_day).sum(:amount)
    end

    def cashbook_entries
      @cashbook_entries ||= CashbookEntry.where(created_at: date_window)
    end

    def amount_classes(amount)
      amount.negative? ? 'text-red-500' : 'text-green-500'
    end

    private

    def date_window
      date_from.beginning_of_day..date_to.end_of_day
    end
  end
end
