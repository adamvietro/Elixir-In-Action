Mix.install([{:jason, "~> 1.4"}]) # Installs the Jason dependency
input = hd(System.argv())
decoded = Jason.decode!(input) # Uses the Jason library
IO.inspect(decoded)
