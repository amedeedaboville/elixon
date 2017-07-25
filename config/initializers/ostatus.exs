use Mix.Config

port     =  3000
host     = "localhost:#{port}"
web_host =  host 
https    =  false

alternate_domains = ""# ENV.fetch('ALTERNATE_DOMAINS') { "" }

config :x,
  local_domain: host,
  web_domain: web_host,
  use_https: https,
  use_s3: false,
  alternate_domains: "",
  streaming_api_base_url: "ws://localhost:4000"

config :action_mailer,
  default_url_options: %{
    host: web_host, 
    protocol: case https do
      true -> "https://"
      false -> "http://"
    end,
    trailing_slash: false
  }
