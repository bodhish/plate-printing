class PrintJob < ApplicationRecord
  belongs_to :customer
  has_many :plate_jobs, inverse_of: :print_job, dependent: :destroy
  has_many :plate_dimensions, through: :plate_jobs
  belongs_to :assignee, class_name: 'User'
  belongs_to :delivered_by, class_name: 'User', optional: true
  belongs_to :delivery_note, optional: true

  accepts_nested_attributes_for :plate_jobs, reject_if: :all_blank, allow_destroy: true

  enum state: %w(Pending Printed Delivered)
  scope :d_note_printable, -> { where(state: 'Printed', delivery_note_id: nil) }

  def plate_job
    plate_jobs.where(is_wasted: false).last
  end

  def plate_dimension
    plate_job.plate_dimension
  end

  def wasted_plates
    plate_jobs.where(is_wasted: true)
  end
end
