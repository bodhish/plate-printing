class CashbookEntriesController < HomeController
  def new
    @cashbook_entry = CashbookEntry.new
  end

  def index
    @cashbook_entries = CashbookEntry.all.reverse
  end

  def create
    cashbook_entry = CashbookEntry.new(create_params.merge!(recorded_by: current_user, recorded_at: DateTime.now))
    if cashbook_entry.save!
      flash[:success] = 'Cashbook entry created successfully'
      redirect_to cashbook_path
    else
      flash[:error] = 'Error'
      render new
    end
  end

  def edit
    @cashbook_entry = CashbookEntry.find(params[:id])
  end

  def update

    cashbook_entry = CashbookEntry.find(params[:id])

    if cashbook_entry.update!(update_params)
      flash[:success] = 'Cashbook entry updated successfully'
      redirect_to cashbook_path
    else
      flash[:error] = 'Error'
      render edit
    end
  end

  private

  def create_params
    params.require(:cashbook_entry).permit(:particular, :amount, :category_id)
  end

  def update_params
    params.require(:cashbook_entry).permit(:particular, :amount, :category_id)
  end
end