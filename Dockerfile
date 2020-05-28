FROM ubuntu

ENV DOTNET_CLI_TELEMETRY_OPTOUT=true

# Set up needed tools
RUN apt-get update 
RUN apt-get install -y wget
RUN apt-get install -y apt-transport-https
RUN wget https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb
RUN apt-get install -y ./packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y dotnet-sdk-3.1

# Copy and install dotnet-format (built beforehand)
WORKDIR /source
COPY format/ format/
WORKDIR /source/format
RUN dotnet tool install --add-source ./artifacts/packages/Debug/Shipping -g dotnet-format --version 4.0.0-dev
ENV PATH="/root/.dotnet/tools:${PATH}"
# Entrypoint
CMD bash
