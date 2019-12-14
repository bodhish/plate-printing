class Customer < ApplicationRecord
  has_many :print_jobs

  def d_note_printable_jobs
    print_jobs.d_note_printable
  end
end
