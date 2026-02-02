FROM alpine:latest
RUN apk add --no-cache curl unzip caddy
WORKDIR /app

# Download Xray
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip && chmod +x xray && rm -f xray.zip

# Copy အားလုံးကို Root ထဲထည့်မယ်
COPY . .

EXPOSE 8080

# Caddy ကို port 8081 မှာ run ပြီး index.html ကိုပြမယ်
# Xray က port 8080 ကနေ လက်ခံမယ်
CMD caddy file-server --listen :8081 --root /app & ./xray -config config.json
