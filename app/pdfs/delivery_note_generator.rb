class DeliveryNoteGenerator
  include Prawn::View
  require "prawn/measurement_extensions"

  def initialize(delivery_note_number)
    @delivery_note = DeliveryNote.find_by(number: delivery_note_number)
  end

  def raw
    d_n = @delivery_note
    Prawn::Document.new(page_size: "A5", page_layout: :landscape, margin: 0) do
      move_down (3.45).cm
      font "Courier"
      indent(3.cm) { text "#{d_n.number}" + " "*45 + d_n.created_at.strftime('%b %e, %Y') }
      move_down (0.4).cm
      indent(3.cm) { text "#{d_n.print_jobs.first.customer.name}" }
      move_down (1.25).cm
      font_size 10

      bounding_box([45, 250], width: 40, height: 110) do
        stroke_bounds
        stroke_axis
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text pj.plate_dimension.name, align: :center
            move_down (0.25).cm
          end
        end
      end

      bounding_box([100, 250], width: 350, height: 110) do
        stroke_bounds
        stroke_axis
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text job.name
            move_down (0.25).cm
          end
        end
      end

      bounding_box([450, 250], width: 50, height: 110) do
        stroke_bounds
        stroke_axis
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text "#{pj.set} x #{pj.color}", align: :center
            move_down (0.25).cm
          end
        end
      end

      bounding_box([510, 250], width: 50, height: 110) do
        stroke_bounds
        stroke_axis
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text (pj.set * pj.color).to_s, align: :center
            move_down (0.25).cm
          end
        end
      end

      bounding_box([510, 129], width: 50, height: 12) do
        stroke_bounds
        stroke_axis
        n = 0
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            n += pj.set * pj.color
          end
        end
        text n.to_s, align: :center
      end
    end
  end

  def preview
    d_n = @delivery_note
    Prawn::Document.new(page_size: "A5", page_layout: :landscape, margin: 0) do
      image "public/delivery_note.png", at: [0, PDF::Core::PageGeometry::SIZES["A5"][0]], fit: PDF::Core::PageGeometry::SIZES["A5"].reverse
      move_down (3.45).cm
      font "Courier"
      indent(3.cm) { text "#{d_n.number}" + " "*45 + d_n.created_at.strftime('%b %e, %Y') }
      move_down (0.4).cm
      indent(3.cm) { text "#{d_n.print_jobs.first.customer.name}" }
      move_down (1.25).cm
      font_size 10

      bounding_box([45, 250], width: 40, height: 110) do
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text pj.plate_dimension.name, align: :center
            move_down (0.25).cm
          end
        end
      end

      bounding_box([100, 250], width: 350, height: 110) do
        # stroke_axis
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text "#{pj.plate_dimension.dimension} - #{job.name}"
            move_down (0.25).cm
          end
        end
      end

      bounding_box([450, 250], width: 50, height: 110) do
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text "#{pj.set} x #{pj.color}", align: :center
            move_down (0.25).cm
          end
        end
      end

      bounding_box([510, 250], width: 50, height: 110) do
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            text (pj.set * pj.color).to_s, align: :center
            move_down (0.25).cm
          end
        end
      end

      bounding_box([510, 129], width: 50, height: 12) do
        n = 0
        d_n.print_jobs.each do |job|
          job.plate_usages.each do |pj|
            n += pj.set * pj.color
          end
        end
        text n.to_s, align: :center
      end
    end
  end
end