require 'net/http'
require 'json'

class OpenAIClient
  OPENAI_EMBEDDING_API_URL = 'https://api.openai.com/v1/embeddings'
  OPENAI_CHAT_API_URL = 'https://api.openai.com/v1/chat/completions'

  def initialize(api_key)
    @api_key = api_key
  end

  def summarize(system_prompt, user_prompt)
    response = chat_connection.post do |req|
      req.body = {
        model: 'gpt-3.5-turbo',
        messages: [
          {
            role: 'system',
            content: system_prompt
          },
          {
            role: 'user',
            content: user_prompt
          }
        ]
      }.to_json
    end

    JSON.parse(response.body)['choices'].first['message']['content']
  end

  def generate_embedding(text)
    response = embedding_connection.post do |req|
      req.body = {
        model: 'text-embedding-3-small',
        input: text
      }.to_json
    end

    JSON.parse(response.body)['data'][0]['embedding']
  end

  private

  def embedding_connection
    Faraday.new(url: OPENAI_EMBEDDING_API_URL) do |f|
      f.headers['Content-Type'] = 'application/json'
      f.headers['Authorization'] = "Bearer #{@api_key}"
    end
  end

  def chat_connection
    Faraday.new(url: OPENAI_CHAT_API_URL) do |f|
      f.headers['Content-Type'] = 'application/json'
      f.headers['Authorization'] = "Bearer #{@api_key}"
    end
  end
end
