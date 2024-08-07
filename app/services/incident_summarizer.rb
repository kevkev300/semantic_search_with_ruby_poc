class IncidentSummarizer
  def initialize(incident)
    @incident = incident
  end

  def system_prompt
    'You are an expert at summarizing IT incidents. Create a brief summary of the incident described below.'
  end

  def user_prompt
    <<~PROMPT
      Incident: #{@incident.name}
      Description: #{@incident.description}
      Resolution: #{@incident.resolution}
    PROMPT
  end
end
