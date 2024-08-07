class SearchTest
  def self.call
    # Find an incident to use as a reference
    reference_incident = Incident.find_by(name: 'Database Performance Issue 1')

    # Find similar incidents
    similar_incidents = reference_incident.nearest_neighbors(:embedding, distance: 'cosine').first(1)

    puts "Incidents similar to '#{reference_incident.name}':"
    similar_incidents.each do |similar_incident|
      puts "- #{similar_incident.name} (Distance: #{similar_incident.neighbor_distance.round(2)})"
      puts "  Summary: #{similar_incident.summary}"
    end
  end
end
