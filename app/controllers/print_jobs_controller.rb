class PrintJobsController < HomeController
  def new
    @print_job = PrintJob.new
  end

  def index
    @print_jobs = PrintJob.all
  end

  def create
    job = PrintJob.new(create_params)
    if job.save!
      job.plate_jobs.create!(plate_job_params[:plate_job])
      flash[:success] = 'Job created successfully'
      redirect_to root_path
    else
      flash[:success] = 'Error'
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
      redirect_to print_job_path (print_job)
    else
      flash[:success] = 'Error'
      render edit
    end
  end

  private

  def create_params
    params.require(:print_job).permit(:ref_no, :name, :customer_id, :comments)
  end

  def update_params
    params.require(:print_job).permit(:ref_no, :name, :customer_id, :comments, :status)
  end

  def plate_job_params
    params.require(:print_job).permit(plate_job: [:plate_dimension_id])
  end

end