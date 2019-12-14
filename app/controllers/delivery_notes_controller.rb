class DeliveryNotesController < ApplicationController
  def index
    @delivery_notes = DeliveryNote.includes(:print_jobs).order(updated_at: :desc).map do |note|
      {
        number: note.number,
        date: note.updated_at.strftime('%b %e'),
        customer_name: note.print_jobs.first.customer.name,
        jobs: note.print_jobs.map(&:name).join(', ')
      }
    end
  end

  def create
    DeliveryNote.transaction do
      d = DeliveryNote.new(number: params[:delivery_note][:number])
      print_jobs = PrintJob.where(id: params[:delivery_note][:print_jobs].reject(&:empty?))
      d.print_jobs = print_jobs
      print_jobs.exists? && d.save! ? (flash[:success] = 'Delivery note created successfully!') : (flash[:error] = 'Something went wrong. Please try again!')
      redirect_to delivery_notes_path
    end
  end

  def show
    respond_to do |format|
      format.pdf do
        pdf = DeliveryNoteGenerator.new(params[:id]).raw
        send_data pdf.render,
                  filename: "delivery_note_#{params[:id]}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def preview
    respond_to do |format|
      format.pdf do
        pdf = DeliveryNoteGenerator.new(params[:id]).preview
        send_data pdf.render,
                  filename: "delivery_note_#{params[:id]}_preview.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end
end
