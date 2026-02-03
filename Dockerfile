FROM alpine:latest

# လိုအပ်သော packages များသွင်းခြင်း
RUN apk add --no-cache curl unzip caddy

WORKDIR /app

# Xray core install လုပ်ခြင်း
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip && chmod +x xray && rm -f xray.zip

# လက်ရှိဖိုင်များအားလုံးကို copy ကူးခြင်း
COPY . .

# Railway PORT ကို အသုံးပြုရန်
EXPOSE 8080

# Caddy (Web) နဲ့ Xray ကို တစ်ပြိုင်တည်း run ရန် (Caddy ကို port 8081 မှာ run ပြီး Xray က 8080 ကနေ fallback လုပ်ပါမယ်)
CMD ./xray -config config.json & caddy file-server --listen :8081 --root /app
