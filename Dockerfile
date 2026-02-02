FROM alpine:latest

RUN apk add --no-cache curl unzip caddy

WORKDIR /app

# Xray install
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip && chmod +x xray && rm -f xray.zip

COPY . .

# Railway ရဲ့ PORT variable ကို သုံးဖို့ EXPOSE လုပ်ထားမယ်
EXPOSE 8080

# Caddy နဲ့ Xray ကို အတူတူ run မယ် (Caddy က index.html ကို port 8080 မှာ ပြပေးမှာပါ)
CMD ./xray -config config.json & caddy file-server --listen :8080 --root /app
