class Incident < ApplicationRecord
  has_neighbors :embedding

  # This method is responsible for generating a summary of the incident and storing it in the database.
  # It uses the IncidentSummarizer and OpenaiClient classes to generate the summary.
  def generate_summary
    summarizer = IncidentSummarizer.new(self)
    openai_client = OpenAIClient.new(Rails.application.credentials.openai[:api_key])
    summary = openai_client.summarize(summarizer.system_prompt, summarizer.user_prompt)
    update(summary:)
  end

  # This method is responsible for generating an embedding of the incident summary and storing it in the database.
  # It uses the OpenAIClient class to generate the embedding. The embedding column is basically an array of floats.
  def generate_and_store_embedding
    openai_client = OpenAIClient.new(Rails.application.credentials.openai[:api_key])
    embedding = openai_client.generate_embedding(summary)
    update(embedding:)
  end

  # This method is responsible for processing the incident by generating a summary and an embedding in sequence.
  def process_incident
    generate_summary
    generate_and_store_embedding
  end
end
