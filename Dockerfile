# ./Dockerfile

# Extend from the official Elixir image.
FROM elixir:1.14.2

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Hex package manager.
# By using `--force`, we don’t need to type “Y” to confirm the installation.
RUN mix local.hex --force

# Compile the project.
RUN mix do compile

EXPOSE 4000

CMD ["/app/entrypoint.sh"]
