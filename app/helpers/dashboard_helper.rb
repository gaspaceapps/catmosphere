module DashboardHelper

	def determine_image(category)
		case category
		when "Good"
			{ :cat => "excellent.png",
				:bg => "bg_good.png" }
		when "Moderate"
			{ :cat => "good.png",
				:bg => "bg_good.png" }
		when "Unhealthy for Sensitive Groups"
			{ :cat => "lightly_polluted.png",
				:bg => "bg_lightlypolluted.png" }
		when "Unhealthy"
			{ :cat => "lightly_polluted.png",
				:bg => "bg_lightlypolluted.png" }
		when "Very Unhealthy"
			{ :cat => "unhealthy.png",
				:bg => "bg_hazardous.png" }
		when "Hazardous"
			{ :cat => "hazardous.png",
				:bg => "bg_hazardous.png" }
		when "Unavailable"
			{ :cat => "unavailable.png",
				:bg => "bg_good.png" }
		end
	end

end
