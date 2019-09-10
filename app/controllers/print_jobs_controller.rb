class PrintJobsController < HomeController
  def new
    @print_job = PrintJob.new
  end

  def index
    @print_jobs = PrintJob.all.reverse
  end

  def create
    job = PrintJob.new(create_params.merge!(assignee: current_user))
    if job.save!
      # job.plate_jobs.create!(plate_job_params[:plate_job])
      flash[:success] = 'Job created successfully'
      redirect_to root_path
    else
      flash[:error] = 'Error'
      render new
    end
  end

  def show
    @print_job = PrintJob.find(params[:id])
  end

  def edit
    @print_job = PrintJob.find(params[:id])
  end

  def update

    print_job = PrintJob.find(params[:id])

    if print_job.update!(update_params)
      flash[:success] = 'Job updated successfully'
      redirect_to root_path
    else
      flash[:error] = 'Error'
      render edit
    end
  end

  def mark_printed
    print_job = PrintJob.find(params[:print_job_id])

    if print_job.update!(state: 'Printed')
      flash[:success] = 'Job marked printed!'
    else
      flash[:error] = 'Error'
    end

    redirect_to root_path
  end

  def delivery_note_form
    @print_job = PrintJob.find(params[:print_job_id])
  end

  def mark_delivered
    print_job = PrintJob.find(params[:print_job_id])

    if print_job.update!(mark_delivered_params.merge!(state: 'Delivered', delivered_by: current_user, delivered_at: Time.zone.now))
      flash[:success] = 'Job marked delivered!'
    else
      flash[:error] = 'Error. Try again!'
    end

    redirect_to root_path
  end

  private

  def create_params
    params.require(:print_job).permit(:ref_no, :name, :customer_id, :comments, plate_jobs_attributes: [:id, :plate_dimension_id, :set, :color, :wastage, :destroy])
  end

  def update_params
    params.require(:print_job).permit(:ref_no, :name, :customer_id, :comments, :status, plate_jobs_attributes: [:id, :plate_dimension_id, :set, :color, :wastage, :destroy])
  end

  def plate_job_params
    params.require(:print_job).permit(plate_job: [:plate_dimension_id])
  end

  def mark_delivered_params
    params.require(:print_job).permit(:delivery_note_no, :comments)
  end
end