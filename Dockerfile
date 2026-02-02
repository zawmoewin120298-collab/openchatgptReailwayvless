FROM alpine:latest

# လိုအပ်သော Tools များနှင့် Caddy (Web Server) သွင်းခြင်း
RUN apk add --no-cache curl unzip caddy

WORKDIR /app

# Xray core ကို download ဆွဲခြင်း
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip \
    && chmod +x xray \
    && rm -f xray.zip

# File များ copy ကူးခြင်း
COPY config.json /app/config.json
COPY index.html /app/index.html

# Port 8080 ကို အသုံးပြုမည်
EXPOSE 8080

# Caddy ကို နောက်ကွယ်ကပတ်ပြီး Xray ကိုပါ တစ်ခါတည်း run မည့် script
CMD caddy file-server --listen :8081 --root /app & ./xray -config config.json
