FROM alpine:latest

# Web Server (Caddy) နှင့် Xray အတွက် လိုအပ်သည်များ သွင်းခြင်း
RUN apk add --no-cache curl unzip caddy

WORKDIR /app

# Xray ကို Download ဆွဲခြင်း
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip && chmod +x xray && rm -f xray.zip

# သင့်ရဲ့ Repo ထဲက HTML, CSS, Config ဖိုင်အားလုံးကို /app ထဲ ကူးထည့်ခြင်း
COPY . .

# Port 8080 ကို အဓိက သုံးမည်
EXPOSE 8080

# Caddy ကို Port 8081 မှာ run ခိုင်းပြီး index.html ကို ပြခိုင်းမည်
# Xray ကို Port 8080 မှာ run ခိုင်းမည်
CMD caddy file-server --listen :8081 --root /app & ./xray -config config.json
