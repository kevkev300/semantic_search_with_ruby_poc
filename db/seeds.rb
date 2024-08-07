# Clear existing incidents
Incident.destroy_all

# Create sample incidents
incidents = [
  {
    name: 'Database Performance Issue 1',
    description: 'Users reported slow response times when querying the database. Investigation showed high CPU usage on the database server.',
    resolution: 'Optimized slow-running queries and added appropriate indexes to improve performance.'
  },
  {
    name: 'Network Outage',
    description: 'All services became unreachable due to a network failure. Investigation showed a core router had failed.',
    resolution: 'Replaced the faulty router and restored network connectivity. Implemented redundant routing to prevent future single points of failure.'
  },
  {
    name: 'non fit',
    description: 'I do not fit to anything',
    resolution: 'Totally obsolete and should not be nearest neighbor to anything'
  }
]

# Create incidents, generate summaries and embeddings
incidents.each do |incident_data|
  incident = Incident.create!(incident_data)
  incident.process_incident
  puts "Processed incident: #{incident.name}"
end

puts 'Seed data created successfully!'
