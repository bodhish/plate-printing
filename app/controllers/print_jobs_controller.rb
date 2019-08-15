class PrintJobsController < HomeController
  def new
    @print_job = PrintJob.new
  end

  def index

  end

  def create
    job = PrintJob.new(create_params)
    if job.save!
      job.plate_jobs.create!(create_params[:plate_job])
      flash[:success] = 'Job created successfully'
      redirect_to print_job_path (job)
    else
      flash[:success] = 'Error'
      render new
    end
  end

  def show

  end

  private

  def create_params
    params.require(:print_job).permit(:ref_no, :name, :customer_id, :comments, :plate_job)
  end

end