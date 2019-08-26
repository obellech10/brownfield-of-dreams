namespace :videos do
  desc:"Update Positions"
  task update_positions: :environment do
    Video.all.each do |video|
      video.position = 0
      video.save
    end
  end
  p "Video positions have been updated."
end
