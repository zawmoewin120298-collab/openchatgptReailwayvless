FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache curl unzip

# Download Xray
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip \
    && chmod +x xray \
    && rm -f xray.zip

COPY config.json /app/config.json

EXPOSE 8080

CMD ["./xray", "-config", "config.json"]
